import 'dart:developer';
import 'package:e_learn/pages/signin_sigin_up/signup_page.dart';
import 'package:e_learn/services/helper/controller/helper_controller.dart';
import 'package:e_learn/utils/theme/colors.dart';
import 'package:e_learn/utils/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final RxBool _isChecked = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  Center(
                    child: Image.asset('assets/images/main_logo_img.png'),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Let’s Sign In.!',
                    style: headingFontStyle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Login to Your Account to Continue your Courses',
                    style: descriptionFontStyle,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      prefixIcon: Image.asset('assets/icons/mail_ic.png'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      prefixIcon: Image.asset('assets/icons/lock_ic.png'),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  checkboxTheme: const CheckboxThemeData(
                                    side: BorderSide(
                                        width: 2, color: componentsColor),
                                  ),
                                ),
                                child: Checkbox(
                                  checkColor: overlayColor,
                                  activeColor: componentsColor,
                                  value: _isChecked.value,
                                  onChanged: (bool? newValue) {
                                    _isChecked.value = newValue!;
                                  },
                                ),
                              );
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      const Text('Forgot Password?'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 400,
                      height: 60,
                      child: ElevatedButton(onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          log('Email: ${_emailController.text}');
                          log('Password: ${_passwordController.text}');

                          helperController.userSigin(
                              _emailController.text, _passwordController.text);
                          // Get.to(NavigationPage());
                        }
                      }, child: Obx(() {
                        return helperController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Sign In',
                                style: headingFontStyle.copyWith(fontSize: 18),
                              );
                      })),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Or Continue With',
                      style: descriptionFontStyle.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/google_ic.png'),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/icons/apple_ic.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don’t have an Account ?',
                          style: descriptionFontStyle.copyWith(
                              color: Colors.black)),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.to(SignUpPage());
                        },
                        child: Text(
                          'SIGN UP',
                          style: descriptionFontStyle.copyWith(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
