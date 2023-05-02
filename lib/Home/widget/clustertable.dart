import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';

class ClusterTable extends StatelessWidget {
  ClusterTable({super.key});

  final DashController dashCtrl = Get.find();
  final ResponseController resCtrl = Get.put(ResponseController());

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
                        color: dashCtrl.isActive.value
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
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )),
              ]);
            })),
      ),
    );
  }
}
