part of 'staff_bloc.dart';

@immutable
abstract class StaffState {}

class StaffInitialState extends StaffState {}

class StaffLoadingState extends StaffState {}

class StaffSuccessState extends StaffState {
  final List<Map<String, dynamic>> staffs;

  StaffSuccessState({required this.staffs});
}

class StaffFailureState extends StaffState {
  final String message;

  StaffFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
