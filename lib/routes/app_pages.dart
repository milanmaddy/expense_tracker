import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/screens/auth/login.dart';
import 'package:teen_tigada/screens/auth/register.dart';
import 'package:teen_tigada/screens/dashboard/dashboard.dart';
import 'package:teen_tigada/screens/expense/add_expense.dart';
import 'package:teen_tigada/screens/pay_owner/pay_owner.dart';
import 'package:teen_tigada/screens/splash/splash.dart';
import 'app_routes.dart';

class AppPages{
  static final List<GetPage> getPages = [
    GetPage(
        name: AppRoute.splash,
        page: () => SplashScreen(),
        curve: Curves.easeOut),
    // GetPage(name: AppRoute.auth, page: () => AuthScreen()),
    GetPage(name: AppRoute.signIn, page: () => LoginScreen()),
    GetPage(name: AppRoute.signUp, page: () => RegisterScreen()),
    GetPage(name: AppRoute.dashboard, page: () => Dashboard()),
    GetPage(name: AppRoute.addExpense, page: () => AddExpense()),
    GetPage(name: AppRoute.payOwner, page: () => PayOwnerPage()),
  ];
}