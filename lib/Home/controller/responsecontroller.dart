import 'package:get/get.dart';
import 'dart:convert';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodel.dart';
import 'package:http/http.dart' as http;

final DashController dashCtrl = Get.find();
final ResponseController resCtrl = Get.put(ResponseController());

class ResponseController extends GetxController {
  final client = http.Client();
  final url =
      "https://nodeserver-ibmdbaas-hackathon2023-mongo-t-mobile.mycluster-wdc04-b3c-16x64-bcd9381b2e59a32911540577d00720d7-0000.us-east.containers.appdomain.cloud/pods";
  late List<ResponseValue> resValue = [];
  final RxBool isLoading = false.obs;

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

  Future<http.Response> getData() async {
    final resp = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      try {
        final res = json.decode(resp.body);
        resValue.clear();
        if (res.length > 0) {
          for (var i = 0; i < res.length; i++) {
            resValue.add(ResponseValue(
              cluster: res[i]['clustername'],
              user: res[i]['mongoUser'],
              ip: res[i]['podip'],
              port: res[i]['podport'].toString(),
              url: res[i]['url'],
              status: res[i]['status'],
            ));
          }
          resCtrl.pushResData(resValue);
        } else {
          dashCtrl.isdeployed.value = false;
        }
      } catch (e) {
        print('Error decoding JSON response: $e');
      }
    } else {
      print('Error: ${resp.statusCode}');
    }
    changeLoading(false);
    return resp;
  }

  changeLoading(value) {
    isLoading.value = value;
    update();
  }
}
