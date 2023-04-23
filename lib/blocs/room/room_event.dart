part of 'room_bloc.dart';

@immutable
abstract class RoomEvent {}

class AddRoomEvent extends RoomEvent {
  final String name;
  final int floorId;

  AddRoomEvent({
    required this.name,
    required this.floorId,
  });
}

class DeleteRoomEvent extends RoomEvent {
  final int id;

  DeleteRoomEvent({
    required this.id,
  });
}

class GetAllRoomEvent extends RoomEvent {
  final String? query;
  final int? floorId;

  GetAllRoomEvent({
    this.query,
    this.floorId,
  });
}
