import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/add_room_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/floor_card.dart';
import 'package:staylit_admin/screens/widgets/room_card.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
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
            Flexible(
              child: CustomButton(
                label: 'Add Room',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AddRoomDialog(),
                  );
                },
              ),
            ),
            const Divider(
              height: 40,
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => FloorCard(
                  onPressed: () {},
                  label: '',
                  isReadOnly: true,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: 10,
              ),
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
                    (index) => const RoomCard(
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
