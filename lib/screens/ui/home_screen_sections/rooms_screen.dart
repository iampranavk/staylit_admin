import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/floor/floor_bloc.dart';
import 'package:staylit_admin/blocs/room/room_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_room_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/floor_card.dart';
import 'package:staylit_admin/screens/widgets/room_card.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  RoomBloc roomBloc = RoomBloc();

  FloorBloc floorBloc = FloorBloc();

  String? query;
  int? floorId = 0;

  void getRooms() {
    roomBloc.add(GetAllRoomEvent(
      query: query,
      floorId: floorId == 0 ? null : floorId,
    ));
  }

  @override
  void initState() {
    getRooms();
    floorBloc.add(GetAllFloorEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FloorBloc>.value(
          value: floorBloc,
        ),
        BlocProvider<RoomBloc>.value(
          value: roomBloc,
        ),
      ],
      child: BlocConsumer<RoomBloc, RoomState>(
        listener: (context, state) {
          if (state is RoomFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getRooms();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                          builder: (context) => AddRoomDialog(
                            roomBloc: roomBloc,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    height: 40,
                  ),
                  BlocConsumer<FloorBloc, FloorState>(
                    listener: (context, state) {
                      if (state is FloorFailureState) {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Failed',
                            message: state.message,
                            primaryButtonLabel: 'Ok',
                            primaryOnPressed: () {
                              floorBloc.add(GetAllFloorEvent());
                            },
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is FloorLoadingState
                          ? const Center(
                              child: CustomProgressIndicator(),
                            )
                          : state is FloorSuccessState
                              ? state.floors.isNotEmpty
                                  ? SizedBox(
                                      height: 50,
                                      child: Row(
                                        children: [
                                          AllFloor(
                                            isSelected: floorId == 0,
                                            onPressed: () {
                                              floorId = 0;
                                              setState(() {});
                                              getRooms();
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  FloorCard(
                                                isReadOnly: true,
                                                isSelected: floorId ==
                                                    state.floors[index]['id'],
                                                floorDetails:
                                                    state.floors[index],
                                                onPressed: () {
                                                  floorId =
                                                      state.floors[index]['id'];
                                                  setState(() {});
                                                  getRooms();
                                                },
                                              ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                width: 10,
                                              ),
                                              itemCount: state.floors.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No rooms found'),
                                    )
                              : const SizedBox();
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  Expanded(
                    child: state is RoomSuccessState
                        ? state.rooms.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.rooms.length,
                                    (index) => RoomCard(
                                      roomBloc: roomBloc,
                                      roomDetails: state.rooms[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No rooms found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AllFloor extends StatelessWidget {
  final bool isSelected;
  final Function() onPressed;
  const AllFloor({
    super.key,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomCard(
        onPressed: onPressed,
        color: isSelected ? Colors.blue[500] : Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Center(
            child: Text(
              'All',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: isSelected ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
