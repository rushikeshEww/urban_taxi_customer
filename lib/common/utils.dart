import 'package:get/get.dart';
import 'package:urban_taxi_customer/controllers/email_controller.dart';
import 'package:urban_taxi_customer/controllers/forgot_password_controller.dart';
import 'package:urban_taxi_customer/controllers/login_controller.dart';
import 'package:urban_taxi_customer/controllers/otp_controller.dart';
import 'package:urban_taxi_customer/controllers/phone_controller.dart';
import 'package:urban_taxi_customer/controllers/sign_up_controller.dart';
import 'package:urban_taxi_customer/network/abstract_service.dart';
import 'package:urban_taxi_customer/network/api.dart';
import 'package:urban_taxi_customer/network/http_service.dart';

// Future<void> registerControllers() async {
//   Get.put(LoginController());
//   Get.put(ForgotPasswordController());
//   Get.put(PhoneController());
//   Get.put(OTPController());
//   Get.put(EmailController());
//   Get.put(SignUpController());
// }

Future<void> registerServices() async {
  Get.put(Api());
  Get.lazyPut<AbstractService>(() => HTTPService(), fenix: true);
}

/// check if the string contains only numbers
bool isNumeric(String str) {
  RegExp numeric = RegExp(r'^-?[0-9]+$');
  return numeric.hasMatch(str);
}
