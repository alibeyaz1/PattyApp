import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/auth.dart';
import 'package:PattyApp/pages/my_orders.dart';
import 'package:PattyApp/widgets/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String newName = "";

  String oldPass = "";

  String newPass = "";

  String newAdress = "";

  updateName() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/auth/change-name');

    var response = await http.put(url, body: {
      'name': newName,
    }, headers: {
      'token': token
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Name updated succesfully'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            )
          ],
        ),
      );
    }
  }

  updatePass() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/auth/newPass');

    var response = await http.put(url, body: {
      'oldPass': oldPass,
      'newPass': newPass,
    }, headers: {
      'token': token
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Password updated succesfully'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            )
          ],
        ),
      );
    }
  }

  updateAdress() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/auth/change-adress');

    var response = await http.put(url, body: {
      'adress': newAdress,
    }, headers: {
      'token': token
    });

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Adress updated succesfully'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(ctx);
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: AutofillGroup(
                child: Column(
                  children: [
                    ...[
                      RaisedButton(
                        child: Text('My Orders'),
                        onPressed: () {
                          Navigator.push(context, ScaleRoute(page: MyOrders()));
                        },
                      ),
                      Text('Account Settings'),
                      TextFormField(
                        onChanged: (value) {
                          this.newName = value;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Jane Doe',
                          labelText: 'First Name',
                        ),
                      ),
                      RaisedButton(
                        onPressed: this.updateName,
                        child: Text('Update Name'),
                      ),
                      TextField(
                        onChanged: (value) {
                          this.oldPass = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Old Password',
                        ),
                      ),
                      TextField(
                        onChanged: (value) {
                          this.newPass = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'New Password',
                        ),
                      ),
                      RaisedButton(
                        onPressed: this.updatePass,
                        child: Text('Update Password'),
                      ),
                      TextField(
                        onChanged: (value) {
                          this.newAdress = value;
                        },
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: '123 4th Ave',
                          labelText: 'Street Address',
                        ),
                      ),
                      RaisedButton(
                        onPressed: this.updateAdress,
                        child: Text('Update Adress'),
                      ),
                    ].expand(
                      (widget) => [
                        widget,
                        SizedBox(
                          height: 24,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
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
        bottomNavigationBar: BottomNavBarWidget(3));
  }
}
