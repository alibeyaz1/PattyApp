import 'package:PattyApp/providerModels/product.dart';
import 'package:flutter/material.dart';

class Orders {
  static List<Product> _order = [];

  List<Product> get order {
    return _order;
  }

  void removeProduct(Product product) {
    _order.remove(product);
  }

  void clearOrder() {
    _order = [];
  }

  void addProduct(Product product, BuildContext context) {
    bool isSameSeller = true;
    for (var orderItem in _order) {
      if (orderItem.seller != product.seller) {
        isSameSeller = false;
      }
    }
    if (isSameSeller) {
      _order.add(product);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success!'),
          content: Text('Product added to the cart'),
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
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error!'),
          content: Text('Please add products from same seller'),
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
}
