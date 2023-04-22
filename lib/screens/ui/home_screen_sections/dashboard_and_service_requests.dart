import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/label_with_text.dart';

class DashboardAndServiceRequestsScreen extends StatefulWidget {
  const DashboardAndServiceRequestsScreen({super.key});

  @override
  State<DashboardAndServiceRequestsScreen> createState() =>
      _DashboardAndServiceRequestsScreenState();
}

class _DashboardAndServiceRequestsScreenState
    extends State<DashboardAndServiceRequestsScreen> {
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                DashboardCard(
                  label: 'Today\'s Requests',
                  title: '20',
                  icon: Icons.description_outlined,
                ),
                DashboardCard(
                  label: 'Total Staffs',
                  title: '100',
                  icon: Icons.people_alt_outlined,
                ),
                DashboardCard(
                  label: 'Total Services',
                  title: '30',
                  icon: Icons.info_outline,
                ),
              ],
            ),
            const Divider(
              height: 40,
            ),
            Row(
              children: [
                OrderItem(
                  isSeleted: true,
                  label: 'Pending',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                OrderItem(
                  isSeleted: true,
                  label: 'Active',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                OrderItem(
                  isSeleted: false,
                  label: 'Completed',
                  onTap: () {},
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
                    (index) => const ServiceRequestCard(),
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

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#11',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    'Pending',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: LabelWithText(
                      label: 'From',
                      text: 'User name',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Accepted By',
                      text: 'Staff name',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Row(
                children: const [
                  Expanded(
                    child: LabelWithText(
                      label: 'Room',
                      text: '101',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Floor',
                      text: '5',
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              const LabelWithText(
                label: 'Payment Status',
                text: 'Pending',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label, title;
  final IconData icon;
  const DashboardCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.blue[800],
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool isSeleted;
  const OrderItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.isSeleted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: isSeleted ? Colors.blue[800] : Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isSeleted ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
