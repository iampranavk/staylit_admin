import 'package:flutter/material.dart';
import 'package:staylit_admin/blocs/room/room_bloc.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';

class RoomCard extends StatelessWidget {
  final RoomBloc roomBloc;
  final Map<String, dynamic> roomDetails;
  const RoomCard({
    super.key,
    required this.roomBloc,
    required this.roomDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    roomBloc.add(
                      DeleteRoomEvent(
                        id: roomDetails['id'],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  roomDetails['room_no'].toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black,
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
