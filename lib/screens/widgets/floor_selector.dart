import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/floor/floor_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class FloorSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const FloorSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<FloorSelector> createState() => _FloorSelectorState();
}

class _FloorSelectorState extends State<FloorSelector> {
  final FloorBloc floorBloc = FloorBloc();

  @override
  void initState() {
    floorBloc.add(GetAllFloorEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<FloorBloc>.value(
        value: floorBloc,
        child: BlocConsumer<FloorBloc, FloorState>(
          listener: (context, state) {
            if (state is FloorFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    floorBloc.add(GetAllFloorEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is FloorSuccessState) {
              return CustomSelectBox(
                iconData: Icons.apartment,
                items: List<CustomSelectBoxItem>.generate(
                  state.floors.length,
                  (index) => CustomSelectBoxItem(
                    value: state.floors[index]['id'],
                    label: state.floors[index]['floor'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is FloorFailureState) {
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
