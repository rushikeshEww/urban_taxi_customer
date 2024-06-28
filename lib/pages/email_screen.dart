import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/pages/sign_up_screen.dart';
import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../common/widget/common_text.dart';
import '../common/widget/common_text_field.dart';
import '../controllers/email_controller.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({super.key});

  final EmailController emailController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () { Get.back(); },
                                icon: SvgPicture.asset("assets/images/ic_back.svg", width: 18, height: 15,)
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: const CommonText(
                                StringConstants.skip,
                                color: ColorConstants.primaryGreen,
                                fontWeight: FontWeight.w500,),
                            )
                          ],
                        ),
                        const SizedBox(height: 56,),
                        const CommonText(StringConstants.enterYourEmailId, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),
                        const CommonText(
                          StringConstants.enterYourEmailIdSubTitle,
                          color: ColorConstants.grey,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30,),
                        CommonTextField(
                          controller: emailController.emailTextController,
                          labelText: StringConstants.emailId,
                          allBorderNull: true,
                          showClose: emailController.showClose,
                          focusNode: emailController.emailFocusNode,
                          suffixIcon: SvgPicture.asset("assets/images/ic_close_field.svg",
                            // colorFilter: const ColorFilter.mode(ColorConstants.grey, BlendMode.srcIn),
                          ),
                          onTapIcon: () {
                            emailController.emailTextController.text = "";
                            FocusScope.of(context).unfocus();
                          },
                          onChanged: (value) {
                            emailController.emailTextController.text = value;
                          },
                          suffixPadding: const EdgeInsets.only(left: 8, right: 22.0),
                        )
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {
                    if (emailController.emailTextController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.emailIdEmpty, message: StringConstants.emailIdEmptyMsg);
                      return;
                    }
                    Get.to(SignUpScreen());
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
            visible: emailController.loading.value,
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
