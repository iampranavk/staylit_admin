import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'floor_event.dart';
part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  FloorBloc() : super(FloorInitialState()) {
    on<FloorEvent>((event, emit) async {
      emit(FloorLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('floors');
      try {
        if (event is GetAllFloorEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('floor', '%${event.query}%')
                  .order("floor", ascending: true)
              : await queryTable.select().order(
                    'created_at',
                  );

          List<Map<String, dynamic>> floors =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            FloorSuccessState(
              floors: floors,
            ),
          );
        } else if (event is AddFloorEvent) {
          await queryTable.insert({
            'floor': event.name,
          });
          add(GetAllFloorEvent());
        } else if (event is DeleteFloorEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllFloorEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(FloorFailureState());
      }
    });
  }
}
