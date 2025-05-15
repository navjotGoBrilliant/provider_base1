import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '/common/routes/routes.dart';
import 'package:provider_base1/common/custom_colors.dart';
import '../provider/auth_provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  String? _selectedCountryCode = '+91'; // Default to India, you might want a picker
  final List<String> _countryCodes = ['+1', '+44', '+86', '+91']; // Example codes

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        automaticallyImplyLeading: false,
        elevation: 0,
        // Remove shadow for a cleaner look
        backgroundColor: customColors.backgroundColor,
        // Match WhatsApp's background
        titleTextStyle: TextStyle(color: customColors.primaryTextColor, fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      backgroundColor: customColors.backgroundColor, // WhatsApp-like background
      body: SingleChildScrollView(
        // Added for potential overflow on smaller screens
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: <Widget>[
              const SizedBox(height: 40),
              Center(
                child: Hero(
                  tag: 'flutter_logo_hero',
                  child: Icon(
                    Icons.message, // WhatsApp-like icon
                    size: 80,
                    color: customColors.iconColor, // WhatsApp's primary color
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text('Enter your phone number to continue.', style: TextStyle(fontSize: 16.0, color: customColors.primaryTextColor)),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: customColors.hintColor!))),
                      child: DropdownButton<String>(
                        value: _selectedCountryCode,
                        items:
                            _countryCodes.map((code) {
                              return DropdownMenuItem<String>(value: code, child: Text(code));
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCountryCode = newValue;
                          });
                        },
                        underline: SizedBox.shrink(),
                        // Remove the default underline
                        style: TextStyle(fontSize: 16.0, color: customColors.primaryTextColor),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Phone number',
                          border: UnderlineInputBorder(borderSide: BorderSide(color: customColors.hintColor!)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: customColors.buttonColor!), // WhatsApp's focus color
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length != 10) {
                            return 'Phone number must be 10 digits';
                          }
                          return null;
                        },
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),


              Hero(
                tag: 'hero_button_here', // Use the same tag for continuity (optional)
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                     // final fullPhoneNumber = '$_selectedCountryCode${_phoneNumberController.text}';
                      final fullPhoneNumber = _phoneNumberController.text;
                      await authProvider.sendOTP(fullPhoneNumber, context);
                      if (authProvider.errorMessage.isEmpty) {
                        context.go(Routes.otpScreen);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColors.buttonColor, // WhatsApp's primary button color
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    elevation: 0, // Cleaner look
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: customColors.buttonTextColor), // White text on primary color
                    ),
                  ),
                ),
              ),
              if (authProvider.isLoading) ...[
                const SizedBox(height: 20),
                Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(customColors.buttonColor!))), // WhatsApp color
              ],
              if (authProvider.errorMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(authProvider.errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              ],
              const SizedBox(height: 24),
              Text(
                'By continuing, you agree to our Terms of Service and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0, color: customColors.secondaryTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
