import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/More/profileSetting/addLocation.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';

class ProfileSetting extends StatefulWidget {
  @override
  _ProfileSettingState createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: appBar(context, locale.profileSetting!),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ListView(
                padding: EdgeInsets.only(bottom: 50),
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        child: Opacity(
                          opacity: 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                              image: AssetImage(
                                Assets.layer_4,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Center(
                          child: HomePageIcons(Icons.camera_alt, 40.0, 15.0)),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  EntryFieldNew(locale.providerName, locale.dummyStore1, false),
                  SizedBox(
                    height: 25,
                  ),
                  EntryFieldNew(locale.phoneNumber, "+1 987 654 3210", false),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: EntryFieldNew(
                              locale.openingHours, "09:00 am", true)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: EntryFieldNew(
                              locale.closingTime, "09:00 am", true)),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.location!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: subtitle),
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddLocation()));
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon:
                              Icon(Icons.chevron_right, color: iconFgColor),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!)),
                          hintText: locale.dummyAddress1,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.about!,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: subtitle),
                      ),
                      TextFormField(
                        maxLength: 200,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[800]!)),
                          hintText: locale.lorem,
                          hintStyle: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      height: 55,
                      child: GradientButton(locale.updateInfo))),
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
