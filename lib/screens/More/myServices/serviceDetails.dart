import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'serviceItem.dart';

class ServiceDetails extends StatefulWidget {
  final int serviceId;
  ServiceDetails(this.serviceId);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(this.serviceId);
}

class _ServiceDetailsState extends State<ServiceDetails> {
  final int serviceId;
  bool switchValue = true;
  Timer? _timer;

  _ServiceDetailsState(this.serviceId) {
    // getServiceDetails(this.serviceId);
    configLoading();
  }

  Future getServiceDetails(int id) async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/services/${id}');
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    print(res);
    ServiceItem bitem = new ServiceItem(res['title'], res['description'],
        res['duration'], res['price'], res['id'], res['company_id']);
    EasyLoading.dismiss();
    return bitem;
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    // var safeHeight = MediaQuery.of(context).size.height -
    //     AppBar().preferredSize.height -
    //     MediaQuery.of(context).padding.vertical;
    var locale = AppLocalizations.of(context)!;
    TextStyle whiteFont =
        Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15);
    return FadedSlideAnimation(
      Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            actions: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: Icon(
              //     Icons.more_vert,
              //     size: 20,
              //   ),
              // )
            ],
            titleSpacing: 0,
            leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: iconFgColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(
              "Service Details",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
          ),
          body: Container(
            child: FutureBuilder(
              future: getServiceDetails(this.serviceId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: Text("Loading...")),
                  );
                } else {
                  EasyLoading.dismiss();
                  final res = snapshot.data as ServiceItem;
                  return Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RadiantGradientMask(
                                          child: Text(
                                            "Title:",
                                            style: whiteFont.copyWith(
                                                color: Color(0xff29ee86)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${res.title}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 2nd

                                        RadiantGradientMask(
                                          child: Text(
                                            "Description:",
                                            style: whiteFont.copyWith(
                                                color: Color(0xff29ee86)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${res.description}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 3rd

                                        RadiantGradientMask(
                                          child: Text(
                                            "Duration:",
                                            style: whiteFont.copyWith(
                                                color: Color(0xff29ee86)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${res.duration} ${res.duration == "1" ? 'min' : 'mins'}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        //4th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Price:",
                                            style: whiteFont.copyWith(
                                                color: Color(0xff29ee86)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${res.price}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 70,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          )),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
