import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/service/service_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_edit_service_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  ServiceBloc serviceBloc = ServiceBloc();

  String? query;

  void getServices() {
    serviceBloc.add(GetAllServiceEvent(
      query: query,
    ));
  }

  @override
  void initState() {
    getServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceBloc>.value(
      value: serviceBloc,
      child: BlocConsumer<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getServices();
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
                            getServices();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'Add Service',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditServiceDialog(
                                serviceBloc: serviceBloc,
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
                    child: state is ServiceSuccessState
                        ? state.services.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.services.length,
                                    (index) => ServiceCard(
                                      serviceBloc: serviceBloc,
                                      serviceDetails: state.services[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No services found.'))
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

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> serviceDetails;
  final ServiceBloc serviceBloc;
  const ServiceCard({
    super.key,
    required this.serviceDetails,
    required this.serviceBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${serviceDetails['id'].toString()}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    serviceDetails['image_url'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Service',
                text: serviceDetails['service'],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '₹${serviceDetails['price'].toString()}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.delete_forever_outlined,
                      label: 'Delete',
                      color: Colors.red[700]!,
                      onPressed: () {
                        serviceBloc
                            .add(DeleteServiceEvent(id: serviceDetails['id']));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.edit_outlined,
                      label: 'Update',
                      color: Colors.orange[700]!,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddEditServiceDialog(
                            serviceBloc: serviceBloc,
                            serviceDetails: serviceDetails,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
