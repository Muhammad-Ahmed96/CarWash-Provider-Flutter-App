import 'dart:async';
import 'dart:convert';
// import 'dart:js';

import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/Bookings/myBookings.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/screens/packages/packageItem.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../washeres/washerItem.dart';

class AssignWasher extends StatelessWidget {
  Timer? _timer;
  int bookingId;

  AssignWasher(this.bookingId) {
    configLoading();
  }

  Future getWashers() async {
    EasyLoading.show(status: 'loading...');
    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/availablewashers/${this.bookingId}');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<AssignWsherItem> usersList = [];
    for (var s in jsonResult) {
      AssignWsherItem sItem = AssignWsherItem(
          s['id'], s['name'].toString(), s['bookings']['count']);
      usersList.add(sItem);
    }
    print(usersList.length);
    EasyLoading.dismiss();
    return usersList;
  }

  assignWasher(context, washerId) async {
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/bookings/${this.bookingId}');
    var response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'washer_id': washerId}));
    // var jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigatonBarHome(0)),
          ModalRoute.withName("/Bookings"));
      return true;
    } else {
      EasyLoading.dismiss();
      return false;
    }
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Washers"),
        centerTitle: true,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Icon(
          //     Icons.history,
          //     color: Colors.grey,
          //     size: 20,
          //   ),
          // )
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: getWashers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                EasyLoading.dismiss();
                return Container(
                  child: Center(child: Text("Loading...")),
                );
              } else {
                EasyLoading.dismiss();
                final data = snapshot.data as List<AssignWsherItem>;
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Washer Name:",
                                          style: TextStyle(color: subtitle)),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Reservations:",
                                        style: TextStyle(color: subtitle),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(data[index].bookings.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        child: TextButton(
                                          child: Text('Assign'),
                                          style: TextButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.teal,
                                            onSurface: Colors.grey,
                                          ),
                                          onPressed: () {
                                            EasyLoading.show(
                                                status: 'Assigning...');
                                            assignWasher(
                                                context, data[index].id);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             AssignWasher(
                                            //                 data[index].id)));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
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

class AssignWsherItem {
  int id;
  String name;
  int bookings;

  AssignWsherItem(this.id, this.name, this.bookings);
}
