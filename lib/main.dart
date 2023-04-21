import 'package:flutter/material.dart';
import 'package:staylit_admin/screens/ui/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://uidlngnandekepjmjxjg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpZGxuZ25hbmRla2Vwam1qeGpnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3NzUwOTMxMSwiZXhwIjoxOTkzMDg1MzExfQ.YjT5bflspEFr0K4xbw0kpnidxKo4iswobhjaETOgxts',
  );

  // Supabase.instance.client.auth.admin.createUser(
  //   AdminUserAttributes(
  //     email: 'admin@staylit.com',
  //     password: 'password',
  //     emailConfirm: true,
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staylit Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          fillColor: Colors.blue[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: Colors.blue, width: 0.5),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
