import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:frontend/app/app_theme/ColorTheme.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/modles/utils/api_services.dart';
import 'app/modles/utils/oauthentication.dart';
import 'app/app_routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton<OAuthSettings>(OAuthSettings());
  GetIt.I.registerSingleton<APIServices>(APIServices());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: ColorTheme.bgColor,
         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: ColorTheme.secondaryColor,
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: ColorTheme.white1)),
              labelStyle: TextStyle(color: ColorTheme.primaryColor)),
          ),
      title: "Smart Parking",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
