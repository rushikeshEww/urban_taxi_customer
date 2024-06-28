import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/color_constants.dart';
import '../common/snackbar_util.dart';
import '../common/string_constants.dart';
import '../models/common_response.dart';
import '../models/login_response.dart';
import '../network/abstract_service.dart';

class SignUpController extends GetxController {
  RxBool loading = false.obs;
  bool showEmailClose = true;
  RxBool conditionChecked = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool confirmPasswordVisible = false.obs;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  final loginResponse = Rxn<LoginResponse>();

  void passwordVisibilityChange(bool isConfirm) {
    if (isConfirm) {
      if (confirmPasswordVisible.isTrue) {
        confirmPasswordVisible.value = false;
      } else {
        confirmPasswordVisible.value = true;
      }
    } else {
      if (passwordVisible.isTrue) {
        passwordVisible.value = false;
      } else {
        passwordVisible.value = true;
      }
    }
  }

  Future<bool> registerUser(String phone, String email, String name, String password) async {
    loading.value = true;
    AbstractService abstractService = Get.find();
    CommonResponse response = await abstractService.registerUser(phone, email, name, password);
    print("Response :: ${response.status}");
    var box = GetStorage(StringConstants.storageName);
    loading.value = false;

    if (response.status) {

      loginResponse.value = loginResponseFromJson(jsonEncode(response.data['data']));
      Map<String, dynamic> loginResponseObject = jsonDecode(loginResponseToJson(loginResponse.value ?? LoginResponse()));
      box.write(StringConstants.userLoginData, loginResponseObject);
      box.write(StringConstants.bearerToken, response.bearerToken);
      SnackbarUtil.show(title: "Register", message: "Register Success", backgroundColor: ColorConstants.primaryGreen, icon: const Icon(Icons.check_circle, color: ColorConstants.white,));
      return true;

    }
    else {
      SnackbarUtil.show(title: "Error", message: response.message, backgroundColor: Colors.red);
      return false;
    }
  }
}