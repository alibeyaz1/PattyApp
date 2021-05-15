import 'dart:convert';

import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/FoodDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providerModels/product.dart';

import 'package:http/http.dart' as http;

class PopularFoodsWidget extends StatefulWidget {
  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
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
    return Container(
      height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : PopularFoodItems(this.products),
          )
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  String id;
  String name;
  String imageUrl;
  String price;

  PopularFoodTiles({
    Key key,
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, ScaleRoute(page: FoodDetailsPage(this.id)));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: [
              /* BoxShadow(
                color: Color(0xFFfae3e2),
                blurRadius: 15.0,
                offset: Offset(0, 0.75),
              ),*/
            ]),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Container(
                  width: 170,
                  height: 210,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Image.network(
                              imageUrl,
                              width: 130,
                              height: 140,
                            )),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5),
                            child: Text(name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                            child: Text('\$' + price,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF6e6e71),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class PopularFoodItems extends StatelessWidget {
  List<Product> products;

  PopularFoodItems(this.products);

  @override
  Widget build(BuildContext context) {
    return this.products.length == 0
        ? Center(
            child: Text('There are no products!'),
          )
        : ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for (var i in this.products)
                PopularFoodTiles(
                  id: i.id,
                  name: i.name,
                  imageUrl: i.imagePath,
                  price: i.price.toString(),
                ),
            ],
          );
  }
}
