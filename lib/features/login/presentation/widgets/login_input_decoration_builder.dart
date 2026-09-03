
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LoginInputDecorationBuilder extends InputDecorationBuilder {

  @override
  InputDecoration build() {
    return InputDecoration(
      enabledBorder: enabledBorder ?? OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeUtils.primitiveBorderRadius),
        borderSide: const BorderSide(width: 1, color: AppColor.textFieldBorderColor)),
      focusedBorder:  focusBorder ?? OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeUtils.primitiveBorderRadius),
        borderSide: const BorderSide(width: 2, color: AppColor.textFieldFocusedBorderColor)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeUtils.primitiveBorderRadius),
        borderSide: const BorderSide(width: 1, color: AppColor.textFieldErrorBorderColor)),
      prefixText: prefixText,
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: labelStyle ?? ThemeUtils.defaultTextStyleInterFont.copyWith(color: AppColor.textFieldLabelColor, fontSize: 17),
      hintText: hintText,
      hintStyle: hintStyle ?? ThemeUtils.defaultTextStyleInterFont.copyWith(color: AppColor.textFieldHintColor, fontSize: 17),
      contentPadding: contentPadding ?? const EdgeInsetsDirectional.only(start: 25, top: 18, bottom: 18, end: 25),
      filled: true,
      fillColor: AppColor.textFieldBorderColor);
  }
}