import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../services/api_service.dart';
import '../../../../utils/colors.dart';

import '../../../widgets/CreateAccount/SignIn.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/customTextFeild.dart';
import '../../../widgets/General/custom_back_button.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import '../forgotPasswordScreens/forgot_password.dart';
import '../Sign Up/SignUp.dart';
import 'dilog_success.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _hasPasswordOneNumber = false;
  bool _hasPasswordSpecialCharacter = false;
  bool _isPasswordEightCharacters = false;
  bool _isVisible = false;
  bool isLoading = false;

  void _attemptSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      bool success = await ApiService().signIn(email, password);
      if (success) {
        Get.to(BottomNavigation(role: 'Home', selectedIndex: 0));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.showThankYouDialog(
            context: context,
            title: "Login Successful",
            message: "Welcome back!",
            durationInSeconds: 4,
          );
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to sign in')));
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      CustomBackButton(
                        showBackground: true,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Header(
                        title1: 'Log in',
                        title2: 'Make sure that you already have an account.',
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      CustomTextField(
                        name: 'Email',
                        labelText: 'Enter your email',
                        keyboardType: TextInputType.name,
                        showClearIcon: true,
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          _passwordFocusNode.requestFocus();
                        },
                    
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/mail.svg'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        name: 'Password',
                        controller: _passwordController,
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        showClearIcon: false,
               
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          _attemptSignIn();
                        },
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 12, bottom: 12, right: 4),
                          child: SvgPicture.asset('assets/svgs/password.svg'),
                        ),
                        isPasswordField: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  "forgot your password ?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: colorDarkBlue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 75),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 2,
                              color: grey300,
                            ),
                          ),
                          const Text('Or Log in with',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: colorDarkBlue,
                                  fontWeight: FontWeight.w400)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 2,
                              color: grey300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GoogleLoginButton(
                            onTap: () {
                              // Handle Google login
                            },
                            svg: 'assets/svgs/Google.svg',
                          ),
                          const SizedBox(width: 24),
                          GoogleLoginButton(
                            onTap: () {
                              // Handle Facebook login
                            },
                            svg: 'assets/svgs/Facebook.svg',
                          )
                        ],
                      ),
                      const SizedBox(height: 130),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontSize: 13,
                              color: colorDarkBlue,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Get.to(SignUp());
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 13,
                                color: colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'Sign in',
                onPressed: isLoading ? null : _attemptSignIn,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}
