import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';

class DropDown extends StatelessWidget {
  DropDown({super.key});

  final DashController dashctrl = Get.find();
  final FormDataController formCtrl = Get.find();

  List<RxString> items = [
    'OC10 : 2 GB RAM , 10 GB Storage , 2 vCPU'.obs,
    'OC20 : 4 GB RAM , 20 GB Storage , 4 vCPU'.obs,
    'OC30 : 2 GB RAM , 30 GB Storage , 2 vCPU'.obs,
    'OC50 : 2 GB RAM , 30 GB Storage , 4 vCPU'.obs
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          labelText: 'Tier',
        ),
        value: dashctrl.selectedItem,
        onChanged: (val) {
          dashctrl.ddown(val!);
        },
        onSaved: (val) {
          formCtrl.setTier(val);
        },
        items: items.map((item) {
          return DropdownMenuItem(
            alignment: Alignment.centerRight,
            value: item,
            child: Center(child: Text(item.value)),
          );
        }).toList(),
      ),
    );
  }
}
