import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodel.dart';

final ResponseController resCtrl = Get.put(ResponseController());

void main() {
  //testing

  group("Response Controller ", () {
    test("Loading value changed on input", () {
      //act
      resCtrl.changeLoading(false);
      final d1 = resCtrl.isLoading.value;
      resCtrl.changeLoading(true);
      final d2 = resCtrl.isLoading.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("Deleting value changed on input", () {
      //act
      resCtrl.changeDeleting(false);
      final d1 = resCtrl.isdeleting.value;
      resCtrl.changeDeleting(true);
      final d2 = resCtrl.isdeleting.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("Greyed value changed on input", () {
      //act
      resCtrl.changegrey(false);
      final d1 = resCtrl.isgreyed.value;
      resCtrl.changegrey(true);
      final d2 = resCtrl.isgreyed.value;
      //assert
      expect(d1, false);
      expect(d2, true);
    });

    test("Evaluate Push Data", () {
      //arrange
      final DashController dashCtrl = Get.put(DashController());
      List<ResponseValue> resdata = [
        ResponseValue(
            cluster: "rs01",
            user: "admin",
            ip: "126.0.0.1",
            port: "27017",
            url: "url",
            status: 'Pending')
      ];

      //act
      resCtrl.pushResData(resdata);
      final loaded = resCtrl.isLoading.value;
      final deployed = dashCtrl.isdeployed.value;
      final val = resCtrl.data;

      //assert
      expect(loaded, false);
      expect(deployed, true);
      expect(val, isA<List<ResponseValue>>());
    });

    test("Evaluate Update Res Data", () {
      //arrange
      ResponseValue rsv = ResponseValue(
          cluster: "mongors",
          user: "root",
          ip: "127.0.0.25",
          port: "27020",
          url: "url",
          status: "Running");
      resCtrl.data.clear();

      //act
      resCtrl.updateResData(rsv);
      final deployed = dashCtrl.isdeployed.value;
      final val = resCtrl.data[0];

      //assert
      expect(deployed, true);
      expect(val, isA<ResponseValue>());
    });
  });
}
