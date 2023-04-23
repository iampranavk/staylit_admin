import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitialState()) {
    on<RoomEvent>((event, emit) async {
      emit(RoomLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('rooms');
      try {
        if (event is GetAllRoomEvent) {
          List<dynamic> temp = [];

          if (event.query != null && event.floorId != null) {
            temp = await queryTable
                .select('*')
                .ilike('room_no', '%${event.query}%')
                .eq('floor_id', event.floorId)
                .order('room_no', ascending: true);
          } else if (event.floorId != null) {
            temp = await queryTable
                .select('*')
                .eq('floor_id', event.floorId)
                .order('room_no', ascending: true);
          } else if (event.query != null) {
            temp = await queryTable
                .select('*')
                .ilike('room_no', '%${event.query}%')
                .order('room_no', ascending: true);
          } else {
            temp =
                await queryTable.select('*').order('room_no', ascending: true);
          }

          List<Map<String, dynamic>> rooms =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(
            RoomSuccessState(
              rooms: rooms,
            ),
          );
        } else if (event is AddRoomEvent) {
          await queryTable.insert({
            'room_no': event.name,
            'floor_id': event.floorId,
          });
          add(GetAllRoomEvent());
        } else if (event is DeleteRoomEvent) {
          await queryTable.delete().eq('id', event.id);
          add(GetAllRoomEvent());
        }
      } catch (e, s) {
        Logger().wtf('$e,$s');
        emit(RoomFailureState());
      }
    });
  }
}
