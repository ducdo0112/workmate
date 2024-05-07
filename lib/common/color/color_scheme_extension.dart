import 'package:flutter/material.dart';

extension ColorSchemeExtension on ThemeData {
  bool isLightMode() => brightness == Brightness.light;

  Color get appBarColor =>
      isLightMode() ? const Color(0xFFffffff) : const Color(0xFF28a745);

  Color get loginBackgroundColor =>
      isLightMode() ? const Color(0xFF6495ed) : const Color(0xFFff7f50);

  Color get defaultTextColor =>
      isLightMode() ? const Color(0xFF000113) : const Color(0xFFCCCCCC);

  Color get defaultTextColorLostFocus =>
      isLightMode() ? const Color(0xFFCBD5E1) : const Color(0xFF64748B);

  Color get loginHeaderTitleColor =>
      isLightMode() ? const Color(0xFF1E293B) : const Color(0xFFFFFFFF);

  Color get black =>
      isLightMode() ? const Color(0xFF000000) : const Color(0xFFFFFFFF);

  Color get buttonBackground =>
      isLightMode() ? const Color(0xFF000113) : const Color(0xFF334155);

  Color get loginTextOther =>
      isLightMode() ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

  Color get loginBackgroundOther =>
      isLightMode() ? const Color(0xFFF1F5F9) : const Color(0xFF334155);

  Color get loginTextGoogle =>
      isLightMode() ? const Color(0xFF475569) : const Color(0xFF94A3B8);
}
