import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../common/widget/common_text.dart';
import '../common/widget/common_text_field.dart';
import '../controllers/email_controller.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(context),
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
                        const SizedBox(height: 20,),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () { Get.back(); },
                            icon: SvgPicture.asset("assets/images/ic_back.svg", width: 18, height: 15,)
                        ),
                        const SizedBox(height: 56,),
                        const CommonText(StringConstants.enterYourFullNameAndPassword, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),
                        const CommonText(
                          StringConstants.enterYourFullNameAndPasswordSubTitle,
                          color: ColorConstants.grey,
                        ),
                        const SizedBox(height: 30,),
                        CommonTextField(
                          controller: signUpController.nameTextController,
                          labelText: StringConstants.fullName,
                          allBorderNull: true,
                          showClose: signUpController.showEmailClose,
                          focusNode: signUpController.nameFocusNode,
                          suffixIcon: SvgPicture.asset("assets/images/ic_close_field.svg",),
                          onTapIcon: () {
                            signUpController.nameTextController.text = "";
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            signUpController.nameTextController.text = value;
                          },
                          suffixPadding: const EdgeInsets.only(left: 8, right: 22.0),
                        ),
                        const SizedBox(height: 15,),
                        CommonTextField(
                          controller: signUpController.passwordTextController,
                          labelText: StringConstants.password,
                          allBorderNull: true,
                          focusNode: signUpController.passwordFocusNode,
                          onTapIcon: () {
                            signUpController.passwordVisibilityChange(false);
                          },
                          obscureText: !signUpController.passwordVisible.value,
                          suffixIcon: !signUpController.passwordVisible.value
                            ? SvgPicture.asset("assets/images/ic_eye.svg",
                            colorFilter: const ColorFilter.mode(
                                ColorConstants.grey, BlendMode.srcIn))
                            : SvgPicture.asset(
                            "assets/images/ic_eye_slash.svg",
                            colorFilter: const ColorFilter.mode(
                                ColorConstants.grey, BlendMode.srcIn)),
                        ),
                        const SizedBox(height: 15,),
                        CommonTextField(
                          controller: signUpController.confirmPasswordTextController,
                          labelText: StringConstants.confirmPassword,
                          allBorderNull: true,
                          focusNode: signUpController.confirmPasswordFocusNode,
                          onTapIcon: () {
                            signUpController.passwordVisibilityChange(true);
                          },
                          obscureText: !signUpController.confirmPasswordVisible.value,
                          suffixIcon: !signUpController.confirmPasswordVisible.value
                            ? SvgPicture.asset("assets/images/ic_eye.svg",
                            colorFilter: const ColorFilter.mode(
                                ColorConstants.grey, BlendMode.srcIn))
                            : SvgPicture.asset(
                            "assets/images/ic_eye_slash.svg",
                            colorFilter: const ColorFilter.mode(
                                ColorConstants.grey, BlendMode.srcIn)),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            GestureDetector(
                              onTap: () {
                                signUpController.conditionChecked.toggle();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    color: ColorConstants.primaryGreen,
                                    width: 1.5,
                                  ),
                                  color: signUpController.conditionChecked.value ? ColorConstants.primaryGreen : Colors.transparent,
                                ),
                                width: 24.0,
                                height: 24.0,
                                child: signUpController.conditionChecked.value
                                  ?
                                  // const Icon(
                                  //   Icons.check_rounded,
                                  //   size: 22.0,
                                  //   color: Colors.white,
                                  // )
                                  SvgPicture.asset("assets/images/ic_thick_check.svg",
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(ColorConstants.white, BlendMode.srcIn),
                                  )
                                  : null,
                              ),
                            ),
                            const SizedBox(width: 12,),
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${StringConstants.acceptUrban} ",
                                    style: TextStyle(
                                      color: ColorConstants.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${StringConstants.terms} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.primaryGreen,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "& ",
                                    style: TextStyle(
                                      color: ColorConstants.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: StringConstants.conditions,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.primaryGreen,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {
                    if (signUpController.nameTextController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.fullNameEmpty, message: StringConstants.fullNameEmptyMsg);
                      return;
                    }
                    if (signUpController.passwordTextController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.passwordEmpty, message: StringConstants.passwordEmptyMsg);
                      return;
                    }
                    if (signUpController.confirmPasswordTextController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.confirmPasswordEmpty, message: StringConstants.confirmPasswordEmptyMsg);
                      return;
                    }
                  },
                  child: Container(
                      height: 55,
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: ColorConstants.primaryGreen
                      ),
                      child: const Center(child: CommonText(
                        StringConstants.strContinue, color: ColorConstants.white,
                        fontWeight: FontWeight.w700,))
                  ),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ),
          Visibility(
            visible: signUpController.loading.value,
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
}
