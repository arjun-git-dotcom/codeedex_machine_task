
import 'package:codeedex/services/api_service.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;

  LoginProvider({required this.apiService});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;
  String? errorMessage;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
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

    try {
      final response = await apiService.login(email, password);

      isLoading = false;
      notifyListeners();

     
      if (response['success'] == 1 || response['success'] == true) {
        
      
        final customerData = response['customerdata'] as Map<String, dynamic>?;
        
        if (customerData != null) {
          final id = customerData['id']?.toString();
          final token = customerData['token']?.toString();
          final name = customerData['name']?.toString();
          final email = customerData['email']?.toString();

          

          if (id != null && token != null) {
           
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                '/home',
                arguments: {
                  'id': id,
                  'token': token,
                  'name': name,
                  'email': email,
                },
              );
            }
          } else {
            errorMessage = "Login successful but missing credentials";
            notifyListeners();
          }
        } else {
          errorMessage = "Invalid response format";
          notifyListeners();
        }
      } else {
        errorMessage = response['message']?.toString() ?? 'Invalid credentials';
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      errorMessage = "Login failed: ${e.toString()}";
      notifyListeners();
      
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}