import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/complaints_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/dashboard_and_service_requests.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/floors_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/rooms_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/services_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/staffs_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/suggestion_screen.dart';
import 'package:staylit_admin/screens/ui/home_screen_sections/tenants_screen.dart';
import 'package:staylit_admin/screens/ui/login_screen.dart';
import 'package:staylit_admin/screens/widgets/change_password_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_alert_dialog.dart';
import 'package:staylit_admin/screens/widgets/custom_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // Future.delayed(
    //   const Duration(
    //     milliseconds: 100,
    //   ),
    //   () {
    //     if (Supabase.instance.client.auth.currentUser == null) {
    //       Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(
    //           builder: (context) => const LoginScreen(),
    //         ),
    //         (route) => true,
    //       );
    //     }
    //   },
    // );

    tabController = TabController(
      length: 8,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.blueAccent,
        ),
        title: Text(
          'STAYLIT',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 1,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          DashboardAndServiceRequestsScreen(),
          FloorsScreen(),
          RoomsScreen(),
          ServicesScreen(),
          TenantsScreen(),
          StaffsScreen(),
          ComplaintsScreen(),
          SuggestionsScreen(),
        ],
      ),
      drawer: Material(
        color: Colors.blue[50],
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "MENU",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.blue[700],
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Dashboard & Service Requests",
                  onPressed: () {
                    tabController.animateTo(0);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 0,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Floors",
                  onPressed: () {
                    tabController.animateTo(1);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Rooms",
                  onPressed: () {
                    tabController.animateTo(2);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 2,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Services",
                  onPressed: () {
                    tabController.animateTo(3);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Tenants",
                  onPressed: () {
                    tabController.animateTo(4);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 4,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Staffs",
                  onPressed: () {
                    tabController.animateTo(5);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Complaints",
                  onPressed: () {
                    tabController.animateTo(6);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 6,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Suggestions",
                  onPressed: () {
                    tabController.animateTo(7);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 7,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Change Password",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ChangePasswordDialog(),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Logout",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Logout',
                        message: 'Are you sure that you want to logout ?',
                        primaryButtonLabel: 'Logout',
                        primaryOnPressed: () async {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => true,
                          );
                          await Supabase.instance.client.auth.signOut();
                        },
                        secondaryButtonLabel: 'Cancel',
                        secondaryOnPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: isSelected ? Colors.blue[800] : Colors.blue[50],
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
