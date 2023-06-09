import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/floor/floor_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/util/value_validators.dart';

class AddFloorDialog extends StatefulWidget {
  final FloorBloc floorBloc;
  const AddFloorDialog({super.key, required this.floorBloc});

  @override
  State<AddFloorDialog> createState() => _AddFloorDialogState();
}

class _AddFloorDialogState extends State<AddFloorDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: 'Add Floor',
      message: 'Enter the following details to add a floor',
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Floor name',
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
                  hintText: 'eg.Floor 1',
                ),
              ),
            ),
          ],
        ),
      ),
      primaryButtonLabel: 'Add',
      primaryOnPressed: () {
        if (_formKey.currentState!.validate()) {
          widget.floorBloc.add(
            AddFloorEvent(
              name: _nameController.text.trim(),
            ),
          );

          Navigator.pop(context);
        }
      },
    );
  }
}
