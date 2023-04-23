import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/room/room_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_select_box.dart';

class RoomSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const RoomSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<RoomSelector> createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> {
  final RoomBloc floorBloc = RoomBloc();

  @override
  void initState() {
    floorBloc.add(GetAllRoomEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<RoomBloc>.value(
        value: floorBloc,
        child: BlocConsumer<RoomBloc, RoomState>(
          listener: (context, state) {
            if (state is RoomFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    floorBloc.add(GetAllRoomEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RoomSuccessState) {
              return CustomSelectBox(
                iconData: Icons.apartment,
                items: List<CustomSelectBoxItem>.generate(
                  state.rooms.length,
                  (index) => CustomSelectBoxItem(
                    value: state.rooms[index]['id'],
                    label: state.rooms[index]['room_no'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is RoomFailureState) {
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
