part of 'tenant_bloc.dart';

@immutable
abstract class TenantState {}

class TenantInitialState extends TenantState {}

class TenantLoadingState extends TenantState {}

class TenantSuccessState extends TenantState {
  final List<Map<String, dynamic>> tenants;

  TenantSuccessState({required this.tenants});
}

class TenantFailureState extends TenantState {
  final String message;

  TenantFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}
