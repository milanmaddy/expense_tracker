import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/controllers/auth_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/widgets/custom_button.dart';
import 'package:teen_tigada/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  final RxBool agreeToTerms = false.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),

                // Logo Section with Scale Animation
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [
                              AppColors.blueDarkPrimary,
                              AppColors.purpleDarkCategory,
                            ]
                                : [
                              AppColors.bluePrimary,
                              AppColors.purpleCategory,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: (isDark
                                  ? AppColors.blueDarkPrimary
                                  : AppColors.bluePrimary)
                                  .withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "T3",
                            style: GoogleFonts.outfit(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.045),

                // Welcome Text
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create Account',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textDarkSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Join us to start tracking your expenses effortlessly',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyText,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                // Form
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Form(
                      key: controller.registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Full Name Field
                          CustomTextField(
                            controller: nameController,
                            hintText: "Enter your full name",
                            labelText: "Full Name",
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: isDark
                                  ? AppColors.greyDarkText
                                  : AppColors.greyText,
                              size: 20,
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Full name is required';
                              }
                              if (v.trim().length < 3) {
                                return 'Name must be at least 3 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Phone Number Field
                          CustomTextField(
                            controller: phoneController,
                            hintText: "Enter your phone number",
                            labelText: "Phone Number",
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icon(
                              Icons.phone_outlined,
                              color: isDark
                                  ? AppColors.greyDarkText
                                  : AppColors.greyText,
                              size: 20,
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Phone number is required';
                              }
                              if (v.trim().length < 10) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Email Field
                          CustomTextField(
                            controller: controller.emailController,
                            hintText: "Enter your email",
                            labelText: "Email Address",
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: isDark
                                  ? AppColors.greyDarkText
                                  : AppColors.greyText,
                              size: 20,
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!GetUtils.isEmail(v.trim())) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Password Field
                          CustomTextField(
                            controller: controller.passwordController,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: isDark
                                  ? AppColors.greyDarkText
                                  : AppColors.greyText,
                              size: 20,
                            ),
                            hintText: "Create a password",
                            labelText: "Password",
                            obscureText: true,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password is required';
                              }
                              if (v.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 18),

                          // Confirm Password Field
                          CustomTextField(
                            controller: controller.confirmPasswordController,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: isDark
                                  ? AppColors.greyDarkText
                                  : AppColors.greyText,
                              size: 20,
                            ),
                            hintText: "Confirm your password",
                            labelText: "Confirm Password",
                            obscureText: true,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (v != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          // Terms & Conditions Checkbox
                          Obx(
                                () => InkWell(
                              onTap: () =>
                              agreeToTerms.value = !agreeToTerms.value,
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                      const Duration(milliseconds: 200),
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        color: agreeToTerms.value
                                            ? (isDark
                                            ? AppColors.blueDarkPrimary
                                            : AppColors.bluePrimary)
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: agreeToTerms.value
                                              ? (isDark
                                              ? AppColors.blueDarkPrimary
                                              : AppColors.bluePrimary)
                                              : AppColors.greyDivider,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: agreeToTerms.value
                                          ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                          : null,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          text: 'I agree to the ',
                                          style: GoogleFonts.dmSans(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: isDark
                                                ? AppColors.greyDarkText
                                                : AppColors.greyText,
                                            height: 1.5,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Terms & Conditions',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? AppColors.blueDarkPrimary
                                                    : AppColors.bluePrimary,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' and ',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: isDark
                                                    ? AppColors.greyDarkText
                                                    : AppColors.greyText,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: GoogleFonts.dmSans(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? AppColors.blueDarkPrimary
                                                    : AppColors.bluePrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Sign Up Button
                          Obx(() => _buildSignUpButton(controller)),

                          const SizedBox(height: 22),

                          // OR Divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: isDark
                                      ? AppColors.greyDarkDivider
                                      : AppColors.greyDivider.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? AppColors.greyDarkText
                                        : AppColors.greyText,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: isDark
                                      ? AppColors.greyDarkDivider
                                      : AppColors.greyDivider.withOpacity(0.3),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          // Social Sign Up Buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  icon: Icons.g_mobiledata,
                                  label: 'Google',
                                  isDark: isDark,
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSocialButton(
                                  icon: Icons.apple,
                                  label: 'Apple',
                                  isDark: isDark,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sign In Link
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.greyDarkText
                                : AppColors.greyText,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.blueDarkPrimary
                                  : AppColors.bluePrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(AuthController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.blueDarkPrimary, AppColors.purpleDarkCategory]
              : [AppColors.bluePrimary, AppColors.purpleCategory],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: controller.isLoading.value
            ? []
            : [
          BoxShadow(
            color: (isDark
                ? AppColors.blueDarkPrimary
                : AppColors.bluePrimary)
                .withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.isLoading.value
              ? null
              : () {
            if (agreeToTerms.value) {
              controller.register();
            } else {
              Get.snackbar(
                'Terms Required',
                'Please agree to Terms & Conditions',
                backgroundColor: AppColors.redError,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
            }
          },
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: controller.isLoading.value
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              "Create Account",
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.blackBackground.withOpacity(0.5)
              : AppColors.backgroundFill,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? AppColors.greyDarkDivider.withOpacity(0.3)
                : AppColors.greyDivider.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isDark ? AppColors.textDarkSecondary : AppColors.greyText,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                isDark ? AppColors.textDarkSecondary : AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _logoRotateAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1400),
//     );
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//     ));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.25),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
//     ));
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.7,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
//     ));
//
//     _logoRotateAnimation = Tween<double>(
//       begin: -0.1,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
//     ));
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final AuthController controller = Get.find<AuthController>();
//
//     return Scaffold(
//       backgroundColor: isDark ? AppColors.darkSurface : const Color(0xFFFAFBFC),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: size.height * 0.04),
//
//                 // Back Button
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: IconButton(
//                     onPressed: () => Get.back(),
//                     icon: Icon(
//                       Icons.arrow_back_ios_new_rounded,
//                       color: isDark
//                           ? AppColors.textDarkSecondary
//                           : const Color(0xFF374151),
//                       size: 22,
//                     ),
//                     style: IconButton.styleFrom(
//                       backgroundColor: isDark
//                           ? AppColors.darkSurface
//                           : Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         side: BorderSide(
//                           color: isDark
//                               ? AppColors.greyDarkText.withOpacity(0.2)
//                               : const Color(0xFFE5E7EB),
//                           width: 1.5,
//                         ),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: size.height * 0.03),
//
//                 // Animated Logo Section
//                 ScaleTransition(
//                   scale: _scaleAnimation,
//                   child: RotationTransition(
//                     turns: _logoRotateAnimation,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Center(
//                         child: Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: isDark
//                                   ? [
//                                 AppColors.blueDarkPrimary,
//                                 AppColors.purpleDarkCategory,
//                               ]
//                                   : [
//                                 const Color(0xFF6366F1),
//                                 const Color(0xFF8B5CF6),
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(26),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: (isDark
//                                     ? AppColors.blueDarkPrimary
//                                     : const Color(0xFF6366F1))
//                                     .withOpacity(0.5),
//                                 blurRadius: 32,
//                                 offset: const Offset(0, 16),
//                                 spreadRadius: 0,
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               "T3",
//                               style: GoogleFonts.outfit(
//                                 fontSize: 48,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w900,
//                                 height: 1,
//                                 letterSpacing: -2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: size.height * 0.04),
//
//                 // Welcome Text with Animation
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Create Account ✨',
//                           style: GoogleFonts.outfit(
//                             fontSize: 34,
//                             fontWeight: FontWeight.w800,
//                             color: isDark
//                                 ? AppColors.textDarkSecondary
//                                 : const Color(0xFF1F2937),
//                             height: 1.2,
//                             letterSpacing: -1,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'Join us to start managing your finances smartly',
//                           style: GoogleFonts.inter(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: isDark
//                                 ? AppColors.greyDarkText.withOpacity(0.75)
//                                 : const Color(0xFF6B7280),
//                             height: 1.6,
//                             letterSpacing: 0.2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: size.height * 0.035),
//
//                 // Form Section
//                 SlideTransition(
//                   position: _slideAnimation,
//                   child: FadeTransition(
//                     opacity: _fadeAnimation,
//                     child: Form(
//                       key: controller.registerFormKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Full Name Field
//                           _buildInputLabel('Full Name', isDark),
//                           const SizedBox(height: 10),
//                           _buildNameField(controller, isDark),
//
//                           const SizedBox(height: 22),
//
//                           // Email Field
//                           _buildInputLabel('Email Address', isDark),
//                           const SizedBox(height: 10),
//                           _buildEmailField(controller, isDark),
//
//                           const SizedBox(height: 22),
//
//                           // Password Field
//                           _buildInputLabel('Password', isDark),
//                           const SizedBox(height: 10),
//                           _buildPasswordField(controller, isDark),
//
//                           const SizedBox(height: 22),
//
//                           // Confirm Password Field
//                           _buildInputLabel('Confirm Password', isDark),
//                           const SizedBox(height: 10),
//                           _buildConfirmPasswordField(controller, isDark),
//
//                           const SizedBox(height: 20),
//
//                           // Terms & Conditions
//                           _buildTermsCheckbox(controller, isDark),
//
//                           const SizedBox(height: 32),
//
//                           // Sign Up Button
//                           Obx(() => _buildSignUpButton(controller, isDark)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // Divider with "OR"
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: _buildDividerWithText('OR', isDark),
//                 ),
//
//                 const SizedBox(height: 28),
//
//                 // Social Login Buttons
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: _buildSocialButtons(isDark),
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // Sign In Link
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: _buildSignInLink(isDark),
//                 ),
//
//                 SizedBox(height: size.height * 0.04),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputLabel(String label, bool isDark) {
//     return Text(
//       label,
//       style: GoogleFonts.inter(
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: isDark ? AppColors.textDarkSecondary : const Color(0xFF374151),
//         letterSpacing: 0.1,
//       ),
//     );
//   }
//
//   Widget _buildNameField(AuthController controller, bool isDark) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.2)
//                 : Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: CustomTextField(
//         controller: controller.nameController,
//         hintText: "Enter your full name",
//         keyboardType: TextInputType.name,
//         prefixIcon: Container(
//           padding: const EdgeInsets.all(12),
//           child: Icon(
//             Icons.person_outline_rounded,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//         ),
//         validator: (v) {
//           if (v == null || v.trim().isEmpty) {
//             return 'Name is required';
//           }
//           if (v.trim().length < 3) {
//             return 'Name must be at least 3 characters';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildEmailField(AuthController controller, bool isDark) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.2)
//                 : Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: CustomTextField(
//         controller: controller.emailController,
//         hintText: "your.email@example.com",
//         keyboardType: TextInputType.emailAddress,
//         prefixIcon: Container(
//           padding: const EdgeInsets.all(12),
//           child: Icon(
//             Icons.email_outlined,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//         ),
//         validator: (v) {
//           if (v == null || v.trim().isEmpty) {
//             return 'Email is required';
//           }
//           if (!GetUtils.isEmail(v.trim())) {
//             return 'Enter a valid email address';
//           }
//           return null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildPasswordField(AuthController controller, bool isDark) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.2)
//                 : Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Obx(() => CustomTextField(
//         controller: controller.passwordController,
//         prefixIcon: Container(
//           padding: const EdgeInsets.all(12),
//           child: Icon(
//             Icons.lock_outline_rounded,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             controller.isPasswordVisible.value
//                 ? Icons.visibility_outlined
//                 : Icons.visibility_off_outlined,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//           onPressed: controller.togglePasswordVisibility,
//           splashRadius: 24,
//         ),
//         hintText: "Create a strong password",
//         obscureText: !controller.isPasswordVisible.value,
//         validator: (v) {
//           if (v == null || v.isEmpty) {
//             return 'Password is required';
//           }
//           if (v.length < 6) {
//             return 'Password must be at least 6 characters';
//           }
//           return null;
//         },
//       )),
//     );
//   }
//
//   Widget _buildConfirmPasswordField(AuthController controller, bool isDark) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.2)
//                 : Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Obx(() => CustomTextField(
//         controller: controller.confirmPasswordController,
//         prefixIcon: Container(
//           padding: const EdgeInsets.all(12),
//           child: Icon(
//             Icons.lock_outline_rounded,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             controller.isConfirmPasswordVisible.value
//                 ? Icons.visibility_outlined
//                 : Icons.visibility_off_outlined,
//             color: isDark
//                 ? AppColors.greyDarkText.withOpacity(0.7)
//                 : const Color(0xFF9CA3AF),
//             size: 22,
//           ),
//           onPressed: controller.toggleConfirmPasswordVisibility,
//           splashRadius: 24,
//         ),
//         hintText: "Re-enter your password",
//         obscureText: !controller.isConfirmPasswordVisible.value,
//         validator: (v) {
//           if (v == null || v.isEmpty) {
//             return 'Please confirm your password';
//           }
//           if (v != controller.passwordController.text) {
//             return 'Passwords do not match';
//           }
//           return null;
//         },
//       )),
//     );
//   }
//
//   Widget _buildTermsCheckbox(AuthController controller, bool isDark) {
//     return Obx(() => InkWell(
//       onTap: controller.toggleAcceptTerms,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 250),
//               curve: Curves.easeInOut,
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 gradient: controller.acceptTerms.value
//                     ? LinearGradient(
//                   colors: isDark
//                       ? [
//                     AppColors.blueDarkPrimary,
//                     AppColors.purpleDarkCategory,
//                   ]
//                       : [
//                     const Color(0xFF6366F1),
//                     const Color(0xFF8B5CF6),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//                     : null,
//                 color: controller.acceptTerms.value
//                     ? null
//                     : Colors.transparent,
//                 border: Border.all(
//                   color: controller.acceptTerms.value
//                       ? Colors.transparent
//                       : (isDark
//                       ? AppColors.greyDarkText.withOpacity(0.3)
//                       : const Color(0xFFD1D5DB)),
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(7),
//               ),
//               child: controller.acceptTerms.value
//                   ? const Icon(
//                 Icons.check_rounded,
//                 size: 16,
//                 color: Colors.white,
//               )
//                   : null,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text.rich(
//                 TextSpan(
//                   text: 'I agree to the ',
//                   style: GoogleFonts.inter(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: isDark
//                         ? AppColors.greyDarkText
//                         : const Color(0xFF6B7280),
//                   ),
//                   children: [
//                     TextSpan(
//                       text: 'Terms & Conditions',
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isDark
//                             ? AppColors.blueDarkPrimary
//                             : const Color(0xFF6366F1),
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                     TextSpan(
//                       text: ' and ',
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: isDark
//                             ? AppColors.greyDarkText
//                             : const Color(0xFF6B7280),
//                       ),
//                     ),
//                     TextSpan(
//                       text: 'Privacy Policy',
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: isDark
//                             ? AppColors.blueDarkPrimary
//                             : const Color(0xFF6366F1),
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   Widget _buildSignUpButton(AuthController controller, bool isDark) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       width: double.infinity,
//       height: 58,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: controller.isLoading.value
//               ? isDark
//               ? [
//             AppColors.blueDarkPrimary.withOpacity(0.6),
//             AppColors.purpleDarkCategory.withOpacity(0.6)
//           ]
//               : [
//             const Color(0xFF6366F1).withOpacity(0.6),
//             const Color(0xFF8B5CF6).withOpacity(0.6)
//           ]
//               : isDark
//               ? [
//             AppColors.blueDarkPrimary,
//             AppColors.purpleDarkCategory
//           ]
//               : [
//             const Color(0xFF6366F1),
//             const Color(0xFF8B5CF6),
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: controller.isLoading.value
//             ? []
//             : [
//           BoxShadow(
//             color: (isDark
//                 ? AppColors.blueDarkPrimary
//                 : const Color(0xFF6366F1))
//                 .withOpacity(0.4),
//             blurRadius: 24,
//             offset: const Offset(0, 12),
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: controller.isLoading.value ? null : controller.register,
//           borderRadius: BorderRadius.circular(16),
//           child: Center(
//             child: controller.isLoading.value
//                 ? const SizedBox(
//               width: 26,
//               height: 26,
//               child: CircularProgressIndicator(
//                 strokeWidth: 3,
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//               ),
//             )
//                 : Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Create Account",
//                   style: GoogleFonts.inter(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Icon(
//                   Icons.arrow_forward_rounded,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDividerWithText(String text, bool isDark) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 1,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.transparent,
//                   isDark
//                       ? AppColors.greyDarkText.withOpacity(0.3)
//                       : const Color(0xFFE5E7EB),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             text,
//             style: GoogleFonts.inter(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//               color: isDark
//                   ? AppColors.greyDarkText.withOpacity(0.6)
//                   : const Color(0xFF9CA3AF),
//               letterSpacing: 1,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: 1,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   isDark
//                       ? AppColors.greyDarkText.withOpacity(0.3)
//                       : const Color(0xFFE5E7EB),
//                   Colors.transparent,
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSocialButtons(bool isDark) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildSocialButton(
//             icon: Icons.g_mobiledata_rounded,
//             label: 'Google',
//             isDark: isDark,
//             onTap: () {
//               Get.snackbar(
//                 'Coming Soon',
//                 'Google Sign-Up will be available soon',
//                 backgroundColor: AppColors.cyanAccent,
//                 colorText: Colors.white,
//                 snackPosition: SnackPosition.TOP,
//                 margin: const EdgeInsets.all(16),
//                 borderRadius: 12,
//               );
//             },
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _buildSocialButton(
//             icon: Icons.apple_rounded,
//             label: 'Apple',
//             isDark: isDark,
//             onTap: () {
//               Get.snackbar(
//                 'Coming Soon',
//                 'Apple Sign-Up will be available soon',
//                 backgroundColor: AppColors.cyanAccent,
//                 colorText: Colors.white,
//                 snackPosition: SnackPosition.TOP,
//                 margin: const EdgeInsets.all(16),
//                 borderRadius: 12,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSocialButton({
//     required IconData icon,
//     required String label,
//     required bool isDark,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         color: isDark ? AppColors.darkSurface : Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(
//           color: isDark
//               ? AppColors.greyDarkText.withOpacity(0.2)
//               : const Color(0xFFE5E7EB),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.1)
//                 : Colors.black.withOpacity(0.03),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(14),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   icon,
//                   color: isDark
//                       ? AppColors.textDarkSecondary
//                       : const Color(0xFF374151),
//                   size: 24,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   label,
//                   style: GoogleFonts.inter(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: isDark
//                         ? AppColors.textDarkSecondary
//                         : const Color(0xFF374151),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignInLink(bool isDark) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Already have an account? ",
//             style: GoogleFonts.inter(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color:
//               isDark ? AppColors.greyDarkText : const Color(0xFF6B7280),
//             ),
//           ),
//           InkWell(
//             onTap: () => Get.back(),
//             borderRadius: BorderRadius.circular(6),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
//               child: ShaderMask(
//                 shaderCallback: (bounds) => LinearGradient(
//                   colors: isDark
//                       ? [
//                     AppColors.blueDarkPrimary,
//                     AppColors.purpleDarkCategory,
//                   ]
//                       : [
//                     const Color(0xFF6366F1),
//                     const Color(0xFF8B5CF6),
//                   ],
//                 ).createShader(bounds),
//                 child: Text(
//                   "Sign In",
//                   style: GoogleFonts.inter(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }