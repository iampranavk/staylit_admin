import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/floor/floor_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_floor_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/floor_card.dart';

class FloorsScreen extends StatefulWidget {
  const FloorsScreen({super.key});

  @override
  State<FloorsScreen> createState() => _FloorsScreenState();
}

class _FloorsScreenState extends State<FloorsScreen> {
  FloorBloc floorBloc = FloorBloc();

  String? query;

  void getFloors() {
    floorBloc.add(GetAllFloorEvent(query: query));
  }

  @override
  void initState() {
    getFloors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FloorBloc>.value(
      value: floorBloc,
      child: BlocConsumer<FloorBloc, FloorState>(
        listener: (context, state) {
          if (state is FloorFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getFloors();
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          onSearch: (search) {
                            query = search;
                            getFloors();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'Add Floor',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddFloorDialog(
                                floorBloc: floorBloc,
                              ),
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
                    child: state is FloorSuccessState
                        ? state.floors.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.floors.length,
                                    (index) => FloorCard(
                                      floorBloc: floorBloc,
                                      floorDetails: state.floors[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No floors found.'))
                        : const Center(
                            child: CustomProgressIndicator(),
                          ),
                  ),
                  const SizedBox(
                    height: 40,
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
