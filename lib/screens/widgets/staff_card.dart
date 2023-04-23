import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/staff/staff_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_edit_staff_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';

class StaffCard extends StatelessWidget {
  final Map<String, dynamic> staffDetails;
  final StaffBloc staffBloc;

  const StaffCard(
      {super.key, required this.staffDetails, required this.staffBloc});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${staffDetails['id'].toString()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Name',
                      text: staffDetails['name'],
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Email',
                      text: staffDetails['email'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Phone',
                text: staffDetails['phone'],
              ),
              const Divider(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomActionButton(
                          iconData: Icons.delete_forever_outlined,
                          label: 'Delete',
                          color: Colors.red[700]!,
                          onPressed: () {
                            staffBloc.add(DeleteStaffEvent(
                                userId: staffDetails['user_id']));
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
                          color: Colors.blue[700]!,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AddEditStaffDialog(
                                staffBloc: staffBloc,
                                staffDetails: staffDetails,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomActionButton(
                    iconData: Icons.block_outlined,
                    label:
                        staffDetails['status'] == 'active' ? 'Block' : 'Active',
                    color: staffDetails['status'] == 'active'
                        ? Colors.red
                        : Colors.green,
                    onPressed: () {
                      staffBloc.add(
                        ChangeStatusStaffEvent(
                          userId: staffDetails['user_id'],
                          status: staffDetails['status'] == 'active'
                              ? 'blocked'
                              : 'active',
                        ),
                      );
                    },
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
