import 'package:PattyApp/pages/admin/screens/dashboard/components/my_foods_cards.dart';
import 'package:PattyApp/providerModels/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../constants.dart';

class MyFoods extends StatefulWidget {
  const MyFoods({
    Key key,
  }) : super(key: key);

  @override
  _MyFoodsState createState() => _MyFoodsState();
}

class _MyFoodsState extends State<MyFoods> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    _getFoods();
    super.initState();
  }

  void _getFoods() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");
    var url = Uri.parse('http://10.0.2.2:3000/api/products');

    var response = await http.get(url, headers: {'token': token});

    final parsed =
        jsonDecode(response.body)['product'].cast<Map<String, dynamic>>();
    products = parsed.map<Product>((json) => Product.fromJson(json)).toList();

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
                  "My Foods",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: defaultPadding),
                for (var i = 0; i < this.products.length; i++)
                  MyFoodsCards(
                      title: this.products[i].name,
                      price: '\$ ${this.products[i].price}'),
              ],
            ),
          );
  }
}
