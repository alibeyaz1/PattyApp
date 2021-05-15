import 'dart:convert';

import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/FoodOrderPage.dart';
import 'package:flutter/material.dart';
import '../providerModels/product.dart';

import 'package:http/http.dart' as http;

class FoodDetailsPage extends StatefulWidget {
  String id;

  FoodDetailsPage(this.id);
  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  Product _product;
  bool isLoading = true;

  @override
  void initState() {
    _getProduct();
    super.initState();
  }

  _getProduct() async {
    var url = Uri.parse('http://10.0.2.2:3000/api/products/${widget.id}');

    var response = await http.get(url);

    _product = Product.fromJson(jsonDecode(response.body)['product']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : DefaultTabController(
            length: 1,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Color(0xFFFAFAFA),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF3a3737),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                brightness: Brightness.light,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.business_center,
                        color: Color(0xFF3a3737),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: FoodOrderPage()));
                      })
                ],
              ),
              body: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                        this._product.imagePath,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      elevation: 1,
                      margin: EdgeInsets.all(5),
                    ),
                    /*  Container(
                height: 150,
                child:FoodDetailsSlider(
                    slideImage1: "assets/images/bestfood/ic_best_food_8.jpeg",
                    slideImage2: "assets/images/bestfood/ic_best_food_9.jpeg",
                    slideImage3: "assets/images/bestfood/ic_best_food_10.jpeg"),
              ),*/

                    FoodTitleWidget(
                        productName: this._product.name,
                        productPrice: this._product.price.toString(),
                        productHost: this._product.sellerName),
                    SizedBox(
                      height: 15,
                    ),
                    AddToCartMenu(),
                    SizedBox(
                      height: 15,
                    ),
                    PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: TabBar(
                        labelColor: Color(0xFFfd3f40),
                        indicatorColor: Color(0xFFfd3f40),
                        unselectedLabelColor: Color(0xFFa4a1a1),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: [
                          Tab(
                            text: 'Food Details',
                          ),
                        ], // list of tabs
                      ),
                    ),
                    Container(
                      height: 150,
                      child: TabBarView(
                        children: [
                          Container(
                            color: Colors.white24,
                            child: DetailContentMenu(this._product.description),
                          ), // class name
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class FoodTitleWidget extends StatelessWidget {
  String productName;
  String productPrice;
  String productHost;

  FoodTitleWidget({
    Key key,
    @required this.productName,
    @required this.productPrice,
    @required this.productHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              productName,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '\$ ${productPrice}',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3a3a3b),
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: <Widget>[
            Text(
              "by ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFa9a9a9),
                  fontWeight: FontWeight.w400),
            ),
            Text(
              productHost,
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1f1f1f),
                  fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }
}

class AddToCartMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove),
            color: Colors.black,
            iconSize: 30,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, ScaleRoute(page: FoodOrderPage()));
            },
            child: Container(
              width: 200.0,
              height: 45.0,
              decoration: new BoxDecoration(
                color: Color(0xFFfd2c2c),
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Add To Bag',
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Color(0xFFfd2c2c),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}

class DetailContentMenu extends StatelessWidget {
  String description;

  DetailContentMenu(@required this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.description,
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            height: 1.50),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
