import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/add_edit_service_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
                    label: 'Add Service',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddEditServiceDialog(),
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
                    (index) => const ServiceCard(),
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

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#11',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1581578731548-c64695cc6952?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Service',
                text: 'Cleaning',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '₹500',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.delete_forever_outlined,
                      label: 'Delete',
                      color: Colors.red[700]!,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      iconData: Icons.edit_outlined,
                      label: 'Update',
                      color: Colors.orange[700]!,
                      onPressed: () {},
                    ),
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
