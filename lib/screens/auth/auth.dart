import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/controllers/auth_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:get/get.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
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
//     final AuthController controller = Get.put(AuthController());
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // Gradient Background with Subtle Animation
//             AnimatedContainer(
//               duration: const Duration(seconds: 2),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: theme.brightness == Brightness.dark
//                       ? [
//                     AppColors.blackBackground,
//                     AppColors.blueDarkPrimary.withOpacity(0.3),
//                     AppColors.purpleDarkCategory.withOpacity(0.2),
//                   ]
//                       : [
//                     AppColors.backgroundFill,
//                     AppColors.bluePrimary.withOpacity(0.1),
//                     AppColors.purpleCategory.withOpacity(0.1),
//                   ],
//                 ),
//               ),
//             ),
//             // Wave Decoration at Bottom
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: CustomPaint(
//                 size: Size(size.width, size.height * 0.1),
//                 painter: WavePainter(theme.brightness == Brightness.dark
//                     ? AppColors.cyanAccent.withOpacity(0.2)
//                     : AppColors.cyanAccent.withOpacity(0.3)),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(size.width * 0.05).copyWith(top: size.height * 0.05),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     // Header
//                     FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         children: [
//                           Obx(() => Text(
//                             controller.isLogin.value ? "Welcome Back!" : "Create Account",
//                             style: theme.textTheme.titleLarge?.copyWith(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                               color: theme.brightness == Brightness.dark
//                                   ? AppColors.textDarkSecondary
//                                   : AppColors.textSecondary,
//                             ),
//                           )),
//                           const SizedBox(height: 8),
//                           Obx(() => Text(
//                             controller.isLogin.value ? "Sign in to track your expenses." : "Join to manage your finances!",
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: theme.brightness == Brightness.dark
//                                   ? AppColors.textDarkSecondary
//                                   : AppColors.textSecondary,
//                             ),
//                           )),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: size.height * 0.03),
//
//                     // Animated Logo
//                     ScaleTransition(
//                       scale: _scaleAnimation,
//                       child: Container(
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: theme.brightness == Brightness.dark
//                                 ? [AppColors.blueDarkPrimary, AppColors.purpleDarkCategory]
//                                 : [AppColors.bluePrimary, AppColors.purpleCategory],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: theme.brightness == Brightness.dark
//                                   ? AppColors.purpleDarkCategory.withOpacity(0.3)
//                                   : AppColors.purpleCategory.withOpacity(0.3),
//                               blurRadius: 12,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           "T3",
//                           style: GoogleFonts.outfit(
//                             fontSize: 64,
//                             height: 1,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: size.height * 0.04),
//
//                     // Animated Toggle Switch
//                     Obx(() => AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: theme.brightness == Brightness.dark
//                             ? AppColors.darkSurface
//                             : Colors.white,
//                         borderRadius: BorderRadius.circular(25),
//                         border: Border.all(
//                           color: theme.brightness == Brightness.dark
//                               ? AppColors.blueDarkPrimary.withOpacity(0.3)
//                               : AppColors.bluePrimary.withOpacity(0.3),
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: theme.brightness == Brightness.dark
//                                 ? AppColors.purpleDarkCategory.withOpacity(0.2)
//                                 : AppColors.purpleCategory.withOpacity(0.2),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Stack(
//                         children: [
//                           AnimatedPositioned(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                             left: controller.isLogin.value ? 0 : size.width * 0.45,
//                             right: controller.isLogin.value ? size.width * 0.45 : 0,
//                             top: 0,
//                             bottom: 0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: theme.brightness == Brightness.dark
//                                     ? AppColors.blueDarkPrimary
//                                     : AppColors.bluePrimary,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: GestureDetector(
//                                   onTap: () => controller.toggleAuthMode(),
//                                   child: Center(
//                                     child: Text(
//                                       "Login",
//                                       style: theme.textTheme.labelLarge?.copyWith(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: controller.isLogin.value
//                                             ? Colors.white
//                                             : (theme.brightness == Brightness.dark
//                                             ? AppColors.textDarkSecondary
//                                             : AppColors.greyText),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: GestureDetector(
//                                   onTap: () => controller.toggleAuthMode(),
//                                   child: Center(
//                                     child: Text(
//                                       "Sign Up",
//                                       style: theme.textTheme.labelLarge?.copyWith(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: !controller.isLogin.value
//                                             ? Colors.white
//                                             : (theme.brightness == Brightness.dark
//                                             ? AppColors.textDarkSecondary
//                                             : AppColors.greyText),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )),
//                     SizedBox(height: size.height * 0.04),
//
//                     // Form with Slide Animation
//                     Obx(() => AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       transitionBuilder: (child, animation) => SlideTransition(
//                         position: Tween<Offset>(
//                           begin: const Offset(0.2, 0),
//                           end: Offset.zero,
//                         ).animate(animation),
//                         child: FadeTransition(opacity: animation, child: child),
//                       ),
//                       child: Container(
//                         key: ValueKey(controller.isLogin.value),
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: theme.brightness == Brightness.dark
//                               ? AppColors.darkSurface
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: theme.brightness == Brightness.dark
//                                   ? AppColors.purpleDarkCategory.withOpacity(0.2)
//                                   : AppColors.purpleCategory.withOpacity(0.2),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: controller.isLogin.value
//                             ? _buildLoginForm(controller, size, theme)
//                             : _buildRegisterForm(controller, size, theme),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLoginForm(AuthController controller, Size size, ThemeData theme) {
//     return Form(
//       // key: controller.loginFormKey,
//       child: Column(
//         key: const ValueKey('login'),
//         children: [
//           _buildTextField(
//             controller: controller.emailController,
//             label: 'Email',
//             icon: Icons.email,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your email';
//               if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
//               return null;
//             },
//             theme: theme,
//           ),
//           SizedBox(height: size.height * 0.02),
//           _buildTextField(
//             controller: controller.passwordController,
//             label: 'Password',
//             icon: Icons.lock,
//             isPassword: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your password';
//               if (value.length < 6) return 'Password must be at least 6 characters';
//               return null;
//             },
//             theme: theme,
//           ),
//           SizedBox(height: size.height * 0.03),
//           _buildActionButton(
//             text: 'Login',
//             onPressed: controller.login,
//             size: size,
//             theme: theme,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRegisterForm(AuthController controller, Size size, ThemeData theme) {
//     return Form(
//       // key: controller.registerFormKey,
//       child: Column(
//         key: const ValueKey('register'),
//         children: [
//           _buildTextField(
//             controller: controller.emailController,
//             label: 'Email',
//             icon: Icons.email,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your email';
//               if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
//               return null;
//             },
//             theme: theme,
//           ),
//           SizedBox(height: size.height * 0.02),
//           _buildTextField(
//             controller: controller.passwordController,
//             label: 'Password',
//             icon: Icons.lock,
//             isPassword: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your password';
//               if (value.length < 6) return 'Password must be at least 6 characters';
//               return null;
//             },
//             theme: theme,
//           ),
//           SizedBox(height: size.height * 0.02),
//           _buildTextField(
//             controller: controller.confirmPasswordController,
//             label: 'Confirm Password',
//             icon: Icons.lock,
//             isPassword: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please confirm your password';
//               if (value != controller.passwordController.text) return 'Passwords do not match';
//               return null;
//             },
//             theme: theme,
//           ),
//           SizedBox(height: size.height * 0.03),
//           _buildActionButton(
//             text: 'Sign Up',
//             onPressed: controller.register,
//             size: size,
//             theme: theme,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isPassword = false,
//     String? Function(String?)? validator,
//     required ThemeData theme,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeInOut,
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: theme.textTheme.bodyMedium?.copyWith(
//             fontFamily: GoogleFonts.inter().fontFamily,
//             color: theme.brightness == Brightness.dark
//                 ? AppColors.greyDarkText.withOpacity(0.6)
//                 : AppColors.greyText.withOpacity(0.6),
//           ),
//           prefixIcon: Icon(
//             icon,
//             color: theme.brightness == Brightness.dark
//                 ? AppColors.blueDarkPrimary
//                 : AppColors.bluePrimary,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: theme.brightness == Brightness.dark
//                   ? AppColors.blueDarkPrimary
//                   : AppColors.bluePrimary,
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: theme.brightness == Brightness.dark
//                   ? AppColors.greyDarkDivider.withOpacity(0.2)
//                   : AppColors.greyDivider.withOpacity(0.2),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: theme.brightness == Brightness.dark
//                   ? AppColors.blueDarkPrimary
//                   : AppColors.bluePrimary,
//               width: 2,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: theme.brightness == Brightness.dark
//                   ? AppColors.redDarkError
//                   : AppColors.redError,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: theme.brightness == Brightness.dark
//                   ? AppColors.redDarkError
//                   : AppColors.redError,
//               width: 2,
//             ),
//           ),
//           filled: true,
//           fillColor: theme.brightness == Brightness.dark
//               ? AppColors.darkSurface.withOpacity(0.5)
//               : Colors.white.withOpacity(0.8),
//         ),
//         validator: validator,
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String text,
//     required VoidCallback onPressed,
//     required Size size,
//     required ThemeData theme,
//   }) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: theme.brightness == Brightness.dark
//               ? AppColors.blueDarkPrimary
//               : AppColors.bluePrimary,
//           foregroundColor: Colors.white,
//           minimumSize: Size(double.infinity, size.height * 0.06),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 4,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shadowColor: theme.brightness == Brightness.dark
//               ? AppColors.purpleDarkCategory.withOpacity(0.3)
//               : AppColors.purpleCategory.withOpacity(0.3),
//         ),
//         child: Text(
//           text,
//           style: theme.textTheme.labelLarge?.copyWith(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

class WavePainter extends CustomPainter {
  final Color color;

  WavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.8,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.4,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class AuthController extends GetxController {
//   // Determines which screen to show
//   final isLogin = true.obs;
//
//   void toggle() => isLogin.value = !isLogin.value;
// }
//
//
// class AuthScreen extends StatelessWidget {
//   final AuthController authController = Get.put(AuthController());
//
//   AuthScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             double width = constraints.maxWidth;
//             double formWidth = width > 600 ? 400 : width * 0.9;
//
//             return Center(
//               child: Container(
//                 width: formWidth,
//                 padding: EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [BoxShadow(color: AppColors.primaryColor.withOpacity(0.05), blurRadius: 30, spreadRadius: 5)],
//                 ),
//                 child: Obx(() => Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       authController.isLogin.value ? "Welcome Back!" : "Create Account",
//                       style: TextStyle(
//                           fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       authController.isLogin.value ? "Please sign in to continue." : "Sign up to get started.",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     SizedBox(height: 24),
//                     // Toggle Button Row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => authController.isLogin.value ? null : authController.toggle(),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: authController.isLogin.value
//                                     ? AppColors.primaryColor
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12),
//                               child: Center(
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                     color: authController.isLogin.value ? Colors.white : AppColors.primaryColor,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () => authController.isLogin.value ? authController.toggle() : null,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: !authController.isLogin.value
//                                     ? AppColors.primaryColor
//                                     : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: 12),
//                               child: Center(
//                                 child: Text(
//                                   "Sign Up",
//                                   style: TextStyle(
//                                     color: !authController.isLogin.value ? Colors.white : AppColors.primaryColor,
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 17,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 24),
//                     // Form Fields
//                     if (authController.isLogin.value) LoginForm() else RegisterForm(),
//                   ],
//                 )),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatelessWidget {
//   const LoginForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           decoration: InputDecoration(labelText: "Email", hintText: "Enter your email"),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           obscureText: true,
//           decoration: InputDecoration(labelText: "Password", hintText: "Enter your password"),
//         ),
//         SizedBox(height: 24),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () {/* Implement Login */},
//             child: Text("Sign In"),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class RegisterForm extends StatelessWidget {
//   const RegisterForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           decoration: InputDecoration(labelText: "Full Name", hintText: "Enter your name"),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           decoration: InputDecoration(labelText: "Email", hintText: "Enter your email"),
//         ),
//         SizedBox(height: 16),
//         TextField(
//           obscureText: true,
//           decoration: InputDecoration(labelText: "Password", hintText: "Create a password"),
//         ),
//         SizedBox(height: 24),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: () {/* Implement Register */},
//             child: Text("Sign Up"),
//           ),
//         ),
//       ],
//     );
//   }
// }
