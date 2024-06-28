import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urban_taxi_customer/common/color_constants.dart';

class CommonText extends StatelessWidget {

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CommonText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color ?? ColorConstants.black,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }

}