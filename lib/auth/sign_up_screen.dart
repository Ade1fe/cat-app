import 'package:cat_shop/routes/route_names.dart';
import 'package:cat_shop/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cat_shop/widgets/custom_button.dart';
import 'package:cat_shop/theme/styles.dart';
import 'package:cat_shop/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cat_shop/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  Future<void> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    debugPrint('User is logged in: $isLoggedIn');

    if (isLoggedIn) {
      final fullName = prefs.getString('fullName') ?? '';
      debugPrint('Logged in as: $fullName');
      _navigateToHome(fullName);
    }
  }

  Future<void> _saveUserDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullName', fullNameController.text);
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('isLoggedIn', true);

      debugPrint('User details saved successfully!');
    } catch (e) {
      debugPrint('Error saving user details: $e');
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

  String? _emailValidation(String value) {
    bool isValidEmail =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return isValidEmail ? null : "Enter a valid email address";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Create an account ✨', style: Styles.titleOne),
              const SizedBox(height: 8),
              const Text('Welcome! Please create an account.',
                  style: Styles.subTitleTwo),
              const SizedBox(height: 30),
              const Text('Name', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: fullNameController,
                hintText: 'Enter your full name',
                prefixIcon: Icons.person,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              const Text('Email', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: emailController,
                hintText: 'Enter your Email',
                prefixIcon: Icons.email,
                validator: (value) => _emailValidation(value ?? ''),
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
                validator: (value) => value == null || value.length < 8
                    ? 'Password must be at least 8 characters'
                    : null,
              ),
              const SizedBox(height: 60),
              CustomButton(
                text: "Sign up",
                backgroundColor: ThemeClass.mainColor,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: ThemeClass.mainColor,
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _saveUserDetails();
                    _navigateToHome(fullNameController.text);
                  }
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "Already have an account? Log in",
                backgroundColor: Colors.black,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.signIn);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
