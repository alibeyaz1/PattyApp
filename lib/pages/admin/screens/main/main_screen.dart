import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth.dart';
import '../../screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.logout),
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();

          prefs.remove("token");
          prefs.remove("isSeller");
          Navigator.pushReplacement(context, ScaleRoute(page: Auth()));
        },
      ),
    );
  }
}
