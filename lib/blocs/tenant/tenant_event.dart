part of 'tenant_bloc.dart';

@immutable
abstract class TenantEvent {}

class AddTenantEvent extends TenantEvent {
  final String name, phone, email, password;
  final int roomId;

  AddTenantEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.roomId,
  });
}

class EditTenantEvent extends TenantEvent {
  final String name, phone, email, userId;
  final String? password;
  final int? roomId;

  EditTenantEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    this.password,
    this.roomId,
  });
}

class DeleteTenantEvent extends TenantEvent {
  final String userId;

  DeleteTenantEvent({required this.userId});
}

class ChangeStatusTenantEvent extends TenantEvent {
  final String userId, status;

  ChangeStatusTenantEvent({
    required this.userId,
    required this.status,
  });
}

class GetAllTenantEvent extends TenantEvent {
  final String? query;

  GetAllTenantEvent({this.query});
}
