import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/add_floor_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/floor_card.dart';

class FloorsScreen extends StatefulWidget {
  const FloorsScreen({super.key});

  @override
  State<FloorsScreen> createState() => _FloorsScreenState();
}

class _FloorsScreenState extends State<FloorsScreen> {
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
                    label: 'Add Floor',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddFloorDialog(),
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
                    (index) => const FloorCard(
                      label: '',
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
