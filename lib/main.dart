import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/controllers/auth_controller.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:teen_tigada/controllers/home_controller.dart';
import 'package:teen_tigada/controllers/splash_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  Get.put(SplashController());
  Get.put(HomeController());
  Get.put(UserController());
  Get.put(AuthController());

  Get.put(ExpenseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: 'Te3n Tigada',
      debugShowCheckedModeBanner: false,
      theme: themeController.theme,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
      getPages: AppPages.getPages,
      initialRoute: AppRoute.signIn,
    ));
  }
}

