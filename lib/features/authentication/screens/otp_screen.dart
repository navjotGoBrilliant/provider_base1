import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common/custom_colors.dart';
import 'package:provider_base1/common/routes/routes.dart';
import '../provider/auth_provider.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        elevation: 0,
        backgroundColor: customColors.backgroundColor,
        titleTextStyle: TextStyle(color: customColors.primaryTextColor, fontSize: 18.0, fontWeight: FontWeight.w500),
        iconTheme: IconThemeData(color: customColors.primaryTextColor), // Style back button if needed
      ),
      backgroundColor: customColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 40),
               Center(
                child: Hero(
                  tag: 'flutter_logo_hero', // Use the same tag for continuity (optional)
                  child: Icon(
                    Icons.message,
                    size: 80,
                    color: customColors.iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Enter the 6-digit OTP sent to',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: customColors.primaryTextColor),
              ),
              const SizedBox(height: 8),
              Text(
                authProvider.phoneNumber,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: customColors.primaryTextColor),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: customColors.primaryTextColor),
                  decoration: InputDecoration(
                    labelText: 'Verification Code',
                    labelStyle: TextStyle(color: customColors.hintColor),
                    border: UnderlineInputBorder(borderSide: BorderSide(color: customColors.hintColor!)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: customColors.buttonColor!)),
                    counterText: '', // Hide the default maxLength counter
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP';
                    }
                    if (value.length != 6) {
                      return 'OTP must be 6 digits';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),

              Hero(
                tag: 'hero_button_here', // Use the same tag for continuity (optional)
                child:  ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authProvider.verifyOTP(_otpController.text, context);
                      if (authProvider.isAuthenticated) {
                        context.go(Routes.responsiveScreen);
                        authProvider.resetAuth();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColors.buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: customColors.buttonTextColor),
                    ),
                  ),
                ),
              ),
              if (authProvider.isLoading) ...[
                const SizedBox(height: 20),
                Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(customColors.buttonColor!))),
              ],
              if (authProvider.errorMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  authProvider.errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(fontSize: 14, color: customColors.secondaryTextColor),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement resend OTP functionality
                      print('Resend OTP pressed');
                      // You might want to call a function in your AuthProvider
                      // to resend the OTP.
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: customColors.buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}