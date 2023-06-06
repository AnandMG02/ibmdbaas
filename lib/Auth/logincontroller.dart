import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static const _defaultUser = "admin";
  static const _defalutpass = "admin";
  late RxString username = "".obs;
  late RxString passwrd = "".obs;
  final RxBool isauthenticated = false.obs;
  final RxBool ispassvisible = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  togglepassvisible() {
    ispassvisible.value = !ispassvisible.value;
  }

  setUsername(user) {
    username.value = user;
    update();
  }

  setPasswrd(pass) {
    passwrd.value = pass;
    update();
  }

  credValidation(user, pass) {
    if (user == _defaultUser && pass == _defalutpass) {
      isauthenticated.value = true;
    } else {
      isauthenticated.value = false;
    }
  }
}
