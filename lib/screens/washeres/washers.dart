import 'dart:async';
import 'dart:convert';

import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/More/more.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/screens/packages/packageItem.dart';
import 'package:carwash_provider/screens/washeres/addWasher.dart';
import 'package:carwash_provider/screens/washeres/editWasher.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'washerItem.dart';

class Washers extends StatelessWidget {
  Timer? _timer;

  Washers() {
    configLoading();
  }

  Future getWashers() async {
    EasyLoading.show(status: 'loading...');
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/comp_washers/${companyId}');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<WasherItem> usersList = [];
    for (var s in jsonResult['washers']) {
      WasherItem sItem = WasherItem(
          s['id'],
          s['name'].toString(),
          s['email'].toString(),
          s['phone'].toString(),
          s['address'].toString(),
          s['city'].toString(),
          s['zip_code'].toString());
      usersList.add(sItem);
    }
    print(usersList.length);
    EasyLoading.dismiss();
    return usersList;
  }

  // @override
  void initState() {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
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

  deleteWasher(context, id) async {
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/washer/delete/${id}');
    var response = await http.delete(url);
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Washers()),
          ModalRoute.withName("/Washers"));
      // this.servicesList.removeWhere((item) => item.id == id);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error Deleting Washer..."),
          backgroundColor: Colors.red));
      return false;
    }
  }

  showAlertDialog(BuildContext context, int packageId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        deleteWasher(context, packageId);
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(
        "Are you sure want to delete ?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => More()),
              ModalRoute.withName("/Washers"));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Washers"),
            centerTitle: true,
            actions: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddWasher()));
                    },
                    child: Text(
                      "Add New",
                      style: TextStyle(color: Colors.grey),
                      // color: Colors.grey,
                      // size: 20,
                    ),
                  ))
            ],
          ),
          body: Container(
            child: FutureBuilder(
                future: getWashers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    EasyLoading.dismiss();
                    return Container(
                      child: Center(child: Text("No Data to show...")),
                    );
                  } else {
                    EasyLoading.dismiss();
                    final data = snapshot.data as List<WasherItem>;
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 65),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            // padding: EdgeInsets.symmetric(vertical: 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Assets.card_bg),
                                  fit: BoxFit.cover),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(data[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 18)),
                                  // subtitle: Padding(
                                  //   padding:
                                  //       const EdgeInsets.symmetric(vertical: 5),
                                  //   child: Text(data[index].name,
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyText2!
                                  //           .copyWith(fontSize: 12)),
                                  // ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Name:",
                                              style:
                                                  TextStyle(color: subtitle)),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(data[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email:",
                                            style: TextStyle(color: subtitle),
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          Text(data[index].email,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Telephone:",
                                              style:
                                                  TextStyle(color: subtitle)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(data[index].phone,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("City:",
                                              style:
                                                  TextStyle(color: subtitle)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(data[index].city,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Address:",
                                              style:
                                                  TextStyle(color: subtitle)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(data[index].address,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Zip Code:",
                                              style:
                                                  TextStyle(color: subtitle)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(data[index].postalCode,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(fontSize: 13))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditWasher(
                                                                    data[index]
                                                                        .id)));
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 23,
                                                    color: iconFgColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             ContactUs()));
                                                    showAlertDialog(context,
                                                        data[index].id);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 23,
                                                    color: iconFgColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
        ));
  }
}
