import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responseModel.dart';

final DashController dashCtrl = Get.find();

class ResponseController extends GetxController {
  RxList<ResponseValue> data = [
    ResponseValue(
        cluster: "No Cluster",
        user: "user",
        ip: "ip",
        port: "0000",
        url: "url",
        status: 'Pending')
  ].obs;

  updateResData(ResponseValue d) {
    if (data[0].cluster == "No Cluster") {
      data.removeAt(0);
    }
    data.add(d);
    dashCtrl.isdeployed.value = true;
    update();
  }

  pushResData(List<ResponseValue> val) {
    data.clear();
    dashCtrl.isdeployed.value = true;
    data.addAll(val);
    update();
  }
}
