import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/floor/floor_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';

class FloorCard extends StatelessWidget {
  final bool isReadOnly, isSelected;
  final Function()? onPressed;
  final Map<String, dynamic> floorDetails;
  final FloorBloc? floorBloc;
  const FloorCard({
    super.key,
    this.isReadOnly = false,
    this.isSelected = false,
    this.onPressed,
    required this.floorDetails,
    this.floorBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomCard(
        onPressed: isReadOnly ? onPressed : null,
        color: isSelected ? Colors.blue[500] : Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              isReadOnly
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          floorBloc!.add(DeleteFloorEvent(
                            id: floorDetails['id'],
                          ));
                        },
                        icon: const Icon(
                          Icons.delete_forever_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
              Align(
                alignment: isReadOnly ? Alignment.center : Alignment.centerLeft,
                child: Text(
                  floorDetails['floor'].toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: isSelected ? Colors.white : Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
