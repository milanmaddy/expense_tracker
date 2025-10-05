import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/routes/app_routes.dart';
import 'package:teen_tigada/utils/color_const.dart';

class AuthController extends GetxController {
  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable States
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = false.obs;
  final RxBool agreeToTerms = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  // Password Strength Calculator
  String getPasswordStrength(String password) {
    if (password.isEmpty) return '';
    if (password.length < 6) return 'Weak';
    if (password.length < 8) return 'Medium';

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int strength = 0;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasDigits) strength++;
    if (hasSpecialChar) strength++;

    if (password.length >= 12 && strength >= 3) return 'Strong';
    if (password.length >= 8 && strength >= 2) return 'Good';
    return 'Medium';
  }

  // Email Validation
  bool isValidEmail(String email) {
    return GetUtils.isEmail(email.trim());
  }

  // Phone Validation
  bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    return phoneRegex.hasMatch(phone.trim());
  }

  // Login Function
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill all fields correctly',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      isLoading.value = true;
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (!isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      await Future.delayed(const Duration(seconds: 2));

      if (rememberMe.value) {
        debugPrint('Remember me enabled - Save credentials securely');
      }

      Get.snackbar(
        'Success',
        'Login successful! Welcome back.',
        backgroundColor: AppColors.greenSuccess,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      passwordController.clear();
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoute.dashboard);
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register Function
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill all fields correctly',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Terms Required',
        'Please agree to Terms & Conditions and Privacy Policy',
        backgroundColor: AppColors.amberAccent,
        colorText: Colors.white,
        icon: const Icon(Icons.info_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      isLoading.value = true;
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (name.length < 3) {
        throw Exception('Name must be at least 3 characters');
      }

      if (!isValidPhone(phone)) {
        throw Exception('Invalid phone number format');
      }

      if (!isValidEmail(email)) {
        throw Exception('Invalid email format');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }

      if (getPasswordStrength(password) == 'Weak') {
        throw Exception('Password is too weak. Use at least 6 characters.');
      }

      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Account created successfully! Welcome aboard.',
        backgroundColor: AppColors.greenSuccess,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      _clearRegistrationFields();
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoute.dashboard);
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot Password Function
  Future<void> sendPasswordResetEmail(String email) async {
    if (email.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
      Get.snackbar(
        'Email Sent',
        'Password reset link has been sent to your email',
        backgroundColor: AppColors.greenSuccess,
        colorText: Colors.white,
        icon: const Icon(Icons.email_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset email. Please try again.',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Social Login - Google
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Signed in with Google successfully',
        backgroundColor: AppColors.greenSuccess,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoute.dashboard);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign in failed',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Social Login - Apple
  Future<void> loginWithApple() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Signed in with Apple successfully',
        backgroundColor: AppColors.greenSuccess,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoute.dashboard);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Apple sign in failed',
        backgroundColor: AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout Function
  Future<void> logout() async {
    try {
      _clearAllFields();
      rememberMe.value = false;
      agreeToTerms.value = false;
      Get.snackbar(
        'Logged Out',
        'You have been logged out successfully',
        backgroundColor: AppColors.greyText,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.offAllNamed(AppRoute.signIn);
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  // Helper Functions
  void _clearAllFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    phoneController.clear();
  }

  void _clearRegistrationFields() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    agreeToTerms.value = false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}