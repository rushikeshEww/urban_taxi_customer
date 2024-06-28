import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/controllers/phone_controller.dart';
import 'package:urban_taxi_customer/pages/otp_screen.dart';
import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../common/widget/common_text.dart';
import '../common/widget/common_text_field.dart';

class PhoneScreen extends StatelessWidget {
  PhoneScreen({super.key});

  final PhoneController phoneController = Get.find();

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
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () { Get.back(); },
                            icon: SvgPicture.asset("assets/images/ic_back.svg", width: 18, height: 15,)
                        ),
                        const SizedBox(height: 56,),
                        const CommonText(StringConstants.enterYourNumber, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),
                        const CommonText(
                          StringConstants.enterYourNumberSubTitle, color: ColorConstants.grey,),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 58,
                              width: 90,
                              decoration: BoxDecoration(
                                color: ColorConstants.greyLight,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/images/ic_flag.svg", width: 18, height: 18,),
                                    const SizedBox(width: 10,),
                                    const CommonText("+1", fontWeight: FontWeight.w700, )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: CommonTextField(
                                keyboardType: TextInputType.number,
                                outerContainerHeight: 58,
                                controller: phoneController.phoneTextController,
                                labelText: StringConstants.mobileNumber,
                                allBorderNull: true,
                                showClose: phoneController.showPhoneClose,
                                focusNode: phoneController.phoneFocusNode,
                                suffixIcon: SvgPicture.asset("assets/images/ic_close_field.svg",),
                                onTapIcon: () {
                                  phoneController.phoneTextController.text = "";
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (value) {
                                  phoneController.phoneTextController.text = value;
                                },
                                suffixPadding: const EdgeInsets.only(left: 8, right: 22.0),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
                GestureDetector(
                  onTap: () {
                    if (phoneController.phoneTextController.text.trim().isEmpty) {
                      SnackbarUtil.show(title: StringConstants.mobileNumberEmpty, message: StringConstants.mobileNumberEmptyMsg);
                      return;
                    }
                    Get.to(OTPScreen());
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
            visible: phoneController.loading.value,
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
