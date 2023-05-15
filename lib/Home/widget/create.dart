// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/appwidget.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/widget/clusterbutton.dart';
import 'package:ibmdbaas/Home/widget/credentials.dart';
import 'package:ibmdbaas/Home/widget/dropdown.dart';
import 'package:ibmdbaas/Home/widget/servertype.dart';

class Create extends StatelessWidget {
  Create({super.key});

  final AppMainbar appbar = Get.find();
  final DashController dashCtrl = Get.find();
  final FormDataController formCtrl =
      Get.put(FormDataController(), permanent: true);
  final ResponseController resCtrl = Get.put(ResponseController());

  final TextEditingController _namecontroller =
      TextEditingController(text: "cluster01");

  //function

  Widget sizebox() {
    return SizedBox(
      height: Get.height * 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.appmainbar([
        GestureDetector(
            onTap: () {
              resCtrl.getData();
              Get.back();
            },
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
              height: Get.height * 1.5,
              width: Get.width,
              child: Form(
                key: formCtrl.myFormKey,
                child: Column(
                  children: [
                    ServerType(),
                    sizebox(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 2, color: Get.theme.primaryColor)),
                      width: Get.width * 0.8,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Cluster Tier",
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 50),
                              height: Get.height * 0.1,
                              width: Get.width * 0.35,
                              child: DropDown(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    sizebox(),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 2, color: Get.theme.primaryColor)),
                      width: Get.width * 0.8,
                      height: Get.height * 0.13,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Cluster Name",
                                style: TextStyle(
                                    color: Get.theme.primaryColor,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 50),
                                width: Get.width * 0.2,
                                child: Center(
                                  child: TextFormField(
                                    controller: _namecontroller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name shouldnt start with Num or Capital letter';
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      formCtrl.setClusterName(val);
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      labelText: 'Cluster Name',
                                    ),
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    sizebox(),
                    Credentials(),
                    sizebox(),
                    ClusterButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    _namecontroller.dispose();
  }
}
