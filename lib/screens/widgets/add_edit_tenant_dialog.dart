import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/tenant/tenant_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/room_selector.dart';
import 'package:staylit_admin/util/value_validators.dart';

class AddEditTenantDialog extends StatefulWidget {
  final Map<String, dynamic>? tenantDetails;
  final TenantBloc tenantBloc;
  const AddEditTenantDialog({
    super.key,
    this.tenantDetails,
    required this.tenantBloc,
  });

  @override
  State<AddEditTenantDialog> createState() => _AddEditTenantDialogState();
}

class _AddEditTenantDialogState extends State<AddEditTenantDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isObscure = true;

  int? roomId;
  String? roomNumber;

  @override
  void initState() {
    if (widget.tenantDetails != null) {
      _nameController.text = widget.tenantDetails!['name'];
      _emailController.text = widget.tenantDetails!['email'];
      _phoneNumberController.text = widget.tenantDetails!['phone'];
      roomId = widget.tenantDetails!['room']['id'];
      roomNumber = widget.tenantDetails!['room']['room_no'];
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            widget.tenantDetails != null
                                ? "Edit Tenant"
                                : "Add Tenant",
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
                            widget.tenantDetails != null
                                ? "Change the following details and save to apply them"
                                : "Enter the following details to add a tenant.",
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
                  'Tenant Name',
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
                      hintText: 'eg.name@email.com',
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                Text(
                  'Passward',
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
                    validator: widget.tenantDetails != null
                        ? (value) {
                            return null;
                          }
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
                RoomSelector(
                  onSelect: (id) {
                    roomId = id;
                    setState(() {});
                  },
                  label: roomNumber ?? 'Select Room',
                ),
                const Divider(
                  height: 30,
                  color: Color.fromARGB(66, 176, 176, 176),
                ),
                CustomButton(
                  label: widget.tenantDetails != null ? 'Save' : 'Add',
                  labelColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.tenantDetails != null) {
                        widget.tenantBloc.add(
                          EditTenantEvent(
                            userId: widget.tenantDetails!['user_id'],
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
                        widget.tenantBloc.add(
                          AddTenantEvent(
                            name: _nameController.text.trim(),
                            phone: _phoneNumberController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            roomId: roomId!,
                          ),
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
