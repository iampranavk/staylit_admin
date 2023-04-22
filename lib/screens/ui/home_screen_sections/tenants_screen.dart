import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/add_edit_staff_dialog.dart';
import 'package:staylit_admin/screens/widgets/add_edit_tenant_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/tenant_card.dart';
import 'package:staylit_admin/screens/widgets/user_card.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({super.key});

  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: CustomSearch(
                    onSearch: (search) {},
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomButton(
                    label: 'Add Tenant',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddEditTenantDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Divider(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List<Widget>.generate(
                    10,
                    (index) => const TenantCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
