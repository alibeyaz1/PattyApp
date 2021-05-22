import 'dart:convert';

import 'package:PattyApp/animations/ScaleRoute.dart';
import 'package:PattyApp/pages/FoodDetailsPage.dart';
import 'package:PattyApp/pages/FoodOrderPage.dart';
import 'package:PattyApp/providerModels/review.dart';
import 'package:PattyApp/providerModels/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providerModels/product.dart';

import 'package:http/http.dart' as http;

class SellerDetailsPage extends StatefulWidget {
  String id;

  SellerDetailsPage(this.id);
  @override
  _SellerDetailsPageState createState() => _SellerDetailsPageState();
}

class _SellerDetailsPageState extends State<SellerDetailsPage> {
  User seller;
  List<Product> products;
  List<Review> reviews;
  bool isLoading = true;

  @override
  void initState() {
    _getSeller();
    super.initState();
  }

  _getSeller() async {
    var url = Uri.parse('http://10.0.2.2:3000/api/auth/seller/${widget.id}');

    var response = await http.get(url);

    seller = User.fromJson(jsonDecode(response.body)['seller']);

    url = Uri.parse('http://10.0.2.2:3000/api/products/seller/${widget.id}');

    response = await http.get(url);

    dynamic parsed =
        jsonDecode(response.body)['products'].cast<Map<String, dynamic>>();
    products = parsed.map<Product>((json) => Product.fromJson(json)).toList();

    url = Uri.parse('http://10.0.2.2:3000/api/ratings/all/${widget.id}');

    response = await http.get(url);

    parsed = jsonDecode(response.body)['ratings'].cast<Map<String, dynamic>>();
    reviews = parsed.map<Review>((json) => Review.fromJson(json)).toList();

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
            length: 2,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    /*  Container(
                height: 150,
                child:FoodDetailsSlider(
                    slideImage1: "assets/images/bestfood/ic_best_food_8.jpeg",
                    slideImage2: "assets/images/bestfood/ic_best_food_9.jpeg",
                    slideImage3: "assets/images/bestfood/ic_best_food_10.jpeg"),
              ),*/

                    FoodTitleWidget(
                      productName: this.seller.name,
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
                            text: 'Foods',
                          ),
                          Tab(
                            text: 'Reviews',
                          ),
                        ], // list of tabs
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          children: [
                            Container(
                              color: Colors.white24,
                              child: DetailContentMenu(this.products),
                            ),
                            Container(
                              color: Colors.white24,
                              child: ReviewContentMenu(this.reviews, widget.id),
                            ), // class name
                          ],
                        ),
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
    this.productPrice,
    this.productHost,
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
            productPrice == null
                ? Container()
                : Text(
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
            productHost == null
                ? Container()
                : Text(
                    "by ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFa9a9a9),
                        fontWeight: FontWeight.w400),
                  ),
            productHost == null
                ? Container()
                : Text(
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

class DetailContentMenu extends StatelessWidget {
  List<Product> products;

  DetailContentMenu(@required this.products);
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      children: this.products.length == 0
          ? [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                height: 60,
                child: Text('No sellers'),
              ),
            ]
          : [
              for (var i in this.products)
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, ScaleRoute(page: FoodDetailsPage(i.id)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(i.name),
                        Text('\$ ${i.price.toString()}'),
                      ],
                    ),
                  ),
                ),
            ],
    );
  }
}

class ReviewContentMenu extends StatefulWidget {
  final List<Review> reviews;
  final String id;

  ReviewContentMenu(@required this.reviews, this.id);

  @override
  _ReviewContentMenuState createState() => _ReviewContentMenuState();
}

class _ReviewContentMenuState extends State<ReviewContentMenu> {
  String comment = "";
  bool isLoading = false;

  sendComment() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    String token = prefs.get("token");

    var url = Uri.parse('http://10.0.2.2:3000/api/ratings');

    var response = await http.post(url, body: {
      'seller': widget.id,
      'comment': comment,
    }, headers: {
      'token': token
    });

    if (response.statusCode < 300) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Comment added succesfully'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  isLoading = false;
                });
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (value) {
            this.comment = value;
          },
          decoration: InputDecoration(
              suffixIcon: this.isLoading
                  ? Icon(Icons.do_disturb_alt_sharp)
                  : IconButton(icon: Icon(Icons.send), onPressed: sendComment),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: "Comment"),
        ),
        ListView(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          children: this.widget.reviews.length == 0
              ? [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    height: 60,
                    child: Text('No Comments'),
                  ),
                ]
              : [
                  for (var i in this.widget.reviews)
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, ScaleRoute(page: FoodDetailsPage(i.id)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            )),
                        height: 60,
                        child: Text("${i.comment} || by ${i.customer}"),
                      ),
                    ),
                ],
        ),
      ],
    );
  }
}
