import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? hintColor;
  final Color? iconColor;
  // Add other custom colors as needed

  CustomColors({
    this.buttonColor,
    this.buttonTextColor,
    this.primaryColor,
    this.backgroundColor,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.hintColor,
    this.iconColor,
  });

  @override
  CustomColors copyWith({
    Color? buttonColor,
    Color? buttonTextColor,
    Color? primaryColor,
    Color? backgroundColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? hintColor,
    Color? iconColor,
  }) {
    return CustomColors(
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
      primaryColor: buttonColor ?? this.primaryColor,
      backgroundColor: buttonColor ?? this.backgroundColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      hintColor: hintColor ?? this.hintColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
      secondaryTextColor:
      Color.lerp(secondaryTextColor, other.secondaryTextColor, t),
      hintColor: Color.lerp(hintColor, other.hintColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
    );
  }

  // Optional:  Provide a default instance for use with Theme.of
  // static const light = CustomColors(
  //   buttonColor: Colors.blue,
  //   primaryTextColor: Colors.black,
  //   secondaryTextColor: Colors.grey,
  //   hintColor: Colors.grey,
  // );
  // static const dark = CustomColors(
  //   buttonColor: Colors.indigo,
  //   primaryTextColor: Colors.white,
  //   secondaryTextColor: Colors.grey,
  //   hintColor: Colors.grey,
  // );

}