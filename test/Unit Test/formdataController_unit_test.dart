import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';

final FormDataController formCtrl = Get.put(FormDataController());

//unit test

void main() {
  group("Form Data Controller -", () {
    test(" Assinging ClusterName", () {
      //act
      formCtrl.setClusterName("rs01");
      final val = formCtrl.clusterName.value;
      expect(val, "rs01");
    });

    test("Assigning the Username", () {
      //act
      formCtrl.setUser("mongouser");
      final val = formCtrl.user.value;
      expect(val, "mongouser");
    });

    test("Checking the Password", () {
      //act
      formCtrl.setPWD("rootpass");
      final val = formCtrl.pwd.value;
      expect(val, "rootpass");
    });

    test("Checking the Tier", () {
      //act
      formCtrl.setTier("OC50 : 2 GB RAM , 30 GB Storage , 4 vCPU".obs);
      final cpu = formCtrl.cpu.value;
      final ram = formCtrl.ram.value;
      final storage = formCtrl.storage.value;
      expect(cpu, 4);
      expect(ram, 2);
      expect(storage, 30);
    });
  });
}
