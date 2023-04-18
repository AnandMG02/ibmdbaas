import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/widget/create.dart';

class Deployment extends StatelessWidget {
  const Deployment({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Database Deployments",
                    style:
                        TextStyle(fontSize: 30, color: Get.theme.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SizedBox(
                  height: Get.height * 0.6,
                  width: Get.width * 0.8,
                  child: const Center(child: Text("No Deployment"))),
            )
          ],
        ),
      ),
    );
  }
}
