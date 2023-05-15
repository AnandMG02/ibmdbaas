import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/datamodel.dart';
import 'package:http/http.dart' as http;
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/controller/responsemodel.dart';

class ClusterButton extends StatelessWidget {
  ClusterButton({super.key});

  final client = http.Client();
  final url = "http://localhost:3000/";

  final DashController dashCtrl = Get.find();
  final FormDataController formCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());

  //function

  Future<http.Response> sendData(Data data) async {
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
        print('Error decoding JSON response: $e');
      }
    } else {
      print('Error: ${response.statusCode}');
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Get.theme.primaryColor),
        ),
        onPressed: () {
          if (formCtrl.myFormKey.currentState!.validate()) {
            formCtrl.myFormKey.currentState!.save();

            final data = Data(
                cluster: formCtrl.clusterName.value,
                user: formCtrl.user.value,
                pwd: formCtrl.pwd.value,
                cpu: formCtrl.cpu.value,
                ram: formCtrl.ram.value,
                storage: formCtrl.storage.value);

            sendData(data);
            dashCtrl.deployChange(true);
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
    );
  }
}
