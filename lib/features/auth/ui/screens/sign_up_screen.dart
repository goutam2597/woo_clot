import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_text_field.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        text: 'First Name *',
                        hintText: 'Enter First Name',
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        text: 'Last Name *',
                        hintText: 'Enter Last Name',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        text: 'Email Address *',
                        hintText: 'Enter Email Address',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        text: 'Password *',
                        hintText: 'Enter password',
                        obscureText: !isPasswordVisible,
                        icon: isPasswordVisible
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        onTap: () {
                          setState(
                            () => isPasswordVisible = !isPasswordVisible,
                          );
                        },
                      ),

                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an Account ?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // Since we pushed SignUp from Login using named routes,
                      // a simple pop will return to Login.
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
