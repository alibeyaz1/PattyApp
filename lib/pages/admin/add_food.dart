import 'package:PattyApp/pages/admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class add_food extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String name = "";
  String _chosenValue;
  bool isWeight = false;
  String imageUrl = "";
  String price = "";
  String description = "";
  bool isLoading = false;

  saveProduct() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/products/');

    var response = await http.post(url, body: {
      'name': name,
      'category': _chosenValue,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'isWeight': isWeight.toString()
    }, headers: {
      'token': token
    });

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Product added succesfully'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: TextField(
              onChanged: (value) {
                this.name = value;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "Food Name"),
            ),
          ),
          Container(
            child: TextField(
              onChanged: (value) {
                this.imageUrl = value;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "Image Url"),
            ),
          ),
          Container(
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                this.price = value;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "Price"),
            ),
          ),
          Container(
            child: TextField(
              onChanged: (value) {
                this.description = value;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "Description"),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: TextStyle(color: Colors.black),

              items: <String>[
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Please choose a category",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
          ),
          Container(
            child: CheckboxListTile(
              value: this.isWeight,
              subtitle: Text('Sold as weight'),
              onChanged: (bool value) {
                setState(() {
                  this.isWeight = value;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: this.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    child: Text("Send"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0xFF52acff),
                    ),
                    onPressed: () {
                      saveProduct();
                    }),
            padding: EdgeInsets.all(32),
          ),
        ],
      ),
    );
  }
}
