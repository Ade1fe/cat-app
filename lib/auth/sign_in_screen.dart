// ignore_for_file: use_build_context_synchronously

import 'package:cat_shop/hooks/auth_helper.dart';
import 'package:cat_shop/routes/route_names.dart';
import 'package:cat_shop/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat_shop/widgets/bottom_navigation.dart';
import 'package:cat_shop/widgets/custom_button.dart';
import 'package:cat_shop/theme/styles.dart';
import 'package:cat_shop/theme/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    setState(() => isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Email or password cannot be empty.');
      setState(() => isLoading = false);
      return;
    }

    try {
      final isValid = await AuthHelper.validateLogin(email, password, email);

      if (isValid) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('fullName', email);

        if (mounted) {
          _navigateToHome(email);
        }
      } else {
        _showSnackbar('Invalid login credentials.');
      }
    } catch (error) {
      _showSnackbar('An error occurred during sign-in. Please try again.');
      debugPrint('Error during sign-in: $error');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _navigateToHome(String fullName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationApp(fullName: fullName),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateEmail(String value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return emailRegex.hasMatch(value) ? null : 'Enter a valid email address';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text('Welcome back 👋', style: Styles.titleOne),
              const SizedBox(height: 8),
              const Text('Sign in to continue.', style: Styles.subTitleTwo),
              const SizedBox(height: 30),
              const Text('Email', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: emailController,
                hintText: 'Enter your Email',
                prefixIcon: Icons.email,
                validator: (value) => _validateEmail(value ?? ''),
              ),
              const SizedBox(height: 16),
              const Text('Password', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                isPasswordField: true,
                obscureText: passwordVisible,
                togglePasswordVisibility: () {
                  setState(() => passwordVisible = !passwordVisible);
                },
                validator: (value) =>
                    (value?.length ?? 0) < 8 ? 'Password too short' : null,
              ),
              const SizedBox(height: 60),
              CustomButton(
                text: 'Sign In',
                backgroundColor: ThemeClass.mainColor,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: ThemeClass.mainColor,
                isLoading: isLoading,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _signIn();
                  }
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Don’t have an account? Sign Up',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
