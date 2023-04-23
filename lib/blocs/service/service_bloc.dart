import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  ServiceBloc() : super(ServiceInitialState()) {
    on<ServiceEvent>((event, emit) async {
      emit(ServiceLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('services');
      try {
        if (event is GetAllServiceEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select('*')
                  .ilike('service', '%${event.query}%')
                  .order("service", ascending: true)
              : await queryTable.select('*').order(
                    'created_at',
                  );

          List<Map<String, dynamic>> services =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            ServiceSuccessState(
              services: services,
            ),
          );
        } else if (event is AddServiceEvent) {
          String path = await supabaseClient.storage.from('docs').uploadBinary(
                'services/${DateTime.now().millisecondsSinceEpoch.toString()}${event.file.name}',
                event.file.bytes!,
              );

          path = path.replaceRange(0, 5, '');

          await queryTable.insert({
            'service': event.name,
            'price': event.price,
            'image_url': supabaseClient.storage.from('docs').getPublicUrl(path),
          });
          add(GetAllServiceEvent());
        } else if (event is EditServiceEvent) {
          if (event.file != null) {
            String path =
                await supabaseClient.storage.from('docs').uploadBinary(
                      'services/${DateTime.now().millisecondsSinceEpoch.toString()}${event.file!.name}',
                      event.file!.bytes!,
                    );

            path = path.replaceRange(0, 5, '');
            await queryTable.update({
              'service': event.name,
              'price': event.price,
              'image_url':
                  supabaseClient.storage.from('docs').getPublicUrl(path),
            }).eq('id', event.serviceId);
          } else {
            await queryTable.update({
              'service': event.name,
              'price': event.price,
            }).eq('id', event.serviceId);
          }

          add(GetAllServiceEvent());
        } else if (event is DeleteServiceEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllServiceEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ServiceFailureState());
      }
    });
  }
}
