import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/staff/staff_bloc.dart';
import 'package:staylit_admin/screens/widgets/add_edit_staff_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_button.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/custom_search.dart';
import 'package:staylit_admin/screens/widgets/staff_card.dart';

class StaffsScreen extends StatefulWidget {
  const StaffsScreen({super.key});

  @override
  State<StaffsScreen> createState() => _StaffsScreenState();
}

class _StaffsScreenState extends State<StaffsScreen> {
  StaffBloc staffBloc = StaffBloc();

  String? query;

  void getStaffs() {
    staffBloc.add(GetAllStaffEvent(query: query));
  }

  @override
  void initState() {
    getStaffs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffBloc>.value(
      value: staffBloc,
      child: BlocConsumer<StaffBloc, StaffState>(
        listener: (context, state) {
          if (state is StaffFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getStaffs();
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
                            getStaffs();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CustomButton(
                          label: 'Add Staff',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AddEditStaffDialog(
                                staffBloc: staffBloc,
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
                    child: state is StaffSuccessState
                        ? state.staffs.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.staffs.length,
                                    (index) => StaffCard(
                                      staffBloc: staffBloc,
                                      staffDetails: state.staffs[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No staffs found.'))
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
