import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/service/service_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/util/custom_file_picker.dart';
import 'package:staylit_admin/util/value_validators.dart';

class AddEditServiceDialog extends StatefulWidget {
  final Map<String, dynamic>? serviceDetails;
  final ServiceBloc serviceBloc;
  const AddEditServiceDialog({
    super.key,
    this.serviceDetails,
    required this.serviceBloc,
  });

  @override
  State<AddEditServiceDialog> createState() => _AddEditServiceDialogState();
}

class _AddEditServiceDialogState extends State<AddEditServiceDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  PlatformFile? selectedFile;

  @override
  void initState() {
    if (widget.serviceDetails != null) {
      _nameController.text = widget.serviceDetails!['service'];
      _priceController.text = widget.serviceDetails!['price'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      width: 500,
      title: widget.serviceDetails != null ? "Edit Service" : "Add Service",
      message: widget.serviceDetails != null
          ? "Change the following details and save to apply them"
          : "Enter the following details to add a service",
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Service Name',
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
                  hintText: 'eg.Cleaning',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Price',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5),
            CustomCard(
              child: TextFormField(
                controller: _priceController,
                validator: numericValidator,
                decoration: const InputDecoration(
                  hintText: 'Price in rupees',
                ),
              ),
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomActionButton(
              color:
                  selectedFile != null ? Colors.green[700]! : Colors.grey[600]!,
              iconData: selectedFile != null
                  ? Icons.check_outlined
                  : Icons.upload_outlined,
              onPressed: () async {
                PlatformFile? file = await pickFile();
                if (file != null) {
                  selectedFile = file;
                  setState(() {});
                }
              },
              label: selectedFile != null ? 'Added' : 'Add Image',
            ),
            const Divider(
              height: 30,
              color: Color.fromARGB(66, 176, 176, 176),
            ),
            CustomButton(
              labelColor: Colors.white,
              label: widget.serviceDetails != null ? 'Save' : 'Add',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.serviceDetails != null) {
                    widget.serviceBloc.add(EditServiceEvent(
                      name: _nameController.text.trim(),
                      price: int.parse(_priceController.text.trim().toString()),
                      serviceId: widget.serviceDetails!['id'],
                      file: selectedFile,
                    ));
                    Navigator.pop(context);
                  } else {
                    if (selectedFile != null) {
                      widget.serviceBloc.add(AddServiceEvent(
                        name: _nameController.text.trim(),
                        price:
                            int.parse(_priceController.text.trim().toString()),
                        file: selectedFile!,
                      ));
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomAlertDialog(
                          title: 'Required',
                          message: 'Service image is required',
                          primaryButtonLabel: 'Ok',
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
