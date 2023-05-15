import 'package:get/get.dart';
import 'dart:convert';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodel.dart';
import 'package:http/http.dart' as http;

final DashController dashCtrl = Get.find();
final ResponseController resCtrl = Get.put(ResponseController());

class ResponseController extends GetxController {
  final client = http.Client();
  final url = "http://localhost:3000/pods";
  late List<ResponseValue> resValue = [];

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
    return resp;
  }
}
