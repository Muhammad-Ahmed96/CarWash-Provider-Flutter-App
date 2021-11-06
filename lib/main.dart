import 'package:carwash_provider/map_utils.dart';
import 'package:carwash_provider/screens/Auth/signin/ui/signin_ui.dart';
import 'package:carwash_provider/screens/home.dart';
import 'package:carwash_provider/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'language/languageCubit.dart';
import 'language/locale.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapUtils.getMarkerPic();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<int> getLogginData() => UserPreferences.getToken();

  @override
  Widget build(BuildContext context) {
    {
      return BlocProvider<LanguageCubit>(
        create: (context) => LanguageCubit(),
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) {
            return MaterialApp(
                builder: EasyLoading.init(),
                localizationsDelegates: [
                  const AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en'),
                  const Locale('ar'),
                  const Locale('pt'),
                  const Locale('fr'),
                  const Locale('id'),
                  const Locale('es'),
                  const Locale('tr'),
                  const Locale('it'),
                  const Locale('sw'),
                ],
                locale: locale,
                theme: uiTheme(),
                debugShowCheckedModeBanner: false,
                home: FutureBuilder(
                  future: getLogginData(),
                  builder: (context, snapshot) {
                    // switch (snapshot.connectionState) {
                    //   case ConnectionState.waiting:
                    //     return Signin();
                    //   case ConnectionState.active:
                    //   case ConnectionState.done:
                    //     if (snapshot.hasData) {
                    //       // return (snapshot.data.authToken != null)
                    //       //     ? DashboardPage()
                    //       //     : LoginPage();
                    //       print("*********************************");
                    //       print(snapshot.data);
                    //     }
                    //     return Container(); // error view
                    //   default:
                    //     return Container(); // error view
                    // }
                    print(snapshot.data);
                    if (snapshot.data == null || snapshot.data == 0) {
                      print("*****************************************");
                      return Signin();
                    } else {
                      print("###########################################");
                      return NavigatonBarHome(0);
                    }
                  },
                ));
          },
        ),
      );
    }
  }
}
