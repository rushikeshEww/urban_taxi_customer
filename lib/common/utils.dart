import 'package:get/get.dart';
import 'package:urban_taxi_customer/controllers/email_controller.dart';
import 'package:urban_taxi_customer/controllers/forgot_password_controller.dart';
import 'package:urban_taxi_customer/controllers/login_controller.dart';
import 'package:urban_taxi_customer/controllers/otp_controller.dart';
import 'package:urban_taxi_customer/controllers/phone_controller.dart';
import 'package:urban_taxi_customer/controllers/sign_up_controller.dart';

Future<void> registerControllers() async {
  Get.put(LoginController());
  Get.put(ForgotPasswordController());
  Get.put(PhoneController());
  Get.put(OTPController());
  Get.put(EmailController());
  Get.put(SignUpController());
}
