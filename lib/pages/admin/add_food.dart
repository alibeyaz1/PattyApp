import 'dart:convert';

import 'package:PattyApp/pages/admin/screens/main/main_screen.dart';
import 'package:PattyApp/providerModels/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class add_food extends StatelessWidget {
  final bool isEdit;
  final String editId;

  add_food({@required this.isEdit, this.editId});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(
        isEdit: isEdit,
        editId: editId,
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  final bool isEdit;
  final String editId;

  MyCustomForm({@required this.isEdit, this.editId});
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

  @override
  void initState() {
    getProduct();
  }

  getProduct() async {
    if (widget.isEdit) {
      setState(() {
        isLoading = true;
      });

      final prefs = await SharedPreferences.getInstance();

      String token = prefs.get("token");

      var url =
          Uri.parse('http://localhost:3000/api/products/${widget.editId}');

      var response = await http.get(url, headers: {'token': token});

      Product product = Product.fromJson(jsonDecode(response.body)['product']);

      name = product.name;
      _chosenValue = product.category;
      isWeight = product.isWeight;
      imageUrl = product.imagePath;
      price = product.price.toString();
      description = product.description;

      setState(() {
        isLoading = false;
      });
    }
  }

  saveProduct() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = widget.isEdit
        ? Uri.parse('http://localhost:3000/api/products/${widget.editId}')
        : Uri.parse('http://localhost:3000/api/products/');

    var response = widget.isEdit
        ? await http.put(url, body: {
            'name': name,
            'category': _chosenValue,
            'price': price,
            'description': description,
            'imageUrl': imageUrl,
            'isWeight': isWeight.toString()
          }, headers: {
            'token': token
          })
        : await http.post(url, body: {
            'name': name,
            'category': _chosenValue,
            'price': price,
            'description': description,
            'imageUrl': imageUrl,
            'isWeight': isWeight.toString()
          }, headers: {
            'token': token
          });

    if (response.statusCode < 300) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text(widget.isEdit
              ? 'Product updated succesfully'
              : 'Product added succesfully'),
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    initialValue: this.name,
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
                  child: TextFormField(
                    initialValue: this.imageUrl,
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
                  child: TextFormField(
                    initialValue: this.price,
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
                  child: TextFormField(
                    initialValue: this.description,
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
                      'Fun Dinners',
                      'Pasta',
                      'Noudles',
                      'BBQ',
                      'Roast',
                      'Chicken',
                      'Soup',
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
