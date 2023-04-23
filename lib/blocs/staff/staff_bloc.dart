import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:staylit_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffInitialState()) {
    on<StaffEvent>((event, emit) async {
      emit(StaffLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('staffs');

      try {
        if (event is GetAllStaffEvent) {
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

          emit(StaffSuccessState(staffs: profiles));
        } else if (event is AddStaffEvent) {
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

            add(GetAllStaffEvent());
          } else {
            emit(StaffFailureState());
          }
        } else if (event is EditStaffEvent) {
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

            add(GetAllStaffEvent());
          } else {
            emit(StaffFailureState());
          }
        } else if (event is DeleteStaffEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllStaffEvent());
        } else if (event is ChangeStatusStaffEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              // banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllStaffEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(StaffFailureState(message: e.toString()));
      }
    });
  }
}
