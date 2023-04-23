import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/util/get_date.dart';

class SuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestion;
  const SuggestionCard({
    super.key,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
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
                  '#${suggestion['id'].toString()}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                      ),
                ),
                Text(
                  getDate(DateTime.parse(suggestion['created_at'])),
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
              suggestion['suggestion'].toString(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
