import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../common/color_constants.dart';
import '../common/string_constants.dart';
import '../common/widget/common_text.dart';

class LinkSentScreen extends StatelessWidget {
  const LinkSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
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
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/ic_green_check.svg", width: 68, height: 68,),
                  SizedBox(height: 20, width: Get.width,),
                  const CommonText(StringConstants.linkSent, fontSize: 26,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  const CommonText(
                    StringConstants.linkSentSubTitle, color: ColorConstants.grey, textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 30,),
                ],
              )
          ),
          GestureDetector(
            onTap: () {
              Get.back();
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
    );
  }
}
