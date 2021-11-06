import 'dart:async';
import 'dart:convert';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'bookingItem.dart' as bookingitem;

class BookingDetails extends StatefulWidget {
  final int bookingId;
  BookingDetails(this.bookingId);

  @override
  _BookingDetailsState createState() => _BookingDetailsState(this.bookingId);
}

class _BookingDetailsState extends State<BookingDetails> {
  final int bookingId;
  bool switchValue = true;
  Timer? _timer;

  _BookingDetailsState(this.bookingId) {
    // getBookingDetail(this.bookingId);
    configLoading();
  }

  Future getBookingDetail(int id) async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/bookings/${id}');
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    print(res);
    bookingitem.BookingItem bitem = new bookingitem.BookingItem(
        res['id'],
        res['washer_id'],
        res['status'],
        res['paid'],
        res['user']['id'],
        res['package']?['id'],
        res['service']?['id'],
        res['date'],
        res['time'],
        res['total'],
        res['paymenttype'],
        res['total_duration'],
        res['vehicle_type'],
        res['address'],
        res['brand'],
        res['model'],
        res['user']?['first_name'],
        res['user']?['last_name'],
        res['user']?['email'],
        res['user']?['phone_number'],
        res['user']?['vehicle_number'],
        res['user']?['vehicle_color'],
        res['package']?['title'],
        res['package']?['description'],
        res['package']?['duration'],
        res['package']?['price'],
        res['service']?['title'],
        res['service']?['description'],
        res['service']?['duration'],
        res['service']?['price'],
        res['washer']?['name'],
        res['lat'],
        res['lng']);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                ),
              )
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
              locale.bookingDetails!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
          ),
          body: Container(
            child: FutureBuilder(
              future: getBookingDetail(this.bookingId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: Text("Loading...")),
                  );
                } else {
                  EasyLoading.dismiss();
                  final res = snapshot.data as bookingitem.BookingItem;
                  // bookingitem.BookingItem bitem = new bookingitem.BookingItem(
                  //   res['id'],
                  //   res['washer_id'],
                  //   res['status'],
                  //   res['paid'],
                  //   res['user']['id'],
                  //   res['package']?['id'],
                  //   res['service']?['id'],
                  //   res['date'],
                  //   res['time'],
                  //   res['total'],
                  //   res['paymenttype'],
                  //   res['duration'],
                  //   res['vehicletype'],
                  //   res['address'],
                  //   res['brand'],
                  //   res['model'],
                  //   res['user']?['first_name'],
                  //   res['user']?['last_name'],
                  //   res['user']?['email'],
                  //   res['user']?['phone_number'],
                  //   res['user']?['vehicle_number'],
                  //   res['user']?['vehicle_color'],
                  //   res['package']?['title'],
                  //   res['package']?['description'],
                  //   res['package']?['duration'],
                  //   res['package']?['price'],
                  //   res['service']?['title'],
                  //   res['service']?['description'],
                  //   res['service']?['duration'],
                  //   res['service']?['price'],
                  //   res['washer']?['name'],
                  //   res['lat'],
                  //   res['lng']);
                  return Stack(
                    children: [
                      ListView(
                        physics: BouncingScrollPhysics(),
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            locale.bookedBy!,
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
                                              '${res.userFirstName} ${res.userLastName}',
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
                                            "Telephone:",
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
                                              '${res.userPhoneNumber}',
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
                                            "Email:",
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
                                              '${res.userEmail}',
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
                                            "Address:",
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
                                              '${res.address}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 5th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Vehicle Type:",
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
                                              '${res.vehicletype}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 6th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Brand:",
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
                                              '${res.brand}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 7th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Model:",
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
                                              '${res.model}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 8th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Vehicle Color:",
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
                                              '${res.userVehicleColor == null ? "" : res.userVehicleColor}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 9th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Washing Formula:",
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
                                              '${res.packageTitle}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 10th
                                        RadiantGradientMask(
                                          child: Text(
                                            "Washing Option:",
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
                                              '${res.serviceTitle}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 11th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Time:",
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
                                              '${res.time}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 12th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Date:",
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
                                              '${res.date}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 13th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Total Duration:",
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
                                              '${res.duration}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        //14th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Status:",
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
                                              '${res.status}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 15th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Total:",
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
                                              '${res.total}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 16th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Payment Type:",
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
                                              '${res.paymenttype}',
                                              style: whiteFont,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 3,
                                          color: darkBg,
                                        ),

                                        // 17th

                                        RadiantGradientMask(
                                          child: Text(
                                            "Payment Status:",
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
                                              '${res.paid}',
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
