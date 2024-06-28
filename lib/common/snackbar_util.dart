import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';

class SnackbarUtil {

  static void show({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    Widget icon = const Icon(Icons.info, color: ColorConstants.white,),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: duration,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon,
    );
  }

  // static void showSnackBar({
  //   required String message,
  //   required String title,
  //   Color? backgroundColor
  // }) {
  //   show(
  //     title: title,
  //     message: message,
  //     backgroundColor: backgroundColor ?? Colors.green,
  //   );
  // }
}
