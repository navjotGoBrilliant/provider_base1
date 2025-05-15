import 'package:flutter/material.dart';

class ColorConstants {
  static const kPrimaryColor = Color(0xFF19513C);
  static const kPrimaryDarkColor = Color(0xFF19513C);
  static const kPrimaryLightColor = Color(0xFF44A97D);
  static const kSecondaryColor = Colors.white;
  static const kWhiteColor = Colors.white;
  static const kButtonColor = Color(0xFF19513C);
  static const kBlueColor = Color(0xFF8FD3FD);
  static const kHintColor = Color(0xFF777777);
  static const kGreyDarkColor = Color(0xFF111112);
  static const kTextColor = Color(0xFF1C1F1E);
  static const kGreyColor = Color(0xFF909090);
  static const kDisabledColor = Color(0xFFA2A2A2);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
