import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';

class ClusterTable extends StatelessWidget {
  ClusterTable({super.key});

  final DashController dashCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());

  //function

  Future<void> deletePod(String podName) async {
    final url = Uri.parse('http://localhost:3000/pods/$podName');

    try {
      final response = await http.delete(url);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responseBody['message']); // Pod deleted successfully!
      } else {
        print(responseBody['message']); // Failed to delete pod!
      }
    } catch (error) {
      print('An error occurred while deleting the pod: $error');
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
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(resCtrl.data[i].url);
                      },
                      icon: const Icon(Icons.copy),
                    ),
                    IconButton(
                      onPressed: () {
                        deletePod(resCtrl.data[i].cluster);
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
