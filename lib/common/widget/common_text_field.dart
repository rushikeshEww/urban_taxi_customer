import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_constants.dart';

class CommonTextField extends StatefulWidget {

  final TextStyle? style;
  final Color? cursorColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTapIcon;
  final Function(String)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? floatingLabelStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final String? counterText;
  final int? maxLength;
  final bool obscureText;
  final bool allowEmptyCheck;
  final int? minValue;
  final String? validationRegex;
  final String? emptyErrorMsg;
  final String? minValueErrorMsg;
  final String? validationRegexErrorMsg;
  final FocusNode? focusNode;
  final Border? border;
  final bool allBorderNull;
  final String? iconPath;
  final bool showClose;
  final double? outerContainerHeight;
  final double? outerContainerWidth;
  final EdgeInsetsGeometry? suffixPadding;

  const CommonTextField({
    super.key,
    this.suffixPadding,
    this.iconPath,
    this.allBorderNull = false,
    this.showClose = false,
    this.border,
    this.labelText,
    this.style,
    this.cursorColor,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters = const [],
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.floatingLabelStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.counterText, this.maxLength,
    this.obscureText = false,
    this.onTapIcon,
    this.emptyErrorMsg,
    this.minValue,
    this.minValueErrorMsg,
    this.validationRegex,
    this.validationRegexErrorMsg,
    this.allowEmptyCheck = false,
    this.focusNode,
    this.outerContainerHeight,
    this.outerContainerWidth,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();

}

class _CommonTextFieldState extends State<CommonTextField> {

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode?.addListener(() {
        setState(() {
          print(widget.showClose);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.outerContainerHeight,
      width: widget.outerContainerWidth,
      decoration: widget.focusNode != null ? BoxDecoration(
          color: widget.focusNode!.hasFocus ? Colors.transparent : ColorConstants.greyLight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.focusNode!.hasFocus ? ColorConstants.primaryGreen : ColorConstants.greyLight,
          )
      ) : null,
      child: TextFormField(
        focusNode: widget.focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        style: widget.style ?? const TextStyle(
          color: ColorConstants.black,
          fontWeight: FontWeight.w600,
          fontSize: 16
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: widget.counterText,
          suffixIcon:  widget.suffixIcon == null && !widget.showClose
            ? null
            : GestureDetector(
              onTap: () {
                widget.onTapIcon?.call();
              },
              child: Padding(
                padding: widget.suffixPadding ?? const EdgeInsets.only(left: 5, right: 18.0),
                child: widget.showClose
                ? widget.focusNode != null
                    ? widget.focusNode!.hasFocus
                        ? widget.suffixIcon
                        : null
                    : null
                : widget.suffixIcon,
                // child: widget.suffixIcon,
              ),
            ),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: ColorConstants.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
          floatingLabelStyle: const TextStyle(
            color: ColorConstants.grey,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.transparent,
          // fillColor: MaterialStateColor.resolveWith((states) {
          //   if (states.contains(MaterialState.focused) && states.contains(MaterialState.error)) {
          //     return ColorConstants.white; // Focused error
          //   } else if (states.contains(MaterialState.focused)) {
          //     return ColorConstants.white; // Focused
          //   } else if (states.contains(MaterialState.error)) {
          //     return ColorConstants.white; // Error
          //   } else {
          //     return ColorConstants.greyLight; // Enabled
          //   }
          // }),
          enabledBorder: widget.allBorderNull ? InputBorder.none : const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.greyLight,
              strokeAlign: BorderSide.strokeAlignOutside
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          focusedBorder: widget.allBorderNull ? InputBorder.none : const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.primaryGreen,
              strokeAlign: BorderSide.strokeAlignOutside
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          errorBorder: widget.allBorderNull ? InputBorder.none : const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              strokeAlign: BorderSide.strokeAlignOutside
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
          focusedErrorBorder: widget.allBorderNull ? InputBorder.none : const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              strokeAlign: BorderSide.strokeAlignOutside
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))
          ),
        ),
        cursorColor:  widget.cursorColor ?? ColorConstants.primaryGreen,
        controller: widget.controller,
        onChanged: (value) {
          widget.onChanged?.call(value);
        },
        validator: (text) {
          if ((text == null || text.trim().isEmpty) && widget.allowEmptyCheck) {
            return widget.emptyErrorMsg ?? "Invalid input";
          } else if (text != null && widget.minValue != null && text.trim().length < widget.minValue!) {
            return widget.minValueErrorMsg ?? "Invalid value";
          } else if (text != null && widget.validationRegex != null) {
            if (!RegExp(widget.validationRegex!).hasMatch(text.trim())){
              return widget.validationRegexErrorMsg ?? "Invalid Validation";
            }
          }
        },
        inputFormatters: widget.inputFormatters.isEmpty ? null : widget.inputFormatters,
        maxLength: widget.maxLength,
        obscureText: widget.obscureText,
      ),
    );
  }
}
