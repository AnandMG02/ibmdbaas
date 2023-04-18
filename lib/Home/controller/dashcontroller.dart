import 'package:get/get.dart';

class DashController extends GetxController {
  RxInt index = 0.obs;
  RxBool createDedicated = true.obs;
  RxBool createShared = false.obs;
  RxBool cluster = false.obs;
  // RxBool isDedicated = false.obs;
  // RxBool isShared = false.obs;
  RxString selectedItem = "OC10 : 2 GB RAM , 10 GB Storage , 2 vCPU".obs;

  btmIndexChange(i) {
    index.value = i;
    update();
  }

  dedicated(bool value) {
    createDedicated.value = value;
    update();
  }

  shared(bool value) {
    createShared.value = value;
    update();
  }

  clustertier(bool value) {
    cluster.value = value;
    update();
  }

  ddown(RxString val) {
    selectedItem.value = val.value;
    update();
  }
}
