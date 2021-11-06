import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/More/contactUs/contactUs.dart';
import 'package:carwash_provider/screens/More/myServices/serviceItem.dart';
import 'package:carwash_provider/screens/packages/packageItem.dart';
import 'package:carwash_provider/screens/vehicles/addVehicle.dart';
import 'package:carwash_provider/screens/vehicles/editVehicle.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'vehicleItem.dart';

class Vehicles extends StatelessWidget {
  Timer? _timer;

  Vehicles() {
    configLoading();
  }

  Future getVehicles() async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/vehicle_types.json');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<VehicleItem> servicesList = [];
    for (var s in jsonResult) {
      var s_image = '';
      if (s['image'] != null) {
        s_image = s['image'];
      }
      VehicleItem sItem = VehicleItem(s['id'], s['title'], s_image);
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
    EasyLoading.showSuccess('Use in initState');
  }

  deleteVehicle(context, id) async {
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/company/v1/vehicle_types/${id}');
    var response = await http.delete(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult['status']);
    if (jsonResult['status'] == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Vehicles()),
          ModalRoute.withName("/Vehicles"));
      // this.servicesList.removeWhere((item) => item.id == id);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error Deleting Vehicle..."),
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
        deleteVehicle(context, packageId);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Vehicles"),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AddVehicle()));
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
            future: getVehicles(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(child: Text("Loading...")),
                );
              } else {
                EasyLoading.dismiss();
                final data = snapshot.data as List<VehicleItem>;
                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 65),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        // padding: EdgeInsets.symmetric(vertical: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Assets.card_bg),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(data[index].vehicleType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 18)),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Description:",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(data[index].vehicleType,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Icon:",
                                          style: TextStyle(color: subtitle)),
                                      Image.network(
                                        "https://carwash-back.herokuapp.com/" +
                                            data[index].icon,
                                        height: 200,
                                        width: 200,
                                      ),
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
                                                            EditVehicle(
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
                                                showAlertDialog(
                                                    context, data[index].id);
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
    );
  }
}
