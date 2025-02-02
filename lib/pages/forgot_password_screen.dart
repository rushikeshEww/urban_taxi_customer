import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/controllers/forgot_password_controller.dart';
import 'package:urban_taxi_customer/pages/link_sent_screen.dart';
import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../common/utils.dart';
import '../common/widget/common_text.dart';
import '../common/widget/common_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  // final ForgotPasswordController forgotPasswordController = Get.find();
  final ForgotPasswordController forgotPasswordController = ForgotPasswordController();

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
                        const SizedBox(height: 20,),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                                // forgotPasswordController.emptyData();
                                Get.back();
                              },
                            icon: SvgPicture.asset("assets/images/ic_back.svg", width: 18, height: 15,)
                        ),
                        const SizedBox(height: 56,),
                        const CommonText(StringConstants.forgotPassword, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),
                        const CommonText(
                          StringConstants.forgotPasswordSubTitle, color: ColorConstants.grey,),
                        const SizedBox(height: 30,),
                        CommonTextField(
                          textInputAction: TextInputAction.done,
                          controller: forgotPasswordController.emailController,
                          labelText: StringConstants.emailOrMobile,
                          allBorderNull: true,
                          focusNode: forgotPasswordController.emailFocusNode,
                          showClose: forgotPasswordController.showEmailClose,
                          suffixIcon: SvgPicture.asset("assets/images/ic_close_field.svg",),
                          onTapIcon: () {
                            forgotPasswordController.emailController.text = "";
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            forgotPasswordController.emailController.text = value;
                          },
                          suffixPadding: const EdgeInsets.only(left: 8, right: 22.0),
                          maxLength: 30,
                          counterText: "",
                        ),
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () async {
                    String emailPhoneText = forgotPasswordController.emailController.text.trim();
                    bool isNumericOnly = isNumeric(emailPhoneText);

                    if (emailPhoneText.isEmpty) {
                      SnackbarUtil.show(title: StringConstants.emailOrMobileEmpty, message: StringConstants.emailOrMobileEmptyMsg);
                      return;
                    }
                    if (isNumericOnly && emailPhoneText.length < 10) {
                      SnackbarUtil.show(title: StringConstants.mobileNumberInvalid, message: StringConstants.mobileNumberInvalidMsg);
                      return;
                    }
                    if (!isNumericOnly && !RegExp(StringConstants.emailPattern).hasMatch(emailPhoneText)){
                      SnackbarUtil.show(title: StringConstants.emailIdInvalid, message: StringConstants.emailIdInvalidMsg);
                      return;
                    }

                    var success = await forgotPasswordController.getForgotPassword(emailPhoneText);
                    if (success) {
                      Get.off(() => const LinkSentScreen());
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
                        StringConstants.submit, color: ColorConstants.white,
                        fontWeight: FontWeight.w700,))
                  ),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ),
          Visibility(
            visible: forgotPasswordController.loading.value,
            child: const Positioned(
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: ColorConstants.primaryGreen,
                    ),
                  ),
                )
            ),
          )
        ],
      );
    });
  }
}
