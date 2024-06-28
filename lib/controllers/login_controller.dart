import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urban_taxi_customer/models/common_response.dart';
import 'package:urban_taxi_customer/models/login_response.dart';

import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../network/abstract_service.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  RxBool passwordVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginResponse = Rxn<LoginResponse>();

  void passwordVisibilityChange() {
    if (passwordVisible.isTrue) {
      passwordVisible.value = false;
    } else {
      passwordVisible.value = true;
    }
  }

  Future<bool> getLogin(String emailPhone, String password) async {
    loading.value = true;
    AbstractService abstractService = Get.find();
    CommonResponse response = await abstractService.getLogin(emailPhone, password);
    print("Response :: ${response.status}");
    var box = GetStorage(StringConstants.storageName);
    loading.value = false;

    if (response.status) {

      loginResponse.value = loginResponseFromJson(jsonEncode(response.data['data']));
      Map<String, dynamic> loginResponseObject = jsonDecode(loginResponseToJson(loginResponse.value ?? LoginResponse()));
      box.write(StringConstants.userLoginData, loginResponseObject);
      box.write(StringConstants.bearerToken, response.bearerToken);
      SnackbarUtil.show(title: StringConstants.login, message: "Login Success", backgroundColor: ColorConstants.primaryGreen, icon: const Icon(Icons.check_circle, color: ColorConstants.white,));
      return true;

    }
    else {
      SnackbarUtil.show(title: "Error", message: response.message, backgroundColor: Colors.red);
      return false;
    }
  }
}