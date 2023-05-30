import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMainbar extends GetxController {
  PreferredSizeWidget appmainbar(icon) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Icon(Icons.cloud, color: Colors.black),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "IBM DBaaS",
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: icon,
      ),
    );
  }
}
