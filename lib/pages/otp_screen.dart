
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:urban_taxi_customer/common/widget/pin_put.dart';
import 'package:urban_taxi_customer/controllers/otp_controller.dart';
import 'package:urban_taxi_customer/pages/email_screen.dart';
import '../common/color_constants.dart';
import '../common/string_constants.dart';
import '../common/widget/common_text.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key});

  final OTPController otpController = OTPController();
  String phone = "";

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> arguments = Get.arguments;
    phone = arguments['phone'] ?? "";

    startInitialTimer();

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
                            onPressed: () { Get.back(); },
                            icon: SvgPicture.asset("assets/images/ic_back.svg", width: 18, height: 15,)
                        ),
                        const SizedBox(height: 56,),
                        const CommonText(StringConstants.enterTheCode, fontSize: 26,
                          fontWeight: FontWeight.w700,),
                        const SizedBox(height: 25,),


                        // const CommonText(
                        //   "${StringConstants.codeHasSentTo} +1 234 314 9878", color: ColorConstants.grey,),

                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "${StringConstants.codeHasSentTo} ",
                                style: TextStyle(color: ColorConstants.grey,
                                    fontSize: 16,),
                              ),
                              TextSpan(
                                  text: phone.isEmpty ? "your phone" : "+1 $phone",
                                  style: const TextStyle(color: ColorConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30,),


                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Expanded(
                        //       child: CommonTextField(
                        //         outerContainerHeight: 60,
                        //         keyboardType: TextInputType.number,
                        //         controller: otpController.firstController,
                        //         allBorderNull: true,
                        //         focusNode: otpController.firstFocusNode,
                        //         onChanged: (value) {
                        //           otpController.firstController.text = value;
                        //         },
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15,),
                        //     Expanded(
                        //       child: CommonTextField(
                        //         outerContainerHeight: 60,
                        //         keyboardType: TextInputType.number,
                        //         controller: otpController.secondController,
                        //         allBorderNull: true,
                        //         focusNode: otpController.secondFocusNode,
                        //         onChanged: (value) {
                        //           otpController.secondController.text = value;
                        //         },
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15,),
                        //     Expanded(
                        //       child: CommonTextField(
                        //         outerContainerHeight: 60,
                        //         keyboardType: TextInputType.number,
                        //         controller: otpController.thirdController,
                        //         allBorderNull: true,
                        //         focusNode: otpController.thirdFocusNode,
                        //         onChanged: (value) {
                        //           otpController.thirdController.text = value;
                        //         },
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15,),
                        //     Expanded(
                        //       child: CommonTextField(
                        //         outerContainerHeight: 60,
                        //         keyboardType: TextInputType.number,
                        //         controller: otpController.fourthController,
                        //         allBorderNull: true,
                        //         focusNode: otpController.fourthFocusNode,
                        //         onChanged: (value) {
                        //           otpController.fourthController.text = value;
                        //         },
                        //       ),
                        //     )
                        //   ],
                        // )

                        FilledRoundedPinPut(
                          controller: otpController.firstController, 
                          focusNode: otpController.firstFocusNode,
                          onCompleted: (pin) async {
                            print(pin);

                            var success = await otpController.verifyOTP(phone, pin);

                            if (success) {
                              Get.off(() => EmailScreen(),
                                arguments: {
                                  "phone" : phone,
                                }
                              );
                            }

                            /// to test
                            // if (pin == "1212") {
                            //   Get.to(() => EmailScreen());
                            //   otpController.stopTimer();
                            //   return;
                            // }
                            // SnackbarUtil.show(title: StringConstants.otpWrong, message: StringConstants.otpWrongMsg);
                          },
                          width: 80,
                          height: 60,
                        ),
                        const SizedBox(height: 20,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: otpController.isTimerOn.isTrue ? "${StringConstants.resendCodeIn} " : null,
                                style: const TextStyle(color: ColorConstants.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                  text: otpController.isTimerOn.isTrue ? "${otpController.seconds.value} sec" : StringConstants.resendCode,
                                  style: TextStyle(color: ColorConstants.primaryGreen,
                                      fontSize: 16,
                                      fontWeight: otpController.isTimerOn.isTrue ? FontWeight.w700 : FontWeight.w500),
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    var success = await otpController.sendOTP(phone);
                                    if (success) {
                                      if (otpController.isTimerOn.isFalse) {
                                        otpController.startTimer();
                                      }
                                    }
                                  }
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                // GestureDetector(
                //   onTap: () {
                //     // if (phoneController.phoneTextController.text.trim().isEmpty) {
                //     //   SnackbarUtil.show(title: StringConstants.mobileNumberEmpty, message: StringConstants.mobileNumberEmptyMsg);
                //     //   return;
                //     // }
                //
                //   },
                //   child: Container(
                //       height: 55,
                //       width: Get.width,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(32),
                //           color: ColorConstants.primaryGreen
                //       ),
                //       child: const Center(child: CommonText(
                //         StringConstants.strContinue, color: ColorConstants.white,
                //         fontWeight: FontWeight.w700,))
                //   ),
                // ),
                const SizedBox(height: 40,)
              ],
            ),
          ),
          Visibility(
            visible: otpController.loading.value,
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

  void startInitialTimer() {
    if (otpController.firstTime) {
      otpController.stopTimer();
      otpController.startTimer();
    }
  }
}
