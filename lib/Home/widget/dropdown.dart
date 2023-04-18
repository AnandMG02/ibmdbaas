import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';

class DropDown extends StatelessWidget {
  DropDown({super.key});

  final DashController dashctrl = Get.find();

  List<RxString> items = [
    'OC10 : 2 GB RAM , 10 GB Storage , 2 vCPU'.obs,
    'OC20 : 4 GB RAM , 20 GB Storage , 4 vCPU'.obs,
    'OC30 : 2 GB RAM , 30 GB Storage , 2 vCPU'.obs,
    'OC50 : 2 GB RAM , 30 GB Storage , 4 vCPU'.obs
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Center(
          child: DropdownButton(
            value: dashctrl.selectedItem,
            onChanged: (val) {
              dashctrl.ddown(val!);
            },
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Center(child: Text(item.value)),
              );
            }).toList(),
          ),
        ));
  }
}
