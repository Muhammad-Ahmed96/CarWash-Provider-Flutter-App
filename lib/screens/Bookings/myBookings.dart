import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/Bookings/assignWasher.dart';
import 'package:carwash_provider/screens/Bookings/bookingDetails.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'bookingItem.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  Timer? _timer;

  _MyBookingsState() {
    configLoading();
  }

  Future getBookings() async {
    EasyLoading.show(status: 'loading...');

    final prefs = await SharedPreferences.getInstance();
    var companyId = prefs.getInt("token");
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/comp_bookings/${companyId}');
    var response = await http.get(url);
    var jsonResult = jsonDecode(response.body);
    print(jsonResult);
    List<BookingItem> bookingItemList = [];
    for (var b in jsonResult) {
      var firstname = '';
      if (b['user'] != null) {
        print("First Name = " + firstname);
        firstname = b['user']['first_name'].toString() == "null"
            ? ''
            : b['user']['first_name'].toString();
      }
      var washerName = 'No';
      if (b['washer'] != null) {
        washerName = b['washer']['name'].toString() == "null"
            ? ''
            : b['washer']['name'].toString();
      }
      BookingItem bitem = BookingItem(
          firstname,
          b['model'].toString(),
          b['date'].toString(),
          b['time'].toString(),
          b['total'].toString(),
          b['id'],
          '',
          b['washer_id'],
          washerName);
      bookingItemList.add(bitem);
    }
    print(bookingItemList.length);
    return bookingItemList;
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

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  unAssignWasher(context, washerId, bookingId) async {
    var url = Uri.parse(
        'https://carwash-back.herokuapp.com/company/v1/bookings/${bookingId}');
    var response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'washer_id': null, 'id': bookingId}));
    // var jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyBookings()),
          ModalRoute.withName("/Bookings"));
      return true;
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error Unassigning Agent..."),
          backgroundColor: Colors.red));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(locale.myBookings!),
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
            future: getBookings(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                EasyLoading.dismiss();
                return Container(
                  child: Center(child: Text("No Data to show...")),
                );
              } else {
                EasyLoading.dismiss();
                final data = snapshot.data as List<BookingItem>;
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
                                    BookingDetails(data[index].id)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
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
                              leading: FadedScaleAnimation(
                                CircleAvatar(
                                  foregroundImage: AssetImage(data[index]
                                              .image !=
                                          ''
                                      ? data[index].image
                                      : 'assets/placeholder/plc_profile.png'),
                                ),
                                durationInMilliseconds: 400,
                              ),
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
                              padding: EdgeInsets.only(left: 73),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(locale.vehicle!,
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(data[index].vehicle,
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
                                        locale.datetime!,
                                        style: TextStyle(color: subtitle),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                          data[index].date +
                                              " " +
                                              data[index].time,
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
                                      Text("Price",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(data[index].price,
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
                                      Text("Washer:",
                                          style: TextStyle(color: subtitle)),
                                      SizedBox(
                                        width: 35,
                                      ),
                                      Text(data[index].washerName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: TextButton(
                                    child: Text(data[index].washerId != null
                                        ? 'Unassign Agent'
                                        : 'Assign an agent'),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor:
                                          data[index].washerId != null
                                              ? Colors.red
                                              : Colors.teal,
                                      onSurface: Colors.grey,
                                    ),
                                    onPressed: () {
                                      if (data[index].washerId == null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AssignWasher(
                                                        data[index].id)));
                                      } else {
                                        EasyLoading.show(status: 'Loading....');
                                        unAssignWasher(
                                            context,
                                            data[index].washerId,
                                            data[index].id);
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
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

class BookingItem {
  String name, vehicle, date, time, price = '';
  String image = '';
  int id = 0;
  int? washerId;
  String washerName;
  BookingItem(this.name, this.vehicle, this.date, this.time, this.price,
      this.id, this.image, this.washerId, this.washerName);
}
