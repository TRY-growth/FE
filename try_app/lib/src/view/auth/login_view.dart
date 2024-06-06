import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Image.asset(
              'assets/images/4.png',
              height: 150,
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isLogin ? const Color(0xFF008F9C) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLogin ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => isLogin = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isLogin ? Colors.white : const Color(0xFF008F9C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Sign-up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLogin ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            isLogin ? buildLogin(context) : buildSignup(context),
            const SizedBox(height: 32),
            isLogin ? loginButton(context) : signupButton(context),
          ],
        ),
      ),
    );
  }
}

Widget buildLogin(BuildContext context) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  return Column(
    key: const ValueKey('login'),
    children: [
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 24),
    ],
  );
}

Widget buildSignup(BuildContext context) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  return Column(
    key: const ValueKey('signup'),
    children: [
      TextField(
        controller: nicknameController,
        decoration: InputDecoration(
          labelText: 'Name',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 16),
      TextField(
        controller: confirmPasswordController,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: true,
      ),
      const SizedBox(height: 24),
    ],
  );
}

Widget loginButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, '/home');
    },
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: const Color(0xFF008F9C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Text(
      'Login',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}

Widget signupButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.popAndPushNamed(context, '/');
    },
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: const Color(0xFF008F9C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: const Text(
      'Sign-up',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
