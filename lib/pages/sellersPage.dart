import 'package:PattyApp/providerModels/user.dart';
import 'package:PattyApp/widgets/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellersPage extends StatefulWidget {
  @override
  _SellersPageState createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage> {
  List<User> users;
  bool isLoading = false;
  @override
  void initState() {
    _getUsers();
    super.initState();
  }

  void _getUsers() async {
    var url = Uri.parse('http://10.0.2.2:3000/api/auth/sellers');

    var response = await http.get(url);

    final parsed =
        jsonDecode(response.body)['sellers'].cast<Map<String, dynamic>>();
    users = parsed.map<User>((json) => User.fromJson(json)).toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  children: this.users.length == 0
                      ? [
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            height: 60,
                            child: Text('No sellers'),
                          ),
                        ]
                      : [
                          for (var i in this.users)
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                height: 60,
                                child: Text(i.name),
                              ),
                            ),
                        ],
                ),
              ),
        bottomNavigationBar: BottomNavBarWidget(1));
  }
}
