part of 'floor_bloc.dart';

@immutable
abstract class FloorState {}

class FloorInitialState extends FloorState {}

class FloorLoadingState extends FloorState {}

class FloorSuccessState extends FloorState {
  final List<Map<String, dynamic>> floors;

  FloorSuccessState({required this.floors});
}

class FloorFailureState extends FloorState {
  final String message;
  FloorFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
