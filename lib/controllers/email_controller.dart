import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  RxBool loading = false.obs;
  bool showClose = true;
  final FocusNode emailFocusNode = FocusNode();
  TextEditingController emailTextController = TextEditingController();
}