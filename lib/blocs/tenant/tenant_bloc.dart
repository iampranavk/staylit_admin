import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:staylit_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'tenant_event.dart';
part 'tenant_state.dart';

class TenantBloc extends Bloc<TenantEvent, TenantState> {
  TenantBloc() : super(TenantInitialState()) {
    on<TenantEvent>((event, emit) async {
      emit(TenantLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('profiles');
      SupabaseQueryBuilder roomTable = supabaseClient.from('rooms');

      try {
        if (event is GetAllTenantEvent) {
          List<dynamic> temp =
              await queryTable.select('*').order('created_at', ascending: true);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> profiles = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          for (int i = 0; i < profiles.length; i++) {
            Map<String, dynamic>? room = await roomTable
                .select()
                .eq('occuppied_by', profiles[i]['user_id'])
                .maybeSingle();
            if (room != null) {
              profiles[i]['room'] = room;
            } else {
              profiles[i]['room'] = null;
            }
          }

          emit(TenantSuccessState(tenants: profiles));
        } else if (event is AddTenantEvent) {
          UserResponse userDetails = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.email,
              password: event.password,
              emailConfirm: true,
              userMetadata: {
                'status': 'active',
              },
            ),
          );
          if (userDetails.user != null) {
            await queryTable.insert({
              'user_id': userDetails.user!.id,
              'name': event.name,
              'phone': event.phone,
              'email': userDetails.user!.email,
            });

            await roomTable.update(
              {
                'occuppied_by': userDetails.user!.id,
              },
            ).eq('id', event.roomId);

            add(GetAllTenantEvent());
          } else {
            emit(TenantFailureState());
          }
        } else if (event is EditTenantEvent) {
          AdminUserAttributes attributes =
              AdminUserAttributes(email: event.email, emailConfirm: true);

          if (event.password != null) {
            attributes.password = event.password;
          }

          UserResponse userDetails =
              await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: attributes,
          );
          if (userDetails.user != null) {
            await queryTable.update({
              'name': event.name,
              'phone': event.phone,
              'email': event.email,
            }).eq('user_id', event.userId);

            if (event.roomId != null) {
              await roomTable.delete().eq('occuppied_by', userDetails.user!.id);
              await roomTable.update({
                'occuppied_by': userDetails.user!.id,
              }).eq('id', event.roomId);
            }

            add(GetAllTenantEvent());
          } else {
            emit(TenantFailureState());
          }
        } else if (event is DeleteTenantEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllTenantEvent());
        } else if (event is ChangeStatusTenantEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              // banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllTenantEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(TenantFailureState(message: e.toString()));
      }
    });
  }
}
