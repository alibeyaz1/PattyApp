import 'package:PattyApp/pages/admin/screens/dashboard/components/my_foods_cards.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class MyFoods extends StatelessWidget {
  const MyFoods({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          MyFoodsCards(
            title: "Documents Files",
            price: "1.3GB",
          ),
          MyFoodsCards(
            title: "Media Files",
            price: "15.3GB",
          ),
          MyFoodsCards(
            title: "Other Files",
            price: "1.3GB",
          ),
          MyFoodsCards(
            title: "Unknown",
            price: "1.3GB",
          ),
        ],
      ),
    );
  }
}
