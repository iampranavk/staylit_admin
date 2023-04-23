part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}

class AddServiceEvent extends ServiceEvent {
  final String name;
  final int price;
  final PlatformFile file;

  AddServiceEvent({
    required this.name,
    required this.file,
    required this.price,
  });
}

class EditServiceEvent extends ServiceEvent {
  final String name;
  final int price, serviceId;
  final PlatformFile? file;

  EditServiceEvent({
    required this.name,
    this.file,
    required this.price,
    required this.serviceId,
  });
}

class DeleteServiceEvent extends ServiceEvent {
  final int id;

  DeleteServiceEvent({
    required this.id,
  });
}

class GetAllServiceEvent extends ServiceEvent {
  final String? query;

  GetAllServiceEvent({
    this.query,
  });
}
