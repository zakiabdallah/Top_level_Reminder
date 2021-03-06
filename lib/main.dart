import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:tlr/LocaleProvider.dart';
import 'package:tlr/Pages/Connecter.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/Register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tlr/l10n/L10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          enableLights: true,
          enableVibration: true,
          playSound: true)
    ],
    // Channel groups are only visual and are not required
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
            locale: provider.locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all_locale,
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              "/cat": (BuildContext context) => MyHomePage(),
              "/proA": (BuildContext context) => MyHomePage(),
              "/proE": (BuildContext context) => MyHomePage(),
              "/home": (BuildContext context) => MyHomePage(),
              "/": (_) => authscreen(),
              "/sat": (BuildContext context) => MyHomePage(),
              "/acc": (BuildContext context) => MyHomePage(),
            },
          );
        }));
  }
}
