import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/add_edit_service_dialog.dart';
import 'package:staylit_admin/screens/widgets/add_edit_staff_dialog.dart';
import 'package:staylit_admin/screens/widgets/add_floor_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/floor_card.dart';
import 'package:staylit_admin/screens/widgets/user_card.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({super.key});

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
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
                    label: 'Add Staff',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddEditStaffDialog(),
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
                    (index) => const UserCard(
                      showButtons: true,
                    ),
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
