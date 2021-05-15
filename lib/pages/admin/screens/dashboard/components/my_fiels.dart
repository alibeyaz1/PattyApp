import 'package:shared_preferences/shared_preferences.dart';

import '../../../add_food.dart';
import '../../../models/MyFiles.dart';
import '../../../responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiels extends StatelessWidget {
  const MyFiels({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Foods",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => add_food()),
                );
              },
              icon: Icon(Icons.add),
              label: Text("Add New Food"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  _FileInfoCardGridViewState createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  List<dynamic> files = [];
  bool isLoading = true;

  @override
  void initState() {
    getData();
  }

  getData() async {
    var url = Uri.parse('http://10.0.2.2:3000/api/orders/count?filter=daily');

    var response = await http.get(url);

    int count = jsonDecode(response.body)['orderCount'];
    dynamic total = jsonDecode(response.body)['orderTotal'];

    files.add(new CloudStorageInfo(
      title: "Todays Orders",
      numOfFiels: count,
      totalStorage: total.toString(),
      color: primaryColor,
    ));

    url = Uri.parse('http://10.0.2.2:3000/api/orders/count?filter=weekly');

    response = await http.get(url);

    count = jsonDecode(response.body)['orderCount'];
    total = jsonDecode(response.body)['orderTotal'];

    files.add(new CloudStorageInfo(
      title: "Weekly Orders",
      numOfFiels: count,
      totalStorage: total.toString(),
      color: primaryColor,
    ));

    url = Uri.parse('http://10.0.2.2:3000/api/orders/count?filter=monthly');

    response = await http.get(url);

    count = jsonDecode(response.body)['orderCount'];
    total = jsonDecode(response.body)['orderTotal'];

    files.add(new CloudStorageInfo(
      title: "Monthly Orders",
      numOfFiels: count,
      totalStorage: total.toString(),
      color: primaryColor,
    ));

    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");
    url = Uri.parse('http://10.0.2.2:3000/api/orders/count?filter=all');

    response = await http.get(url, headers: {'token': token});

    count = jsonDecode(response.body)['orderCount'];
    total = jsonDecode(response.body)['orderTotal'];

    files.add(new CloudStorageInfo(
      title: "All Orders",
      numOfFiels: count,
      totalStorage: total.toString(),
      color: primaryColor,
    ));

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: files.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: widget.childAspectRatio,
            ),
            itemBuilder: (context, index) => FileInfoCard(info: files[index]),
          );
  }
}
