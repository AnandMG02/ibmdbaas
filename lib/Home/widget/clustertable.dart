import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/errcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';

class ClusterTable extends StatelessWidget {
  ClusterTable({super.key});

  final DashController dashCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());
  final ErrorController errCtrl = Get.put(ErrorController());

  //function

  Future<void> deletePod(context, String podName) async {
    final url = Uri.parse(
        "https://ibmdbaas-nodeserver-git-hackathon2023-mongo-t-mobile.mycluster-wdc04-b3c-16x64-bcd9381b2e59a32911540577d00720d7-0000.us-east.containers.appdomain.cloud/pods/$podName");

    try {
      final response = await http.delete(url);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        resCtrl.changeDeleting(false);
        errCtrl.resmsg(
            context, responseBody['message']); // Pod deleted successfully!
      } else {
        resCtrl.changeDeleting(false);
        resCtrl.changegrey(true);
        errCtrl.resmsg(context, "Pod is deleting. Please Wait..");
      }
    } catch (error) {
      errCtrl.err(context, error); // Failed to delete pod!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(30.0),
        child: DataTable(
            columns: const [
              DataColumn(
                label: Text('Cluster'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn(
                label: Text('Connection'),
              ),
              DataColumn(
                label: Text('Action'),
              ),
            ],
            rows: List<DataRow>.generate(resCtrl.data.length, (i) {
              return DataRow(cells: [
                DataCell(Text(resCtrl.data[i].cluster)),
                DataCell(Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: resCtrl.data[i].status == "Running"
                            ? Colors.green
                            : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(resCtrl.data[i].status),
                    ),
                  ],
                )),
                DataCell(Text("${resCtrl.data[i].ip}:${resCtrl.data[i].port}")),
                DataCell(resCtrl.isgreyed.value
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              errCtrl.resmsg(context, "Pod is Not Available");
                            },
                            icon: const Icon(Icons.copy),
                          ),
                          resCtrl.isdeleting.value
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  onPressed: () {
                                    errCtrl.resmsg(
                                        context, "Pod is Not Available");
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              FlutterClipboard.copy(resCtrl.data[i].url);
                              errCtrl.resmsg(context, "Url is Copied");
                            },
                            icon: const Icon(Icons.copy),
                          ),
                          resCtrl.isdeleting.value
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  onPressed: () {
                                    resCtrl.changeDeleting(true);
                                    deletePod(context, resCtrl.data[i].cluster);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      )),
              ]);
            })),
      ),
    );
  }
}
