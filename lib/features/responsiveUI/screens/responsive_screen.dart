import 'package:flutter/material.dart';
import '../../../common/responsive_layout.dart';
import '../../shopping/screens/shop/shop_screen_desktop.dart';
import '../../shopping/screens/shop/shop_screen.dart';
import 'desktop_body.dart';
import 'mobile_body.dart';

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({super.key});

  @override
  _ResponsiveScreenState createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(),
        desktopBody: MyDesktopBody(),
      ),
    );
  }
}