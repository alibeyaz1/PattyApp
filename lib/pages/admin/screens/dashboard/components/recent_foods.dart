import 'package:PattyApp/providerModels/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/RecentFile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants.dart';

class RecentFoods extends StatefulWidget {
  const RecentFoods({
    Key key,
  }) : super(key: key);

  @override
  _RecentFoodsState createState() => _RecentFoodsState();
}

class _RecentFoodsState extends State<RecentFoods> {
  List<dynamic> files = [];
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/orders/');

    var response = await http.get(url, headers: {'token': token});

    final parsed =
        jsonDecode(response.body)['orders'].cast<Map<String, dynamic>>();
    orders = parsed.map<Order>((json) => Order.fromJson(json)).toList();

    for (var i = 0; i < orders.length; i++) {
      files.add(new RecentFile(
        title: orders[i].customerName,
        date: orders[i].date.split('T')[0],
        price: orders[i].totalPrice.toString(),
      ));
    }

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
        : Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Orders",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Costumer Name"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Price"),
                      ),
                    ],
                    rows: List.generate(
                      files.length,
                      (index) => recentFileDataRow(files[index]),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Text(fileInfo.title),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date)),
      DataCell(Text(fileInfo.price)),
    ],
  );
}
