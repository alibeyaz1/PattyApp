import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/FoodDetailsPage.dart';
import 'package:PattyApp/providerModels/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BestFoodWidget extends StatefulWidget {
  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

class _BestFoodWidgetState extends State<BestFoodWidget> {
  List<Product> products;
  bool isLoading = false;
  @override
  void initState() {
    _getFoods();
    super.initState();
  }

  void _getFoods() async {
    var url = Uri.parse('http://localhost:3000/api/products/bestseller');

    var response = await http.get(url);

    final parsed =
        jsonDecode(response.body)['products'].cast<Map<String, dynamic>>();
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
            height: 400,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                BestFoodTitle(),
                Expanded(
                  child: BestFoodList(this.products),
                )
              ],
            ),
          );
  }
}

class BestFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Best Foods",
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

class BestFoodTiles extends StatelessWidget {
  String id;
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String price;
  String slug;

  BestFoodTiles(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.imageUrl,
      @required this.rating,
      @required this.numberOfRating,
      @required this.price,
      @required this.slug})
      : super(key: key);

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
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                this.imageUrl,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 1,
              margin: EdgeInsets.all(5),
            ),
          ),
          Text(
            this.name,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class BestFoodList extends StatelessWidget {
  List<Product> _products;

  BestFoodList(@required this._products);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        for (var i in this._products)
          BestFoodTiles(id: i.id, name: i.name, imageUrl: i.imagePath),
      ],
    );
  }
}
