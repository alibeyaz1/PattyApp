import 'package:PattyApp/widgets/BestFoodWidget.dart';
import 'package:PattyApp/widgets/BottomNavBarWidget.dart';
import 'package:PattyApp/widgets/PopularFoodsWidget.dart';
import 'package:PattyApp/widgets/SearchWidget.dart';
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
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text(
          "What would you like to eat?",
          style: TextStyle(
              color: Color(0xFF3a3737),
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                Navigator.push(context, ScaleRoute(page: Auth()));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            TopMenus(),
            PopularFoodsWidget(),
            BestFoodWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
