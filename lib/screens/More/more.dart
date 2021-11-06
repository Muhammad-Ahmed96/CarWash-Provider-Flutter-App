import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/Auth/signin/ui/signin_ui.dart';
import 'package:carwash_provider/screens/More/contactUs/contactUs.dart';
import 'package:carwash_provider/screens/More/myServices/myServices.dart';
import 'package:carwash_provider/screens/More/profileSetting/profileSetting.dart';
import 'package:carwash_provider/screens/More/selectLanguage/selectLanguage.dart';
import 'package:carwash_provider/screens/coupons/coupons.dart';
import 'package:carwash_provider/screens/packages/packages.dart';
import 'package:carwash_provider/screens/users/users.dart';
import 'package:carwash_provider/screens/washeres/washers.dart';
import 'package:carwash_provider/screens/vehicles/vehicles.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signOut() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt("token", 0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signin()));
    }

    var locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: 60),
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    Assets.layer_4,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            // Container(
            //   color: Theme.of(context).backgroundColor,
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Text(
            //         locale.dummyStore1!,
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyText1!
            //             .copyWith(fontSize: 22),
            //       ),
            //       SizedBox(
            //         height: 5,
            //       ),
            //       Text(
            //         locale.dummyAddress1!,
            //         style: Theme.of(context)
            //             .textTheme
            //             .bodyText2!
            //             .copyWith(fontSize: 13),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => ProfileSetting()));
                  //   },
                  //   child: ListTile(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  //     leading: FadedScaleAnimation(
                  //       Icon(
                  //         Icons.settings,
                  //         size: 23,
                  //         color: iconFgColor,
                  //       ),
                  //       durationInMilliseconds: 400,
                  //     ),
                  //     title: Text(
                  //       locale.profileSetting!,
                  //       style: TextStyle(color: Colors.grey[400]),
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Packages()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      leading: FadedScaleAnimation(
                        Icon(
                          Icons.list,
                          size: 23,
                          color: iconFgColor,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      title: Text(
                        "Packages",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Vehicles()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      leading: FadedScaleAnimation(
                        Icon(
                          Icons.time_to_leave,
                          size: 23,
                          color: iconFgColor,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      title: Text(
                        "Vehicles",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => ContactUs()));
                  //   },
                  //   child: ListTile(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  //     leading: FadedScaleAnimation(
                  //       Icon(
                  //         Icons.email,
                  //         size: 23,
                  //         color: iconFgColor,
                  //       ),
                  //       durationInMilliseconds: 400,
                  //     ),
                  //     title: Text(
                  //       locale.contactUs!,
                  //       style: TextStyle(color: Colors.grey[400]),
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Users()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      leading: FadedScaleAnimation(
                        Icon(
                          Icons.manage_accounts,
                          size: 23,
                          color: iconFgColor,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      title: Text(
                        "Users",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   contentPadding:
                  //       EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  //   leading: FadedScaleAnimation(
                  //     Icon(
                  //       Icons.exit_to_app,
                  //       size: 23,
                  //       color: iconFgColor,
                  //     ),
                  //     durationInMilliseconds: 400,
                  //   ),
                  //   title: Text(
                  //     locale.account!,
                  //     style: TextStyle(color: Colors.grey[400]),
                  //   ),
                  // ),

                  SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Washers()));
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      leading: FadedScaleAnimation(
                        Icon(
                          Icons.manage_accounts,
                          size: 23,
                          color: iconFgColor,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      title: Text(
                        "Washers",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => Coupons()));
                  //   },
                  //   child: ListTile(
                  //     contentPadding:
                  //         EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  //     leading: FadedScaleAnimation(
                  //       Icon(
                  //         Icons.manage_accounts,
                  //         size: 23,
                  //         color: iconFgColor,
                  //       ),
                  //       durationInMilliseconds: 400,
                  //     ),
                  //     title: Text(
                  //       "Coupons",
                  //       style: TextStyle(color: Colors.grey[400]),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () {
                      signOut();
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                      leading: FadedScaleAnimation(
                        Icon(
                          Icons.exit_to_app,
                          size: 23,
                          color: iconFgColor,
                        ),
                        durationInMilliseconds: 400,
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
