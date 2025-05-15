import 'package:flutter/material.dart';
import 'dart:async';

// Auth Provider (auth_provider.dart)
class AuthProvider with ChangeNotifier {
  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  String _otp = '';
  String get otp => _otp;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  // For simplicity, we'll simulate OTP sending and verification.
  // In a real app, you'd use a service like Firebase, Twilio, or a custom backend.
  Future<void> sendOTP(String phoneNumber, BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    _phoneNumber = phoneNumber; // Store for later use
    notifyListeners();

    // Simulate sending OTP (e.g., via SMS)
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    if (phoneNumber.length == 10) {
      // Simulate successful OTP sending
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to $phoneNumber')),
      );
    } else {
      _isLoading = false;
      _errorMessage = 'Invalid phone number. Please enter a 10-digit number.';
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
    }
  }

  Future<void> verifyOTP(String otp, BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    _otp = otp;
    notifyListeners();

    // Simulate OTP verification
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    if (otp == '123456') {
      // Simulate successful verification
      _isAuthenticated = true;
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      _errorMessage = 'Invalid OTP. Please try again.';
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage)),
      );
    }
  }

  void resetAuth() {
    _phoneNumber = '';
    _otp = '';
    _isLoading = false;
    _errorMessage = '';
    _isAuthenticated = false;
    notifyListeners();
  }
}