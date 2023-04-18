// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/appwidget.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/widget/dropdown.dart';

class Create extends StatelessWidget {
  Create({super.key});

  final AppMainbar appbar = Get.find();

  final DashController dashCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.appmainbar([
        GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.only(top: 10.0, right: 30),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ))
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Card(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 30, left: 0, right: 0, bottom: 0),
              height: Get.height,
              width: Get.width,
              child: Column(
                children: [
                  GetX<DashController>(
                    builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (event) {
                              dashCtrl.dedicated(true);
                            },
                            // onExit: (event) {
                            //   dashCtrl.dedicated(false);
                            // },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2,
                                        color: dashCtrl.createDedicated.value
                                            ? Get.theme.primaryColor
                                            : Colors.white)),
                                width: Get.width * 0.2,
                                height: Get.height * 0.1,
                                child: const Center(child: Text("Dedicated"))),
                          ),
                        ),
                        Card(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (event) {
                              dashCtrl.shared(true);
                              dashCtrl.dedicated(false);
                            },
                            onExit: (event) {
                              dashCtrl.shared(false);
                              dashCtrl.dedicated(true);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2,
                                        color: dashCtrl.createShared.value
                                            ? Get.theme.primaryColor
                                            : Colors.white)),
                                width: Get.width * 0.2,
                                height: Get.height * 0.1,
                                child: const Center(child: Text("Shared"))),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: Get.theme.primaryColor)),
                    width: Get.width * 0.8,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Cluster Tier",
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 20),
                          ),
                          Container(
                            height: Get.height * 0.1,
                            width: Get.width * 0.5,
                            child: DropDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: Get.theme.primaryColor)),
                    width: Get.width * 0.8,
                    height: Get.height * 0.13,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Cluster Name",
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 20),
                          ),
                          Container(
                              width: Get.width * 0.2,
                              child: TextFormField(
                                initialValue: "Cluster01",
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Center(
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Get.theme.primaryColor),
                      ),
                      onPressed: () {},
                      icon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Create Cluster",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
