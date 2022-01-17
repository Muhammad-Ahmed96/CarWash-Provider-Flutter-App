import 'dart:async';
import 'dart:convert';
// import 'dart:js';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/screens/packages/addPackage.dart';
import 'package:carwash_provider/screens/packages/packageItem.dart';
import 'package:carwash_provider/screens/packages/packages.dart';
import 'package:carwash_provider/screens/washeres/washers.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:carwash_provider/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'packageDetails.dart';

class AddWasher extends StatefulWidget {
  const AddWasher({Key? key}) : super(key: key);

  @override
  _AddWasher createState() {
    return _AddWasher();
  }
}

class _AddWasher extends State<AddWasher> {
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();

  AddWasher() {
    configLoading();
  }

  // @override
  void initState() {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    // ..customAnimation = CustomAnimation();
  }

  Future<void> addWasher(
      name, email, password, phone, address, city, postalCode) async {
    // https://carwash-back.herokuapp.com/company/v1/packages
    // var newprice = double.parse(price);
    // var newduration = double.parse(duration);
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var obj = {};
    obj['name'] = name;
    obj['phone'] = phone;
    obj['address'] = address;
    obj['city'] = city;
    obj['zip_code'] = postalCode;
    obj['company_id'] = companyId;
    obj['email'] = email;
    obj['password'] = password;
    if (this.passwordController.text != '' &&
        (this.passwordController.text == this.confirmPasswordController.text)) {
      obj['password'] = this.passwordController.text;
    }
    var url =
        Uri.parse('https://carwash-back.herokuapp.com/company/v1/washers');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(obj));
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Washers()),
          ModalRoute.withName("/Washers"));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error updating Washer..."),
          backgroundColor: Colors.red));
    }
  }

  bool validate() {
    bool flag = false;
    var msg = "";
    if (nameController.text == "") {
      msg += "Name cannot be blank";
      flag = true;
    }

    if (emailController.text == "") {
      msg += "Email cannot be blank";
      flag = true;
    }

    if (phoneController.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "Phone cannot be blank";
      flag = true;
    }

    if (cityController.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "City cannot be blank";
      flag = true;
    }

    if (addressController.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "Address cannot be blank";
      flag = true;
    }

    if (passwordController.text.length < 6) {
      if (flag) {
        msg += "\n";
      }
      msg += "Password should be atleast 6 characters";
      flag = true;
    }

    if (passwordController.text != confirmPasswordController.text) {
      if (flag) {
        msg += "\n";
      }
      msg += "Password does not match";
      flag = true;
    }

    if (flag) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }
    EasyLoading.dismiss();
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Add Washer"),
          centerTitle: true,
          // actions: [
          //   Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => AddPackage()));
          //         },
          //         child: Text(
          //           "Add New",
          //           style: TextStyle(color: Colors.grey),
          //           // color: Colors.grey,
          //           // size: 20,
          //         ),
          //       ))
          // ],
        ),
        body: FadedSlideAnimation(
          Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Theme.of(context).backgroundColor
                ], begin: Alignment.topCenter)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.splashBg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  // margin: EdgeInsets.only(top: deviceHeight * 0.18),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              EntryField("Name", "Enter Name", false,
                                  nameController, ''),
                              // Visibility(
                              //   child: Text('Title cannot be empty'),
                              //   visible: true,
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          EntryField("Email", "Enter Email", false,
                              emailController, ''),
                          SizedBox(
                            height: 10,
                          ),
                          PasswordField("Password", "Enter Password", false,
                              passwordController, true),
                          SizedBox(
                            height: 10,
                          ),
                          PasswordField(
                              "Confirm Password",
                              "Enter Confirm Password",
                              false,
                              confirmPasswordController,
                              true),
                          SizedBox(
                            height: 10,
                          ),
                          EntryField("Phone Number", "Enter Phone Number",
                              false, phoneController, ''),
                          SizedBox(
                            height: 10,
                          ),
                          EntryField("Address", "Enter Address", false,
                              addressController, ''),
                          SizedBox(
                            height: 10,
                          ),
                          EntryField(
                              "City", "Enter City", false, cityController, ''),
                          SizedBox(
                            height: 10,
                          ),
                          EntryField("Postal Code", "Enter Postal Code", false,
                              postalController, ''),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              EasyLoading.show(status: 'updating...');
                              if (!validate()) {
                                addWasher(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    addressController.text,
                                    cityController.text,
                                    postalController.text);
                              }
                              // showAlertDialog(context);
                            },
                            child: GradientButton("Submit"),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ],
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ));
  }
}
