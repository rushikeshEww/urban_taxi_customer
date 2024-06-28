import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';
import 'package:urban_taxi_customer/common/snackbar_util.dart';
import 'package:urban_taxi_customer/common/string_constants.dart';
import 'package:urban_taxi_customer/common/widget/common_text.dart';
import 'package:urban_taxi_customer/common/widget/common_text_field.dart';
import 'package:urban_taxi_customer/controllers/login_controller.dart';
import 'package:urban_taxi_customer/pages/forgot_password_screen.dart';
import 'package:urban_taxi_customer/pages/phone_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var f = FocusScope.of(context);

        if (!f.hasPrimaryFocus) {
          f.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildUI(context),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 76,),
                        const CommonText(
                          StringConstants.welcomeBack, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),
                        const CommonText(
                          StringConstants.loginSubTitle,
                          color: ColorConstants.grey,),
                        const SizedBox(height: 30,),
                        _formUI(context),
                        const SizedBox(height: 10,),
                        Align(alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              child: const CommonText(
                                StringConstants.forgotPassword,
                                color: ColorConstants.primaryGreen,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                        ),
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {
                    if (loginController.emailController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.emailOrMobileEmpty, message: StringConstants.emailOrMobileEmptyMsg);
                      return;
                    }
                    if (loginController.passwordController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.passwordEmpty, message: StringConstants.passwordEmptyMsg);
                      return;
                    }
                    SnackbarUtil.show(title: StringConstants.login, message: "Login Success", backgroundColor: ColorConstants.primaryGreen, icon: const Icon(Icons.check_circle, color: ColorConstants.white,));
                  },
                  child: Container(
                      height: 55,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: ColorConstants.primaryGreen
                      ),
                      child: const Center(child: CommonText(
                        StringConstants.login, color: ColorConstants.white,
                        fontWeight: FontWeight.w700,))
                  ),
                ),
                const SizedBox(height: 35,),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "${StringConstants.get} ",
                          style: TextStyle(color: ColorConstants.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: StringConstants.registered,
                          style: const TextStyle(color: ColorConstants.primaryGreen,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Get.to(PhoneScreen());
                          }
                        ),
                      ],

                    ),

                  ),
                ),
                const SizedBox(height: 30,)
              ],
            ),
          ),
          Visibility(
            visible: loginController.loading.value,
            child: const Positioned(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: ColorConstants.primaryGreen,
                ),
              )
            ),
          )
        ],
      );
    });
  }

  Widget _formUI(BuildContext context) {
    return Column(
      children: [
        CommonTextField(
          controller: loginController.emailController,
          labelText: StringConstants.emailOrMobile,
          allBorderNull: true,
          showClose: loginController.showEmailClose,
          focusNode: loginController.emailFocusNode,
          suffixIcon: SvgPicture.asset("assets/images/ic_close_field.svg",),
          onTapIcon: () {
            loginController.emailController.text = "";
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            loginController.emailController.text = value;
          },
          suffixPadding: const EdgeInsets.only(left: 8, right: 22.0),
        ),
        const SizedBox(height: 15,),
        CommonTextField(
          controller: loginController.passwordController,
          labelText: StringConstants.password,
          allBorderNull: true,
          focusNode: loginController.passwordFocusNode,
          onTapIcon: () {
            loginController.passwordVisibilityChange();
          },
          obscureText: !loginController.passwordVisible.value,
          suffixIcon: !loginController.passwordVisible.value
            ? SvgPicture.asset("assets/images/ic_eye.svg",
            colorFilter: const ColorFilter.mode(
                ColorConstants.grey, BlendMode.srcIn))
            : SvgPicture.asset(
            "assets/images/ic_eye_slash.svg",
            colorFilter: const ColorFilter.mode(
                ColorConstants.grey, BlendMode.srcIn)),
        ),
      ],
    );

  }
}
