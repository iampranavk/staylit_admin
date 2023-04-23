import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staylit_admin/blocs/complaint/complaint_bloc.dart';
import 'package:staylit_admin/blocs/suggestion/suggestion_bloc.dart';
import 'package:staylit_admin/screens/widgets/complaints/complaints_card.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_progress_indicator.dart';
import 'package:staylit_admin/screens/widgets/suggestions/suggestion_card.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  ComplaintBloc complaintBloc = ComplaintBloc();

  @override
  void initState() {
    complaintBloc.add(GetAllComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintBloc>.value(
      value: complaintBloc,
      child: BlocConsumer<ComplaintBloc, ComplaintState>(
        listener: (context, state) {
          if (state is ComplaintFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failed',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  complaintBloc.add(GetAllComplaintEvent());
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: state is ComplaintSuccessState
                        ? state.complaints.isNotEmpty
                            ? SingleChildScrollView(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: List<Widget>.generate(
                                    state.complaints.length,
                                    (index) => ComplaintCard(
                                      complaints: state.complaints[index],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text('No complaints found.'))
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
