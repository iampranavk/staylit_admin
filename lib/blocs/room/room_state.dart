part of 'room_bloc.dart';

@immutable
abstract class RoomState {}

class RoomInitialState extends RoomState {}

class RoomLoadingState extends RoomState {}

class RoomSuccessState extends RoomState {
  final List<Map<String, dynamic>> rooms;

  RoomSuccessState({required this.rooms});
}

class RoomFailureState extends RoomState {
  final String message;
  RoomFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
