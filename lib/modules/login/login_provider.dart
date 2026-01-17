import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;




void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }
  void login(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage = "Please fill all fields";
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      if (email == "mobile@alisonsgroup.com" && password == "12345678") {
        isLoading = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        isLoading = false;
        errorMessage = "Invalid credentials";
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
