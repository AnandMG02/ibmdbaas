import 'package:get/get.dart';
import 'dart:convert';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/errcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodels.dart';
import 'package:http/http.dart' as http;

final DashController dashCtrl = Get.find();
final ResponseController resCtrl = Get.put(ResponseController());
final ErrorController errCtrl = Get.put(ErrorController());

class ResponseController extends GetxController {
  final client = http.Client();

  final url =
      "https://ibmdbaas-nodeserver-git-hackathon2023-mongo-t-mobile.mycluster-wdc04-b3c-16x64-bcd9381b2e59a32911540577d00720d7-0000.us-east.containers.appdomain.cloud/pods";
  late List<ResponseValue> resValue = [];
  final RxBool isLoading = false.obs;
  final RxBool isdeleting = false.obs;
  final RxBool isgreyed = false.obs;

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
    for (int i = 0; i < data.length; i++) {
      if (data[i].port == "0000") {
        data.removeAt(i);
      }
    }
    data.add(d);
    dashCtrl.isdeployed.value = true;
    update();
  }

  pushResData(List<ResponseValue> val) {
    changeLoading(false);
    data.clear();
    dashCtrl.isdeployed.value = true;
    data.addAll(val);
    update();
  }

  Future<http.Response> getData(context) async {
    final resp = await client.get(
      Uri.parse(url),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
    );

    if (resp.statusCode == 200) {
      try {
        final res = json.decode(resp.body);
        resValue.clear();

        if (res.length > 0) {
          for (var i = 0; i < res.length; i++) {
            if (res[i]['status'] == "Running") {
              resCtrl.changegrey(false);
            }
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
          resCtrl.changeLoading(false);
          resCtrl.changegrey(true);
        }
      } catch (e) {
        errCtrl.err(context, e);
        resCtrl.changeLoading(false);
        resCtrl.changegrey(true);
      }
    } else {
      errCtrl.err(context, resp.statusCode);
      resCtrl.changeLoading(false);
    }

    return resp;
  }

  changeLoading(value) {
    isLoading.value = value;
    update();
  }

  changeDeleting(value) {
    isdeleting.value = value;
    update();
  }

  changegrey(value) {
    isgreyed.value = value;
    update();
  }
}
