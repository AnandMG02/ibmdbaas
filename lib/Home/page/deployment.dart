import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/controller/responseModel.dart';

import 'package:ibmdbaas/Home/widget/clustertable.dart';
import 'package:http/http.dart' as http;

class Deployment extends StatelessWidget {
  Deployment({super.key});

  final client = http.Client();
  final url = "http://localhost:3000/pods";
  late List<ResponseValue> resValue = [];

  final DashController dashCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());

  Future<http.Response> getData() async {
    final resp = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      try {
        final res = json.decode(resp.body);
        resValue.clear();
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
      } catch (e) {
        print('Error decoding JSON response: $e');
      }
    } else {
      print('Error: ${resp.statusCode}');
    }

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Database Deployments",
                    style:
                        TextStyle(fontSize: 30, color: Get.theme.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                      onPressed: () {
                        getData();
                      },
                      icon: const Icon(Icons.refresh)),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Obx(
                () => SizedBox(
                    height: Get.height * 0.6,
                    width: Get.width * 0.8,
                    child: dashCtrl.isdeployed.value
                        ? SingleChildScrollView(child: ClusterTable())
                        : const Center(child: Text("No Deployment"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
