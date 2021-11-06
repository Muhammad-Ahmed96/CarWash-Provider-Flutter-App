import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/More/contactUs/contactUs.dart';
import 'package:carwash_provider/screens/More/more.dart';
import 'package:carwash_provider/screens/More/myServices/addService.dart';
import 'package:carwash_provider/screens/More/myServices/editService.dart';
import 'package:carwash_provider/screens/More/myServices/serviceItem.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'serviceDetails.dart';

class MyServices extends StatelessWidget {
  Timer? _timer;

  MyServices() {
    configLoading();
  }

  Future getServices() async {
    EasyLoading.show(status: 'loading...');
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/comp_services/${companyId}');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<ServiceItem> servicesList = [];
    for (var s in jsonResult['services']) {
      ServiceItem sItem = ServiceItem(s['title'], s['description'],
          s['duration'], s['price'].toString(), s['id'], s['company_id']);
      servicesList.add(sItem);
    }
    print(servicesList.length);
    EasyLoading.dismiss();
    return servicesList;
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

  deleteService(context, id) async {
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/services/${id}');
    var response = await http.delete(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult['status']);
    if (jsonResult['status'] == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigatonBarHome(1)),
          ModalRoute.withName("/Packages"));
      // this.servicesList.removeWhere((item) => item.id == id);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error Deleting Service..."),
          backgroundColor: Colors.red));
      return false;
    }
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
        deleteService(context, packageId);
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
              ModalRoute.withName("/Home"));
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("My Services"),
              centerTitle: true,
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddService()));
                      },
                      child: Text(
                        "Add New",
                        style: TextStyle(color: Colors.grey),
                        // color: Colors.grey,
                        // size: 20,
                      ),
                    )),
              ],
            ),
            body: Container(
              child: FutureBuilder(
                  future: getServices(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      EasyLoading.dismiss();
                      return Container(
                        child: Center(child: Text("Loading...")),
                      );
                    } else {
                      EasyLoading.dismiss();
                      final data = snapshot.data as List<ServiceItem>;
                      return ListView.builder(
                        padding: EdgeInsets.only(bottom: 65),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceDetails(data[index].id)));
                            },
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
                                    title: Text(data[index].title,
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
                                            Flexible(
                                              child: Text(
                                                "Description:",
                                                style:
                                                    TextStyle(color: subtitle),
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                                data[index].description.length >
                                                        50
                                                    ? data[index]
                                                            .description
                                                            .substring(0, 50) +
                                                        "..."
                                                    : data[index].description,
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
                                              "Price:",
                                              style: TextStyle(color: subtitle),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(data[index].price.toString(),
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
                                            Text("Duration:",
                                                style:
                                                    TextStyle(color: subtitle)),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                                data[index]
                                                        .duration
                                                        .toString() +
                                                    " " +
                                                    "mins",
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
                                                                  EditService(
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
            )));
  }
}
