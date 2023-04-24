import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/tenant/tenant_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_edit_tenant_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/tenant_card.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({super.key});

  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  TenantBloc tenantBloc = TenantBloc();

  String? query;

  void getTenants() {
    tenantBloc.add(GetAllTenantEvent(query: query));
  }

  @override
  void initState() {
    getTenants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TenantBloc>.value(
      value: tenantBloc,
      child: BlocConsumer<TenantBloc, TenantState>(
        listener: (context, state) {
          if (state is TenantFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getTenants();
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomSearch(
                          onSearch: (search) {
                            query = search;
                            getTenants();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'Add Tenant',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditTenantDialog(
                                tenantBloc: tenantBloc,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is TenantSuccessState
                        ? state.tenants.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.tenants.length,
                                    (index) => TenantCard(
                                      tenantBloc: tenantBloc,
                                      tenantDetails: state.tenants[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No tenants found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
