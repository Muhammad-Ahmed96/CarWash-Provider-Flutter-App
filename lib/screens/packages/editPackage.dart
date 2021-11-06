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
import 'package:carwash_provider/style/colors.dart';
import 'package:carwash_provider/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'packageDetails.dart';

class EditPackage extends StatefulWidget {
  final int packageId;
  EditPackage(this.packageId);

  @override
  _EditPackage createState() => _EditPackage(this.packageId);
}

class _EditPackage extends State<EditPackage> {
  final int packageId;
  // final PackageItem packageItem;
  // _EditPackage(this.packageId);
  Timer? _timer;
  final titleController = TextEditingController();
  final durationController = TextEditingController();
  final priceControlller = TextEditingController();
  final descriptionController = TextEditingController();

  final bool _titleValidate = false;
  final bool _durationValidate = false;
  final bool _priceValidate = false;
  final bool _descriptionValidate = false;

  _EditPackage(this.packageId) {
    // EasyLoading.show("Loading...");
    configLoading();
    EasyLoading.show(status: "Fetching...");
    // packageItem = getPackage(this.packageId)
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

  Future getPackage(int id) async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/packages/${id}');
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    print(res);
    PackageItem bitem = new PackageItem(res['title'], res['description'],
        res['duration'], res['price'], res['id'], res['company_id']);
    EasyLoading.dismiss();
    return bitem;
  }

  // bool updatePackage() {
  //   // https://carwash-back.herokuapp.com/company/v1/packages//42
  // }

  Future<void> updatePackage(
      id, title, duration, price, description, companyId) async {
    // https://carwash-back.herokuapp.com/company/v1/packages
    var newprice = double.parse(price);
    var newduration = double.parse(duration);
    // final prefs = await SharedPreferences.getInstance();
    // var companyId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/packages/${id}');
    var response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'title': title,
          'duration': newduration,
          'price': newprice,
          'description': description,
          'company_id': companyId
        }));
    // print("response");
    EasyLoading.dismiss();
    if (response.body == "true") {
      // Navigator.pop(context)
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Packages()),
      //     ModalRoute.withName("/Home"));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Packages()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error updating Package..."),
          backgroundColor: Colors.red));
    }
    // print(response.body);
    // if (json.decode(response.body)['success'] == null) {
    //   EasyLoading.dismiss();
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => NavigatonBarHome()));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Invalid Email/Password"),
    //       backgroundColor: Colors.red));
    //   UserPreferences.setToken(0);
    //   EasyLoading.dismiss();
    // }
  }

  bool validate() {
    bool flag = false;
    var msg = "";
    if (titleController.text == "") {
      msg += "Title cannot be blank";
      flag = true;
    }

    if (durationController.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "Duration cannot be blank";
      flag = true;
    }

    if (priceControlller.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "Price cannot be blank";
      flag = true;
    }

    if (descriptionController.text == "") {
      if (flag) {
        msg += "\n";
      }
      msg += "Description cannot be blank";
      flag = true;
    }

    if (flag) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red));
    }

    return flag;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Edit Package"),
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
        body: Container(
          child: FutureBuilder(
            future: getPackage(this.packageId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                EasyLoading.dismiss();
                final res = snapshot.data as PackageItem;
                this.titleController.text = res.title;
                this.priceControlller.text = res.price;
                this.durationController.text = res.duration;
                this.descriptionController.text = res.description;
                return FadedSlideAnimation(
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
                              // Spacer(flex: 3),

                              // // Row(
                              // //   children: [
                              // Container(
                              //   color: Colors.transparent,
                              //   height: deviceHeight * 0.12,
                              //   child: Image(image: AssetImage(Assets.logo)),
                              // ),
                              SizedBox(
                                height: 60,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      EntryField("Title", "Enter Title", false,
                                          titleController, res.title),
                                      // Visibility(
                                      //   child: Text('Title cannot be empty'),
                                      //   visible: true,
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DigitField(
                                      "Duration",
                                      "Enter Duration",
                                      false,
                                      durationController,
                                      res.duration.toString()),
                                  // Column(children: [
                                  //   Visibility(
                                  //     child: Text(
                                  //       'Duration cannot be empty',
                                  //       textAlign: TextAlign.end,
                                  //       style: TextStyle(color: Colors.red),
                                  //     ),
                                  //     visible: true,
                                  //   ),
                                  // ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DigitField("Price", "Enter Price", false,
                                      priceControlller, res.price.toString()),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextAreaField(
                                      "Description",
                                      "Enter Description",
                                      false,
                                      descriptionController,
                                      res.description),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      EasyLoading.show(status: 'updating...');
                                      if (!validate()) {
                                        updatePackage(
                                            res.id,
                                            titleController.text,
                                            durationController.text,
                                            priceControlller.text,
                                            descriptionController.text,
                                            res.companyId);
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
                );
              }
            },
          ),
        ));
  }
}
