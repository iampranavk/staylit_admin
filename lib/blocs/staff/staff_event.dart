part of 'staff_bloc.dart';

@immutable
abstract class StaffEvent {}

class AddStaffEvent extends StaffEvent {
  final String name, phone, email, password;

  AddStaffEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
}

class EditStaffEvent extends StaffEvent {
  final String name, phone, email, userId;
  final String? password;
  final int? roomId;

  EditStaffEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    this.password,
    this.roomId,
  });
}

class DeleteStaffEvent extends StaffEvent {
  final String userId;

  DeleteStaffEvent({required this.userId});
}

class ChangeStatusStaffEvent extends StaffEvent {
  final String userId, status;

  ChangeStatusStaffEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllStaffEvent extends StaffEvent {
  final String? query;

  GetAllStaffEvent({this.query});
}
