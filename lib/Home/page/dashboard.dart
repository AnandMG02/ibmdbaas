// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/appwidget.dart';

import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/page/deployment.dart';
import 'package:ibmdbaas/Home/widget/create.dart';
import 'package:ibmdbaas/billing/page/billing.dart';
import 'package:ibmdbaas/settings/page/settings.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final DashController dashCtrl = Get.put(
    DashController(),
  );

  final AppMainbar appbar = Get.put(AppMainbar());

  final items = [Deployment(), Settings(), Billing()];

  @override
  Widget build(BuildContext context) {
    return GetX<DashController>(
      builder: (_) => Scaffold(
        appBar: appbar.appmainbar(null),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => dashCtrl.btmIndexChange(index),
            currentIndex: dashCtrl.index.value,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.storage_rounded), label: "Deployment"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money_sharp), label: "Billing"),
            ]),
        body: items[dashCtrl.index.value],
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Get.to(Create(), transition: Transition.cupertino),
            label: Text("Build")),
      ),
    );
  }
}
