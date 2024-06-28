import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';

class FilledRoundedPinPut extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onCompleted;
  final double width;
  final double height;

  const FilledRoundedPinPut({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
    required this.width,
    required this.height,
  });

  @override
  FilledRoundedPinPutState createState() => FilledRoundedPinPutState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class FilledRoundedPinPutState extends State<FilledRoundedPinPut> {

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    double separateSize = (Get.width - (4 * widget.width))/3;
    const length = 4;
    final defaultPinTheme = PinTheme(
      width: widget.width,
      height: widget.height,
      textStyle: const TextStyle(
        fontSize: 22,
        color: ColorConstants.black,
        fontWeight: FontWeight.w600
      ),
      decoration: BoxDecoration(
        color: ColorConstants.greyLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: widget.height + 8,
      width: Get.width,
      child: Pinput(
        length: length,
        controller: widget.controller,
        focusNode: widget.focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: (pin) {
          widget.onCompleted?.call(pin);
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: Colors.transparent,
            border: Border.all(color: ColorConstants.primaryGreen),
          ),
        ),
        separatorBuilder: (index) => SizedBox(width: separateSize),
      ),
    );
  }
}
