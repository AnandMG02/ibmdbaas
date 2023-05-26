import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';

//Unit Test

final DashController dashCtrl = Get.put(DashController());

void main() {
  group("DashController ", () {
    test("Given Intial Value of Dashcontroller as Expect", () {
      //arrange

      //act
      final index = dashCtrl.index.value;
      final createDedicated = dashCtrl.createDedicated.value;
      final createShared = dashCtrl.createShared.value;
      final cluster = dashCtrl.cluster.value;
      final isdeployed = dashCtrl.isdeployed.value;
      final isActive = dashCtrl.isActive.value;
      final selectedItem = dashCtrl.selectedItem.value;

      //assert
      expect(index, 0);
      expect(createDedicated, true);
      expect(createShared, false);
      expect(cluster, false);
      expect(isdeployed, false);
      expect(isActive, true);
      expect(selectedItem, "OC10 : 2 GB RAM , 10 GB Storage , 2 vCPU");
    });

    test("Index value changed on input", () {
      //act
      dashCtrl.btmIndexChange(2);
      final index = dashCtrl.index.value;
      //assert
      expect(index, 2);
    });

    test("Dedicated value changed on input", () {
      //act
      dashCtrl.dedicated(false);
      final d1 = dashCtrl.createDedicated.value;
      dashCtrl.dedicated(true);
      final d2 = dashCtrl.createDedicated.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("Shared value changed on input", () {
      //act
      dashCtrl.shared(false);
      final d1 = dashCtrl.createShared.value;
      dashCtrl.shared(true);
      final d2 = dashCtrl.createShared.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("cluster value changed on input", () {
      //act
      dashCtrl.clustertier(false);
      final d1 = dashCtrl.cluster.value;
      dashCtrl.clustertier(true);
      final d2 = dashCtrl.cluster.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("cluster value changed on input", () {
      //act
      dashCtrl.ddown("Test".obs);
      final val = dashCtrl.selectedItem.value;
      //assert
      expect(val, "Test".obs);
    });

    test("Deployed value changed on input", () {
      //act
      dashCtrl.deployChange(false);
      final d1 = dashCtrl.isdeployed.value;
      dashCtrl.deployChange(true);
      final d2 = dashCtrl.isdeployed.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("Active value changed on input", () {
      //act
      dashCtrl.activeStatus(false);
      final d1 = dashCtrl.isActive.value;
      dashCtrl.activeStatus(true);
      final d2 = dashCtrl.isActive.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });
  });
}
