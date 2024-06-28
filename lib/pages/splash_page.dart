import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';
import 'package:urban_taxi_customer/common/string_constants.dart';
import 'package:urban_taxi_customer/pages/home_page.dart';
import 'package:urban_taxi_customer/pages/login_screen.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  final storage = GetStorage(StringConstants.storageName);


  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(// Transparent status bar
    //   statusBarIconBrightness: Brightness.light // Dark text for status bar
    // ));

    Timer(
      const Duration(seconds: 2), () {
        if (storage.hasData(StringConstants.bearerToken) && storage.hasData(StringConstants.userLoginData)) {
          Get.off(() => HomePage());
        } else {
          Get.off(() => LoginScreen());
        }
      }
    );

    return Scaffold(
      backgroundColor: ColorConstants.primaryGreen,
      body: Center(
        child: SvgPicture.asset(
          "assets/images/ic_urban_text_splash.svg"
        ),
      ),
    );
  }
}
