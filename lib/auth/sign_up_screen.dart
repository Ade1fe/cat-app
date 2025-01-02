import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cat_shop/controller/auth_controller.dart';
import 'package:cat_shop/routes/route_names.dart';
import 'package:cat_shop/theme/styles.dart';
import 'package:cat_shop/theme/theme.dart';
import 'package:cat_shop/widgets/bottom_navigation.dart';
import 'package:cat_shop/widgets/custom_button.dart';
import 'package:cat_shop/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController _authController = Get.put(AuthController());
  final RxBool _isLoading = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString('fullName');
    if (fullName != null && mounted) {
      _navigateToHome(fullName);
    }
  }

  Future<void> _saveUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', _fullNameController.text);
    await prefs.setString('email', _emailController.text);
    log('User details saved: ${_fullNameController.text}, ${_emailController.text}');
  }

  void _navigateToHome(String fullName) {
    Get.off(() => BottomNavigationApp(fullName: fullName));
  }

  void _onSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _isLoading.value = true;

    try {
      _authController.signup(
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
      );

      await _saveUserDetails();
      _navigateToHome(_fullNameController.text);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
                controller: _fullNameController,
                hintText: 'Enter your Full Name',
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full name is required';
                  } else if (RegExp(r'\d').hasMatch(value)) {
                    return 'Name must not include numbers';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Email', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: _emailController,
                hintText: 'Enter your Email',
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Password', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: _passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                isPasswordField: true,
                obscureText: _passwordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 60),
              Obx(() => CustomButton(
                    text: 'Sign Up',
                    backgroundColor: ThemeClass.mainColor,
                    textColor: Colors.white,
                    width: 200,
                    borderWidth: 2,
                    borderColor: ThemeClass.mainColor,
                    isLoading: _isLoading.value,
                    onPressed: _onSignUp,
                  )),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Already have an account? Sign In',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: Colors.black,
                onPressed: () => Get.toNamed(RouteNames.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
