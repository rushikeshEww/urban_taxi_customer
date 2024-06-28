import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urban_taxi_customer/common/string_constants.dart';
import 'package:urban_taxi_customer/common/widget/common_text.dart';
import 'package:urban_taxi_customer/pages/login_screen.dart';

import '../common/color_constants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final storage = GetStorage(StringConstants.storageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CommonText(
                StringConstants.homeScreen,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  storage.remove(StringConstants.bearerToken);
                  storage.remove(StringConstants.userLoginData);
                  Get.offAll(() => LoginScreen());
                },
                child: Container(
                    height: 45,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: ColorConstants.primaryGreen
                    ),
                    child: const Center(child: CommonText(
                      StringConstants.logout, color: ColorConstants.white,
                      fontWeight: FontWeight.w700,))
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
