import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/constants.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:carwash_provider/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SocialButtons extends StatelessWidget {
  final String title;
  final Color color;
  SocialButtons(this.title, this.color);
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), gradient: gradient),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 15,
              child: Image(
                  image: title == locale.facebook
                      ? AssetImage(Assets.facebook)
                      : AssetImage(Assets.google)),
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String? title;
  GradientButton(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient:
              LinearGradient(colors: [Color(0xff29ee86), Color(0xff3fa0d7)])),
      child: Center(
          child: Text(
        title!,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17),
      )),
    );
  }
}

AppBar appBar(BuildContext context, String title) {
  return AppBar(
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
    backgroundColor: Theme.of(context).primaryColor,
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    ),
  );
}

class EntryField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  final TextEditingController? controller;
  final String? initialValue;
  EntryField(this.labelText, this.hintText, this.showSuffixIcon,
      this.controller, this.initialValue);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextFormField(
          initialValue: this.initialValue,
          controller: this.controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined, color: iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class DigitField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  final TextEditingController? controller;
  final String? initialValue;
  DigitField(this.labelText, this.hintText, this.showSuffixIcon,
      this.controller, this.initialValue);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextFormField(
          initialValue: this.initialValue,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          controller: this.controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined, color: iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class TextAreaField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  final TextEditingController? controller;
  final String? initialValue;
  TextAreaField(this.labelText, this.hintText, this.showSuffixIcon,
      this.controller, this.initialValue);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextFormField(
          minLines: 5,
          maxLines: 10,
          initialValue: this.initialValue,
          controller: this.controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined, color: iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class PasswordField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  PasswordField(this.labelText, this.hintText, this.showSuffixIcon,
      this.controller, this.obscureText);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        TextFormField(
          obscureText: this.obscureText,
          controller: this.controller,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined, color: iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class EntryFieldNew extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool showSuffixIcon;
  EntryFieldNew(this.labelText, this.hintText, this.showSuffixIcon);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText!,
          textAlign: TextAlign.start,
          style:
              Theme.of(context).textTheme.bodyText2!.copyWith(color: subtitle),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: showSuffixIcon
                ? Icon(Icons.arrow_drop_down_outlined, color: iconFgColor)
                : null,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800]!)),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final Icon icon;
  final String title;
  DrawerListTile(this.icon, this.title);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      tileColor: Theme.of(context).backgroundColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class HomePageIcons extends StatelessWidget {
  final IconData icon;
  final size;
  final padding;
  HomePageIcons(this.icon, this.size, this.padding);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3fa0d7),
              blurRadius: 1.0,
              spreadRadius: 0.3,
            )
          ]),
      child: FadedScaleAnimation(
        Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
        durationInMilliseconds: 400,
      ),
    );
  }
}

class SimpleHomePageIcons extends StatelessWidget {
  final IconData icon;
  final size;
  final padding;
  SimpleHomePageIcons(this.icon, this.size, this.padding);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: iconBgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: FadedScaleAnimation(
        Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
        durationInMilliseconds: 400,
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomLeft,
          radius: 5,
          colors: <Color>[
            Color(0xff29ee86),
            Color(0xff3fa0d7),
          ],
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class RectGradientButton extends StatelessWidget {
  final String title;
  RectGradientButton(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(gradient: gradient),
      child: Center(
          child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
      )),
    );
  }
}
