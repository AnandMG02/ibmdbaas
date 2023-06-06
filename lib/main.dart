import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Auth/login.dart';
import 'package:ibmdbaas/Auth/logincontroller.dart';
import 'package:ibmdbaas/Home/page/dashboard.dart';
import 'package:ibmdbaas/Home/widget/create.dart';

void main() {
  runApp(const MyApp());
}

final LoginController lctrl = Get.put(LoginController(), permanent: true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/Dashboard': (context) => Dashboard(),
        '/Create': (context) => Create(),
      },
      title: 'IBM MDBaaS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "VarelaRound",
          primaryColor: const Color.fromRGBO(75, 107, 175, 1)),
      home: Login(),
    );
  }
}
