import 'package:PattyApp/pages/admin/screens/main/main_screen.dart';
import 'package:PattyApp/pages/auth.dart';
import 'package:PattyApp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patty App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Patty App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = true;
  bool isSeller = false;
  bool isLoading = false;
  @override
  void initState() {
    _getToken();
    super.initState();
  }

  void _getToken() async {
    final prefs = await SharedPreferences.getInstance();

    isLoggedIn = prefs.containsKey('token');
    isSeller = prefs.get('isSeller');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            body: isLoggedIn ? (isSeller ? MainScreen() : Home()) : Auth(),
          );
  }
}
