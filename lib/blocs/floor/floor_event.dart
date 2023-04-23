part of 'floor_bloc.dart';

@immutable
abstract class FloorEvent {}

class AddFloorEvent extends FloorEvent {
  final String name;

  AddFloorEvent({
    required this.name,
  });
}

class DeleteFloorEvent extends FloorEvent {
  final int id;

  DeleteFloorEvent({
    required this.id,
  });
}

class GetAllFloorEvent extends FloorEvent {
  final String? query;

  GetAllFloorEvent({
    this.query,
  });
}
