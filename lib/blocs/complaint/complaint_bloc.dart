import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitialState()) {
    on<ComplaintEvent>((event, emit) async {
      emit(ComplaintLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('complaints');
      try {
        if (event is GetAllComplaintEvent) {
          List<dynamic> temp = await queryTable.select().order('created_at');

          List<Map<String, dynamic>> complaints =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (int i = 0; i < complaints.length; i++) {
            if (complaints[i]['service_request_id'] != null) {
            } else {
              complaints[i]['serviceRequest'] = null;
            }
          }
          emit(
            ComplaintSuccessState(
              complaints: complaints,
            ),
          );
        } else if (event is AddComplaintEvent) {
          await queryTable.insert(
            {
              'user_id': supabaseClient.auth.currentUser!.id,
              'complaint': event.complaint,
            },
          );

          add(GetAllComplaintEvent());
        } else if (event is DeleteComplaintEvent) {
          await queryTable.delete().eq('id', event.complaintId);
          add(GetAllComplaintEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(ComplaintFailureState());
      }
    });
  }
}
