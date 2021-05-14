import 'package:flutter/material.dart';

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
  final _MyController = TextEditingController();
  String name = "";
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(name),
          Container(
            child: TextField(
              controller: _MyController,
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
              controller: _MyController,
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
              controller: _MyController,
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
              )),
          Container(
            width: double.infinity,
            child: TextButton(
                child: Text("Send"),
                //color: Colors.red,
                onPressed: () {
                  setState(() {
                    name = _MyController.text;
                  });
                }),
            padding: EdgeInsets.all(32),
          ),
        ],
      ),
    );
  }
}
