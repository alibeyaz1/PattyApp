import 'package:PattyApp/widgets/BestFoodWidget.dart';
import 'package:PattyApp/widgets/BottomNavBarWidget.dart';
import 'package:PattyApp/widgets/PopularFoodsWidget.dart';
import 'package:PattyApp/widgets/TopMenus.dart';
import 'package:flutter/material.dart';
import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "What would you like to eat?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        brightness: Brightness.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // TopMenus(),
            PopularFoodsWidget(),
            BestFoodWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
