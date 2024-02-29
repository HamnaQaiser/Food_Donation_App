import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food_donation_app/Services/Chat_services.dart';
import 'package:food_donation_app/controller/LocationController.dart';
import 'package:food_donation_app/Services/Role_manager.dart';
import 'package:food_donation_app/controller/chatroomController.dart';

import 'package:food_donation_app/controller/donationController.dart';
import 'package:food_donation_app/controller/firebase_api.dart';
import 'package:food_donation_app/controller/login_controller.dart';
import 'package:food_donation_app/controller/mappController.dart';
import 'package:food_donation_app/controller/notification_services.dart';
import 'package:food_donation_app/controller/profile_controller.dart';
import 'package:food_donation_app/controller/register_controller.dart';
import 'package:food_donation_app/languages/languages.dart';
import 'package:food_donation_app/routes/route_name.dart';
import 'package:food_donation_app/routes/routes.dart';
import 'package:food_donation_app/utility/constants.dart';
import 'package:food_donation_app/views/screens/authentication/emailValidation.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:food_donation_app/views/screens/map/donationMap.dart';

import 'package:food_donation_app/views/screens/welcome_screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await findSystemLocale();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LocationController()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),

      // ChangeNotifierProvider(create: create)

    ],child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Locale('en','US'),
      fallbackLocale: Locale('en','US'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
         Locale('ur','PK'),
        Locale("en", "US"),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      builder: EasyLoading.init(),
      title: 'Food Connect',
      theme: ThemeData(
        indicatorColor: mainColor,
        primarySwatch: primaryMaterialColor,
        useMaterial3: true,
      ),
     // home: TestScreen(),
      home: SplashScreen(),
    ),);
  }
}
