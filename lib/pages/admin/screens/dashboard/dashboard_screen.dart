import 'package:PattyApp/pages/admin/screens/dashboard/components/recent_foods.dart';

import '../../responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/my_fiels.dart';
import 'components/my_foods.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiels(),
                      SizedBox(height: defaultPadding),
                      RecentFoods(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) MyFoods(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: MyFoods(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
