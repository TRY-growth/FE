import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();
  bool isLogin = true;

  Future<void> attemptLogin(BuildContext context) async {
    final String baseUrl = dotenv.env['BASE_URL']!;
    var url = Uri.parse('$baseUrl/user/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text
        }));

    if (response.statusCode == 200 && response.body == "로그인 성공") {
      if (context.mounted) {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login failed: Incorrect email or password'),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Future<void> attemptSignup(BuildContext context) async {
    if (!isValidEmail(emailController.text) ||
        passwordController.text.length < 6 ||
        passwordController.text != confirmPasswordController.text ||
        nicknameController.text.isEmpty) {
      showSignupError(context);
      return;
    }

    final String baseUrl = dotenv.env['BASE_URL']!;
    var url = Uri.parse('$baseUrl/user/join');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
          'passwordConfirm': confirmPasswordController.text,
          'nickname': nicknameController.text
        }));

    if (response.statusCode == 200 && response.body == "회원가입이 완료되었습니다.") {
      clearControllers();
      isLogin = true;
      notifyListeners();
      if (context.mounted) {
        Navigator.popAndPushNamed(context, '/');
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Signup failed: ${response.body}'),
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }

  void showSignupError(BuildContext context) {
    String errorMessage = 'Please check the following:';
    if (nicknameController.text.isEmpty) {
      errorMessage += '\n- Name cannot be empty.';
    }
    if (!isValidEmail(emailController.text)) {
      errorMessage += '\n- Email format is invalid.';
    }
    if (passwordController.text.length < 6) {
      errorMessage += '\n- Password must be at least 6 characters.';
    }
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage += '\n- Passwords do not match.';
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 5),
      ));
    }
  }

  bool isValidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nicknameController.clear();
  }

  void toggleLoginSignup() {
    clearControllers();
    isLogin = !isLogin;
    notifyListeners();
  }
}
