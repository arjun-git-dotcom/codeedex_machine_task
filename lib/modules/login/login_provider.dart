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

  
      if (response['success'] == 1) {
        final id = response['id'];
        final token = response['token'];

        if (id != null && token != null) {
      
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {'id': id, 'token': token},
          );
        } else {
          errorMessage = "Login successful but missing credentials";
          notifyListeners();
        }
      } else {
       
        errorMessage = response['message'] ?? 'Invalid credentials';
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
