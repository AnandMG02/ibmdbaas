import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:ibmdbaas/Home/controller/errcontroller.dart';
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodel.dart';
import 'package:ibmdbaas/Home/page/dashboard.dart';

class ClusterButton extends StatelessWidget {
  ClusterButton({super.key});

  final client = http.Client();
  // final url = "http://localhost:3000";
  final url =
      "https://ibmdbaas-nodeserver-git-hackathon2023-mongo-t-mobile.mycluster-wdc04-b3c-16x64-bcd9381b2e59a32911540577d00720d7-0000.us-east.containers.appdomain.cloud";
  final DashController dashCtrl = Get.find();
  final FormDataController formCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());
  final ErrorController errCtrl = Get.put(ErrorController());

  //function

  Future<http.Response> sendData(context, Data data) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'cluster': data.cluster,
        'user': data.user,
        'pwd': data.pwd,
        'cpu': data.cpu,
        'ram': data.ram,
        'storage': data.storage,
      }),
    );

    if (response.statusCode == 200) {
      try {
        final res = json.decode(response.body);
        final ResponseValue resValue = ResponseValue(
          cluster: res['clustername'],
          user: res['mongoUser'],
          ip: res['podip'],
          port: res['podport'].toString(),
          url: res['url'],
          status: res['status'],
        );

        dashCtrl.isActive.value = true;

        resCtrl.updateResData(resValue);
      } catch (e) {
        errCtrl.resmsg(context, "Cluster is Creating. Please Wait...");
      }
    } else {
      errCtrl.err(context, response.statusCode);
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => resCtrl.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Get.theme.primaryColor),
                ),
                onPressed: () {
                  resCtrl.changeLoading(true);
                  if (formCtrl.myFormKey.currentState!.validate()) {
                    formCtrl.myFormKey.currentState!.save();

                    final data = Data(
                        cluster: formCtrl.clusterName.value,
                        user: formCtrl.user.value,
                        pwd: formCtrl.pwd.value,
                        cpu: formCtrl.cpu.value,
                        ram: formCtrl.ram.value,
                        storage: formCtrl.storage.value);

                    sendData(context, data);
                    dashCtrl.deployChange(true);
                    resCtrl.getData(context).then(
                          (value) => Get.to(
                            Dashboard(),
                            transition: Transition.fade,
                            duration: const Duration(
                                seconds: 1), // Set the transition duration
                          ),
                        );
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
                label: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Create Cluster",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
    );
  }
}
