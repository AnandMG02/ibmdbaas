import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDataController extends GetxController {
  RxString clusterName = "cluster01".obs;
  RxString user = "root".obs;
  RxString pwd = "rootpass".obs;
  RxInt cpu = 2.obs;
  RxInt ram = 2.obs;
  RxInt storage = 10.obs;

  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  setClusterName(name) {
    clusterName.value = name;
    update();
  }

  setUser(usr) {
    user.value = usr;
    update();
  }

  setPWD(pass) {
    pwd.value = pass;
    update();
  }

  setTier(tier) {
    switch (tier.value) {
      case "OC50 : 2 GB RAM , 30 GB Storage , 4 vCPU":
        cpu.value = 4;
        ram.value = 2;
        storage.value = 30;
        update();
        break;
      case "OC30 : 2 GB RAM , 30 GB Storage , 2 vCPU":
        cpu.value = 2;
        ram.value = 2;
        storage.value = 30;
        update();
        break;
      case "OC20 : 4 GB RAM , 20 GB Storage , 4 vCPU":
        cpu.value = 4;
        ram.value = 4;
        storage.value = 20;
        update();
        break;
      default:
        cpu.value = 2;
        ram.value = 2;
        storage.value = 10;
        update();
    }
  }
}
