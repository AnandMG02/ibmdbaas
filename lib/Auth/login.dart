import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Auth/logincontroller.dart';
import 'package:ibmdbaas/Home/page/dashboard.dart';

import '../Home/widget/appwidget.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController lctrl = Get.put(LoginController(), permanent: true);
  final AppMainbar appbar = Get.put(AppMainbar());
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.appmainbar(null),
      body: Center(
          child: SizedBox(
        height: Get.height * 0.5,
        width: Get.width * 0.25,
        child: Card(
            child: Form(
                key: lctrl.loginFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontFamily: "VarelaRound",
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        width: Get.width * 0.25,
                        child: TextFormField(
                          controller: _usernamecontroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter user name';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            lctrl.setUsername(val);
                          },
                          decoration: InputDecoration(
                            suffixIcon: const SizedBox(width: 0.02),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            labelText: 'User Name',
                          ),
                          textAlign: TextAlign.justify,
                          textAlignVertical: TextAlignVertical.center,
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(
                      () => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          width: Get.width * 0.25,
                          child: TextFormField(
                            controller: _passcontroller,
                            keyboardType: TextInputType.text,
                            obscureText: lctrl.ispassvisible.value,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              lctrl.setPasswrd(val);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  lctrl.ispassvisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: lctrl.togglepassvisible,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              labelText: 'Password',
                            ),
                            textAlign: TextAlign.justify,
                            textAlignVertical: TextAlignVertical.center,
                          )),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (lctrl.loginFormKey.currentState!.validate()) {
                            lctrl.loginFormKey.currentState!.save();

                            lctrl.credValidation(lctrl.username, lctrl.passwrd);
                            if (lctrl.isauthenticated.value) {
                              Get.to(Dashboard(),
                                  transition: Transition.cupertino);
                            }
                          }
                        },
                        icon: const Icon(Icons.login),
                        label: const Text(
                          "Login",
                          style: TextStyle(fontFamily: "VarelaRound"),
                        )),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ))),
      )),
    );
  }
}
