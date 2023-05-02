import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';

class ServerType extends StatelessWidget {
  ServerType({super.key});

  final DashController dashCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<DashController>(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (event) {
                dashCtrl.dedicated(true);
              },
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
    );
  }
}
