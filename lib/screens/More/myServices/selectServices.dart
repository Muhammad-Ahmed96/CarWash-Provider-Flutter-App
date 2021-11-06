import 'package:carwash_provider/components/widgets.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';

class SelectServices extends StatefulWidget {
  @override
  _SelectServicesState createState() => _SelectServicesState();
}

class _SelectServicesState extends State<SelectServices> {
  List checked = [true, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: RadiantGradientMask(
                  child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                child: Center(
                  child: Text(
                    locale.done!.toUpperCase(),
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ))),
        ],
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
          locale.selectServices!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 15),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            List icons = [
              Icons.drive_eta,
              Icons.accessible,
              Icons.calendar_view_day,
              Icons.wb_sunny,
              Icons.drive_eta,
              Icons.accessible,
              Icons.calendar_view_day,
              Icons.wb_sunny
            ];
            List title = [
              locale.bodywash,
              locale.interiorCleaning,
              locale.engineDetailing,
              locale.carPolish,
              locale.bodywash,
              locale.interiorCleaning,
              locale.engineDetailing,
              locale.carPolish,
            ];

            return Container(
              color: Theme.of(context).backgroundColor,
              child: CheckboxListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                activeColor: Color(0xff29ee86),
                onChanged: (value) {
                  setState(() {
                    checked[index] = value;
                  });
                },
                checkColor: Theme.of(context).backgroundColor,
                value: checked[index],
                secondary: SimpleHomePageIcons(icons[index], 25.0, 12.0),
                title: Text(title[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
