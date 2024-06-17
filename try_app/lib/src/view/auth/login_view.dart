import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/4.png', height: 150),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSwitchButton('Login', viewModel.isLogin, viewModel),
                  _buildSwitchButton('Sign-up', !viewModel.isLogin, viewModel),
                ],
              ),
            ),
            const SizedBox(height: 32),
            viewModel.isLogin
                ? _buildLogin(context, viewModel)
                : _buildSignup(context, viewModel),
            const SizedBox(height: 12),
            viewModel.isLogin
                ? _loginButton(context, viewModel)
                : _signupButton(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchButton(
      String title, bool isActive, LoginViewModel viewModel) {
    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.toggleLoginSignup(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF008F9C) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogin(BuildContext context, LoginViewModel viewModel) {
    return Column(
      children: [
        TextField(
          controller: viewModel.emailController,
          decoration: _inputDecor('Email'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: viewModel.passwordController,
          obscureText: true,
          decoration: _inputDecor('Password'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSignup(BuildContext context, LoginViewModel viewModel) {
    return Column(
      children: [
        TextField(
          controller: viewModel.nicknameController,
          decoration: _inputDecor('Nickname'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: viewModel.emailController,
          decoration: _inputDecor('Email'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: viewModel.passwordController,
          obscureText: true,
          decoration: _inputDecor('Password'),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: viewModel.confirmPasswordController,
          obscureText: true,
          decoration: _inputDecor('Confirm Password'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  InputDecoration _inputDecor(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _loginButton(BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      onPressed: () => viewModel.attemptLogin(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color(0xFF008F9C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Login',
          style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget _signupButton(BuildContext context, LoginViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.attemptSignup(context);
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: const Color(0xFF008F9C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Sign-up',
          style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}
