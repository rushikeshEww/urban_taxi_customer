import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';
import 'package:urban_taxi_customer/common/utils.dart';
import 'package:urban_taxi_customer/pages/splash_page.dart';

void main() async {
  await registerControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
    ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Urban Taxi Customer',
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryGreen),
        useMaterial3: false,
      ),
      routes: {
        "/splash" : (context) => const SplashPage(),
      },
      initialRoute: "/splash",
    );
  }
}
