import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/map.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';

class AddLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return FadedSlideAnimation(
      Scaffold(
        appBar: AppBar(
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
            locale.addNewLocation!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        body: Stack(children: [
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage(Assets.map), fit: BoxFit.cover)),
          // ),
          MapPage(),
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    hintText: locale.searchLocation,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15, color: subtitle),
                    suffixIcon: Icon(
                      Icons.gps_fixed,
                      color: Colors.grey,
                    ))),
          ),
          Positioned(
              top: 230,
              left: 155,
              child: FadedScaleAnimation(
                Container(
                    height: 55, child: Image(image: AssetImage(Assets.mark))),
                durationInMilliseconds: 400,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 170,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  EntryField(locale.enterAddressDetails, locale.dummyAddress1,
                      false, null, ""),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: GradientButton(locale.save))
                ],
              ),
            ),
          ),
        ]),
      ),
      beginOffset: Offset(0, 0.3),
      endOffset: Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}
