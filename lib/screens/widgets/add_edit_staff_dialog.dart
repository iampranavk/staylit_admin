import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/staff/staff_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/util/value_validators.dart';

class AddEditStaffDialog extends StatefulWidget {
  final Map<String, dynamic>? staffDetails;
  final StaffBloc staffBloc;
  const AddEditStaffDialog({
    super.key,
    this.staffDetails,
    required this.staffBloc,
  });

  @override
  State<AddEditStaffDialog> createState() => _AddEditStaffDialogState();
}

class _AddEditStaffDialogState extends State<AddEditStaffDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isObscure = true;

  @override
  void initState() {
    if (widget.staffDetails != null) {
      _nameController.text = widget.staffDetails!['name'];
      _emailController.text = widget.staffDetails!['email'];
      _phoneNumberController.text = widget.staffDetails!['phone'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 1,
          color: Colors.black26,
        ),
      ),
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.staffDetails != null
                                ? "Edit Staff"
                                : "Add Staff",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.staffDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a staff.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Staff Name',
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
                      hintText: 'eg. Mr.John',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _emailController,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      hintText: 'eg.staff@staylit.com',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: _passwordController,
                    validator: widget.staffDetails != null
                        ? (value) => null
                        : passwordValidator,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _isObscure = !_isObscure;
                          setState(() {});
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      hintText: 'Password',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                CustomCard(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    validator: phoneValidator,
                    decoration: const InputDecoration(
                      hintText: 'eg. 9876543210',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.staffDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.staffDetails != null) {
                        widget.staffBloc.add(
                          EditStaffEvent(
                            userId: widget.staffDetails!['user_id'],
                            name: _nameController.text.trim(),
                            phone: _phoneNumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim().isNotEmpty
                                ? _passwordController.text.trim()
                                : null,
                          ),
                        );

                        Navigator.pop(context);
                      } else {
                        widget.staffBloc.add(
                          AddStaffEvent(
                              name: _nameController.text.trim(),
                              phone: _phoneNumberController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()),
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
