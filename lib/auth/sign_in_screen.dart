import 'package:cat_shop/controller/auth_controller.dart';
import 'package:cat_shop/routes/route_names.dart';
import 'package:cat_shop/theme/styles.dart';
import 'package:cat_shop/theme/theme.dart';
import 'package:cat_shop/widgets/bottom_navigation.dart';
import 'package:cat_shop/widgets/custom_button.dart';
import 'package:cat_shop/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController authController = Get.put(AuthController());
  final RxBool isLoading = false.obs;
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    authController.login();
  }

  void _navigateToHome(String fullName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationApp(fullName: fullName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Welcome back 👋', style: Styles.titleOne),
              const SizedBox(height: 8),
              const Text('Sign in to continue.', style: Styles.subTitleTwo),
              const SizedBox(height: 30),
              const Text('Email', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: authController.emailController,
                hintText: 'Enter your Email',
                prefixIcon: Icons.email,
              ),
              Obx(() => authController.isEmailValid.value
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Enter a valid email address',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )),
              const SizedBox(height: 16),
              const Text('Password', style: Styles.labelOne),
              const SizedBox(height: 6),
              CustomInputField(
                controller: authController.passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                isPasswordField: true,
                obscureText: passwordVisible,
                togglePasswordVisibility: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              Obx(() => authController.isPasswordValid.value
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Password must be at least 8 characters',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )),
              const SizedBox(height: 60),
              Obx(() => CustomButton(
                    text: 'Sign In',
                    backgroundColor: ThemeClass.mainColor,
                    textColor: Colors.white,
                    width: 200,
                    borderWidth: 2,
                    borderColor: ThemeClass.mainColor,
                    isLoading: isLoading.value,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        isLoading.value = true;

                        authController.login();
                        if (authController.isEmailValid.value &&
                            authController.isPasswordValid.value) {
                          isLoading.value = false;
                          _navigateToHome(
                              authController.fullNameController.text);
                        } else {
                          isLoading.value = false;
                          Get.snackbar(
                            'Error',
                            'Please correct the errors before proceeding',
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        }
                      }
                    },
                  )),
              const SizedBox(height: 30),
              CustomButton(
                text: 'Don’t have an account? Sign Up',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                width: 200,
                borderWidth: 2,
                borderColor: Colors.black,
                onPressed: () {
                  Get.toNamed(RouteNames.signUp);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
