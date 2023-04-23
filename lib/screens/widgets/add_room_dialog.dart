import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/room/room_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/floor_selector.dart';
import 'package:staylit_admin/util/value_validators.dart';

class AddRoomDialog extends StatefulWidget {
  final RoomBloc roomBloc;
  const AddRoomDialog({super.key, required this.roomBloc});

  @override
  State<AddRoomDialog> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  int? floorId;
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: 'Add Room',
      message: 'Enter the following details to add a room',
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room name',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _nameController,
                validator: alphaNumericValidator,
                decoration: const InputDecoration(
                  hintText: 'eg.Room 11',
                ),
              ),
            ),
            const SizedBox(height: 10),
            FloorSelector(
              onSelect: (id) {
                floorId = id;
                setState(() {});
              },
              label: 'Select Floor',
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Add',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          if (floorId != null) {
            widget.roomBloc.add(
              AddRoomEvent(
                name: _nameController.text.trim(),
                floorId: floorId!,
              ),
            );
            Navigator.pop(context);
          } else {
            showDialog(
              context: context,
              builder: (_) => const CustomAlertDialog(
                title: 'Required',
                message: 'Floor is required',
                primaryButtonLabel: 'Ok',
              ),
            );
          }
        }
      },
    );
  }
}
