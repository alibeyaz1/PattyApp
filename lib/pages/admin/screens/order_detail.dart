import 'dart:convert';

import 'package:PattyApp/providerModels/order.dart';
import 'package:PattyApp/providerModels/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderDetail extends StatefulWidget {
  final orderId;

  OrderDetail(this.orderId);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool isLoading = true;
  Order order;
  List<Product> products = [];
  @override
  void initState() {
    getOrder();
  }

  getOrder() async {
    var url = Uri.parse('http://10.0.2.2:3000/api/orders/${widget.orderId}');

    var response = await http.get(url);

    order = Order.fromJson(jsonDecode(response.body)['order']);

    for (var productId in order.products) {
      url = Uri.parse('http://10.0.2.2:3000/api/products/${productId}');

      var response = await http.get(url);

      products.add(Product.fromJson(jsonDecode(response.body)['product']));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Customer Name: ${order.customerName}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Customer Adress: ${order.address}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Products;',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for (var product in products) Text(product.name),
                  ],
                )
              ],
            ),
    );
  }
}
