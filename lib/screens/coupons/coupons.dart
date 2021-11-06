import 'dart:async';
import 'dart:convert';

import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/packages/packageItem.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'couponItem.dart';

class Coupons extends StatelessWidget {
  Timer? _timer;

  Coupons() {
    configLoading();
  }

  Future getCoupons() async {
    EasyLoading.show(status: 'loading...');
    var url =
        Uri.parse('https://carwash-back.herokuapp.com/company/v1/coupons');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    List<CouponItem> couponsList = [];
    for (var s in jsonResult['data']) {
      CouponItem sItem = CouponItem(s['id'], s['name'].toString(),
          s['percent_off'], s['duration_in_months'], s['duration']);
      couponsList.add(sItem);
    }
    print(couponsList.length);
    EasyLoading.dismiss();
    return couponsList;
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
        title: Text("Coupons"),
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
            future: getCoupons(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(child: Text("Loading...")),
                );
              } else {
                EasyLoading.dismiss();
                final data = snapshot.data as List<CouponItem>;
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
                                      Text("Name:",
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
                                        "Percent Reduction:",
                                        style: TextStyle(color: subtitle),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                          data[index]
                                              .percentReduction
                                              .toString(),
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
                                      Text("Duration:",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].duration,
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
                                      Text("Duration Months:",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          data[index]
                                              .durationInMonths
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Column(
                                  //       children: [
                                  //         GestureDetector(
                                  //           onTap: () {
                                  //             Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         ContactUs()));
                                  //           },
                                  //           child: Icon(
                                  //             Icons.edit,
                                  //             size: 23,
                                  //             color: iconFgColor,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //     Column(
                                  //       children: [
                                  //         GestureDetector(
                                  //           onTap: () {
                                  //             Navigator.push(
                                  //                 context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) =>
                                  //                         ContactUs()));
                                  //           },
                                  //           child: Icon(
                                  //             Icons.delete,
                                  //             size: 23,
                                  //             color: iconFgColor,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //   ],
                                  // )
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
