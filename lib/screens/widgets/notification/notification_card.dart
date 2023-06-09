import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_action_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/show_user_dialog.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.amber[50],
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#12',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  Text(
                    '19/04/2023',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const Divider(
                height: 30,
              ),
              Text(
                'Water Issue',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien. Phasellus dictum ac elit quis bibendum. Pellentesque nec suscipit est. Aenean vel diam vel tellus posuere elementum. Suspendisse a nunc quis sem tempor varius ac id odio. In dignissim non risus ut accumsan. Vivamus in turpis et est suscipit imperdiet. Nam congue orci quis tortor tincidunt, non tincidunt lorem finibus. Duis dapibus mattis vestibulum. Sed id nunc sit amet ipsum tincidunt elementum id sed libero. Curabitur diam augue, scelerisque nec libero vitae, suscipit luctus ex. Pellentesque sodales auctor fermentum. Donec elementum, lorem in molestie ullamcorper, lacus risus tincidunt justo, vel finibus est turpis eu nulla. Cras tempus, tellus sit amet eleifend feugiat, velit ligula euismod orci, eget interdum risus risus non est.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[800],
                    ),
              ),
              const Divider(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomActionButton(
                  color: Colors.red[800]!,
                  iconData: Icons.delete_forever_outlined,
                  onPressed: () {},
                  label: 'Delete',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
