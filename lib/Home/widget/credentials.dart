import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibmdbaas/Home/controller/formdatacontroller.dart';

class Credentials extends StatelessWidget {
  Credentials({super.key});

  final FormDataController formCtrl = Get.find();

  final TextEditingController _usercontroller =
      TextEditingController(text: "root");
  final TextEditingController _pwdcontroller =
      TextEditingController(text: "rootpass");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Get.theme.primaryColor)),
      width: Get.width * 0.8,
      height: Get.height * 0.35,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Cluster Credentials",
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 20),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Container(
                    padding: const EdgeInsets.only(right: 50),
                    width: Get.width * 0.15,
                    child: TextFormField(
                      controller: _usercontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        formCtrl.setUser(val);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: 'User Name',
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                    padding: const EdgeInsets.only(right: 50),
                    width: Get.width * 0.15,
                    child: TextFormField(
                      controller: _pwdcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the password';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        formCtrl.setPWD(val);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    _pwdcontroller
        .dispose(); // Dispose of the controller when the screen is disposed
    _usercontroller.dispose();
  }
}
