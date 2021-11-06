import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var safeHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Container(
        foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.transparent, Theme.of(context).primaryColor],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        )),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
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
            backgroundColor: Colors.transparent,
            title: Text(
              locale.verification!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1),
            ),
          ),
          body: FadedSlideAnimation(
            SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: safeHeight,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          locale.enterVerificationCodeWeveSent!,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        EntryField(locale.enterVerificationCode, "5 8 7 4 1 1",
                            false, null, ""),
                        SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          child: GradientButton(locale.submit),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigatonBarHome(0)));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ));
  }
}
