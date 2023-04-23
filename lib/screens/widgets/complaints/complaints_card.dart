import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/util/get_date.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaints;
  const ComplaintCard({
    super.key,
    required this.complaints,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.red[50],
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
                    '#${complaints['id'].toString()}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black87,
                        ),
                  ),
                  Text(
                    getDate(DateTime.parse(complaints['created_at'])),
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
                complaints['complaint'].toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              complaints['serviceRequest'] != null
                  ? const Divider(
                      height: 30,
                    )
                  : const SizedBox(),
              complaints['serviceRequest'] != null
                  ? Column(
                      children: const [Text('details')],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
