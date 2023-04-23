part of 'service_bloc.dart';

@immutable
abstract class ServiceState {}

class ServiceInitialState extends ServiceState {}

class ServiceLoadingState extends ServiceState {}

class ServiceSuccessState extends ServiceState {
  final List<Map<String, dynamic>> services;

  ServiceSuccessState({required this.services});
}

class ServiceFailureState extends ServiceState {
  final String message;
  ServiceFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
