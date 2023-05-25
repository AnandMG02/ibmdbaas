import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/dashcontroller.dart';
import 'package:ibmdbaas/Home/controller/responsecontroller.dart';
import 'package:ibmdbaas/Home/page/deployment.dart';
import 'package:ibmdbaas/Home/widget/clustertable.dart';

void main() {
  testWidgets(
      'Deployment should display loading indicator while data is being fetched',
      (WidgetTester tester) async {
    // Create and initialize the necessary controllers
    final dashCtrl = DashController();
    final resCtrl = ResponseController();
    await tester.pumpWidget(
      GetMaterialApp(
        home: Deployment(),
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<DashController>(() => dashCtrl);
          Get.lazyPut<ResponseController>(() => resCtrl);
        }),
      ),
    );

    // Verify that the loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Verify that the ClusterTable is not displayed
    expect(find.byType(ClusterTable), findsNothing);
  });

  testWidgets('Deployment should display ClusterTable when data is available',
      (WidgetTester tester) async {
    // Create and initialize the necessary controllers
    final dashCtrl = DashController();
    final resCtrl = ResponseController();
    resCtrl.isLoading.value = false;
    dashCtrl.isdeployed.value = true;
    await tester.pumpWidget(
      GetMaterialApp(
        home: Deployment(),
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<DashController>(() => dashCtrl);
          Get.lazyPut<ResponseController>(() => resCtrl);
        }),
      ),
    );

    // Verify that the ClusterTable is displayed
    expect(find.byType(ClusterTable), findsOneWidget);

    // Verify that the loading indicator is not displayed
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
      'Deployment should display "No Deployment" when no data is available',
      (WidgetTester tester) async {
    // Create and initialize the necessary controllers
    final dashCtrl = DashController();
    final resCtrl = ResponseController();
    resCtrl.isLoading.value = false;
    dashCtrl.isdeployed.value = false;
    await tester.pumpWidget(
      GetMaterialApp(
        home: Deployment(),
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<DashController>(() => dashCtrl);
          Get.lazyPut<ResponseController>(() => resCtrl);
        }),
      ),
    );

    // Verify that the "No Deployment" text is displayed
    expect(find.text("No Deployment"), findsOneWidget);

    // Verify that the loading indicator is not displayed
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
