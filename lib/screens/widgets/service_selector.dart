import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/service/service_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class ServiceSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const ServiceSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<ServiceSelector> createState() => _ServiceSelectorState();
}

class _ServiceSelectorState extends State<ServiceSelector> {
  final ServiceBloc floorBloc = ServiceBloc();

  @override
  void initState() {
    floorBloc.add(GetAllServiceEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<ServiceBloc>.value(
        value: floorBloc,
        child: BlocConsumer<ServiceBloc, ServiceState>(
          listener: (context, state) {
            if (state is ServiceFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    floorBloc.add(GetAllServiceEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ServiceSuccessState) {
              return CustomSelectBox(
                iconData: Icons.home_repair_service_outlined,
                items: List<CustomSelectBoxItem>.generate(
                  state.services.length,
                  (index) => CustomSelectBoxItem(
                    value: state.services[index]['id'],
                    label: state.services[index]['service'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is ServiceFailureState) {
              return const SizedBox();
            } else {
              return const Center(
                child: CustomProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
