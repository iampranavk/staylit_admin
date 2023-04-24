import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/dashboard_count/dashboard_count_bloc.dart';
import 'package:staylit_admin/blocs/service_request/service_request_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';
import 'package:staylit_admin/screens/widgets/service_selector.dart';

class DashboardAndServiceRequestsScreen extends StatefulWidget {
  const DashboardAndServiceRequestsScreen({super.key});

  @override
  State<DashboardAndServiceRequestsScreen> createState() =>
      _DashboardAndServiceRequestsScreenState();
}

class _DashboardAndServiceRequestsScreenState
    extends State<DashboardAndServiceRequestsScreen> {
  String status = 'pending';

  ServiceRequestBloc serviceRequestBloc = ServiceRequestBloc();

  DashboardCountBloc dashboardCountBloc = DashboardCountBloc();

  int? serviceId;

  void getServiceRequest() {
    serviceRequestBloc.add(
      GetAllServiceRequestsEvent(
        serviceId: serviceId,
        status: status,
      ),
    );
  }

  @override
  void initState() {
    getServiceRequest();
    dashboardCountBloc.add(DashboardCountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ServiceRequestBloc>.value(
          value: serviceRequestBloc,
        ),
        BlocProvider<DashboardCountBloc>.value(
          value: dashboardCountBloc,
        ),
      ],
      child: BlocConsumer<ServiceRequestBloc, ServiceRequestState>(
        listener: (context, state) {
          if (state is ServiceRequestFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getServiceRequest();
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
                  BlocConsumer<DashboardCountBloc, DashboardCountState>(
                    listener: (context, state) {
                      if (state is DashboardCountFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Failed',
                            message: state.message,
                            primaryButtonLabel: 'Ok',
                            primaryOnPressed: () {
                              getServiceRequest();
                            },
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is DashboardCountSuccessState
                          ? Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                DashboardCard(
                                  label: 'Total Requests',
                                  title: state.dashbordCount['requests'] ?? '0',
                                  icon: Icons.description_outlined,
                                ),
                                DashboardCard(
                                  label: 'Total Staffs',
                                  title: state.dashbordCount['staffs'] ?? '0',
                                  icon: Icons.group_work,
                                ),
                                DashboardCard(
                                  label: 'Total Services',
                                  title: state.dashbordCount['services'] ?? '0',
                                  icon: Icons.home_repair_service,
                                ),
                                DashboardCard(
                                  label: 'Total Tenants',
                                  title: state.dashbordCount['tenants'] ?? '0',
                                  icon: Icons.groups_2_outlined,
                                ),
                              ],
                            )
                          : state is DashboardCountLoadingState
                              ? const Center(
                                  child: CustomProgressIndicator(),
                                )
                              : const SizedBox();
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            OrderItem(
                              isSeleted: status == 'pending',
                              label: 'Pending',
                              onTap: () {
                                status = 'pending';
                                getServiceRequest();
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OrderItem(
                              isSeleted: status == 'accepted',
                              label: 'Accepted',
                              onTap: () {
                                status = 'accepted';
                                getServiceRequest();
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            OrderItem(
                              isSeleted: status == 'completed',
                              label: 'Completed',
                              onTap: () {
                                status = 'completed';
                                getServiceRequest();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: ServiceSelector(
                          onSelect: (id) {
                            serviceId = id == 0 ? null : id;
                            getServiceRequest();
                            setState(() {});
                          },
                          label: 'Services',
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is ServiceRequestSuccessState
                        ? state.serviceRequests.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.serviceRequests.length,
                                    (index) => ServiceRequestCard(
                                      serviceRequestDetails:
                                          state.serviceRequests[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Text('No service requests found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
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

class ServiceRequestCard extends StatelessWidget {
  final Map<String, dynamic> serviceRequestDetails;
  const ServiceRequestCard({
    super.key,
    required this.serviceRequestDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#${serviceRequestDetails['id'].toString()}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    serviceRequestDetails['status'] == 'pending'
                        ? 'Pending'
                        : serviceRequestDetails['status'] == 'accepted'
                            ? 'Accepted'
                            : 'Completed',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: serviceRequestDetails['status'] == 'pending'
                              ? Colors.grey[600]
                              : serviceRequestDetails['status'] == 'accepted'
                                  ? Colors.green
                                  : Colors.blue[900],
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Service',
                text: serviceRequestDetails['service']['service'],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'From',
                      text: serviceRequestDetails['requestedBy']['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Accepted By',
                      text: serviceRequestDetails['acceptedBy'] != null
                          ? serviceRequestDetails['acceptedBy']['name']
                          : 'not yet accepted',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Room',
                      text: serviceRequestDetails['room']['room_no'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Price',
                      text:
                          '₹${serviceRequestDetails['service']['price'].toString()}',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              LabelWithText(
                label: 'Payment Status',
                text: serviceRequestDetails['payment_status'] == 'pending'
                    ? 'Pending'
                    : serviceRequestDetails['payment_status'] == 'active'
                        ? 'Active'
                        : 'Paid',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.blue[800],
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool isSeleted;
  const OrderItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: isSeleted ? Colors.blue[800] : Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSeleted ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
