import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';

import 'package:ibmdbaas/Home/widget/clustertable.dart';

class Deployment extends StatelessWidget {
  Deployment({super.key});

  final DashController dashCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Database Deployments",
                    style:
                        TextStyle(fontSize: 30, color: Get.theme.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                      onPressed: () {
                        resCtrl.getData();
                      },
                      icon: const Icon(Icons.refresh)),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Obx(
                () => SizedBox(
                    height: Get.height * 0.6,
                    width: Get.width * 0.8,
                    child: dashCtrl.isdeployed.value
                        ? SingleChildScrollView(child: ClusterTable())
                        : const Center(child: Text("No Deployment"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
