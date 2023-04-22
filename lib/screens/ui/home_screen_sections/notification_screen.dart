import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/notification/add_notification_dialog.dart';
import 'package:staylit_admin/screens/widgets/notification/notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddNotificationDialog(),
                );
              },
              label: 'Add Notification',
            ),
            const Divider(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List<Widget>.generate(
                    10,
                    (index) => const NotificationCard(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
