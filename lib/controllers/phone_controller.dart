import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController {
  RxBool loading = false.obs;
  bool showPhoneClose = true;
  final FocusNode phoneFocusNode = FocusNode();
  TextEditingController phoneTextController = TextEditingController();
}