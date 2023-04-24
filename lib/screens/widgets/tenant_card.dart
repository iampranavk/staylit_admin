import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/tenant/tenant_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_edit_tenant_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';

class TenantCard extends StatelessWidget {
  final Map<String, dynamic> tenantDetails;
  final TenantBloc tenantBloc;
  const TenantCard({
    super.key,
    required this.tenantDetails,
    required this.tenantBloc,
  });

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
                '#${tenantDetails['id'].toString()}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: LabelWithText(
                  label: 'Name',
                  text: tenantDetails['name'],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                crossAxisAlignment: CrossAxisAlignment.end,
                label: 'Email',
                text: tenantDetails['email'],
              ),
              const SizedBox(
                height: 10,
              ),
              LabelWithText(
                label: 'Phone',
                text: tenantDetails['phone'],
              ),
              const Divider(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Room',
                      text: tenantDetails['room'] != null
                          ? tenantDetails['room']['room_no']
                          : 'Not assigned',
                    ),
                  ),
                  // Expanded(
                  //   child: LabelWithText(
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     label: 'Floor',
                  //     text: '5',
                  //   ),
                  // ),
                ],
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
                            tenantBloc.add(
                              DeleteTenantEvent(
                                userId: tenantDetails['user_id'],
                              ),
                            );
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
                              builder: (_) => AddEditTenantDialog(
                                tenantBloc: tenantBloc,
                                tenantDetails: tenantDetails,
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
                    label: tenantDetails['status'] == 'active'
                        ? 'Block'
                        : 'Active',
                    color: tenantDetails['status'] == 'active'
                        ? Colors.red
                        : Colors.green,
                    onPressed: () {
                      tenantBloc.add(
                        ChangeStatusTenantEvent(
                          userId: tenantDetails['user_id'],
                          status: tenantDetails['status'] == 'active'
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
