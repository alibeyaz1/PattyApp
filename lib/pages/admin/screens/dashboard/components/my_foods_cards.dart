import 'package:PattyApp/pages/admin/add_food.dart';
import 'package:PattyApp/pages/admin/constants.dart';
import 'package:flutter/material.dart';

class MyFoodsCards extends StatelessWidget {
  const MyFoodsCards({
    Key key,
    @required this.title,
    @required this.price,
    @required this.id,
  }) : super(key: key);

  final String title, price, id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => add_food(
                      isEdit: true,
                      editId: id,
                    )),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Text(price)
          ],
        ),
      ),
    );
  }
}
