import '../constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String title, totalStorage;
  final int numOfFiels;
  final Color color;

  getDaily() {}
  getWeekly() {}
  getMonthly() {}
  getTotal() {}

  CloudStorageInfo(
      {this.title, this.totalStorage, this.numOfFiels, this.color});
}

List demoMyFiels = [
  CloudStorageInfo(
    title: "Todays Orders",
    numOfFiels: 1328,
    totalStorage: "1234",
    color: primaryColor,
  ),
  CloudStorageInfo(
    title: "Weekly Orders",
    numOfFiels: 1328,
    totalStorage: "2.9",
    color: Color(0xFFFFA113),
  ),
  CloudStorageInfo(
    title: "Montly Orders",
    numOfFiels: 1328,
    totalStorage: "1",
    color: Color(0xFFA4CDFF),
  ),
  CloudStorageInfo(
    title: "Total Orders",
    numOfFiels: 5328,
    totalStorage: "7.3",
    color: Color(0xFF007EE5),
  ),
];
