import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/page/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'IBM MDBaaS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "VarelaRound",
          primaryColor: const Color.fromRGBO(75, 107, 175, 1)),
      home: Dashboard(),
    );
  }
}
