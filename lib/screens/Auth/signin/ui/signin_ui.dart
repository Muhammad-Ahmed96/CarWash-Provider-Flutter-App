import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
// import 'package:carwash_provider/screens/Auth/forgotPassword/ui/forgotPassword_ui.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/user_preferences.dart';
// import 'package:carwash_provider/screens/Auth/forgotPassword/ui/forgotPassword_ui.dart';
// import 'package:carwash_provider/screens/Auth/signin/backend/countries.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Timer? _timer;
  String? _country;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  _SigninState() {
    configLoading();
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

  Future<void> login(email, password) async {
    var url =
        Uri.parse('https://carwash-back.herokuapp.com/company_auth/sign_in');
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    if (json.decode(response.body)['success'] == null) {
      UserPreferences.setToken(json.decode(response.body)['data']['id']);
      EasyLoading.dismiss();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NavigatonBarHome(0)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Email/Password"),
          backgroundColor: Colors.red));
      UserPreferences.setToken(0);
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FadedSlideAnimation(
        Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.transparent,
                Theme.of(context).backgroundColor
              ], begin: Alignment.topCenter)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.splashBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                // margin: EdgeInsets.only(top: deviceHeight * 0.18),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Spacer(flex: 3),

                    // Row(
                    //   children: [
                    Container(
                      color: Colors.transparent,
                      height: deviceHeight * 0.12,
                      child: Image(image: AssetImage(Assets.logo)),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            EntryField("Email Addess", "Enter Email Address",
                                false, emailController, ""),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        PasswordField("Password", "Enter Password", false,
                            passwordController, true),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            EasyLoading.show(status: 'loading...');
                            login(
                                emailController.text, passwordController.text);
                          },
                          child: GradientButton(locale.continuee),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
