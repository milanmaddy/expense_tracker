import 'package:get/get.dart';
import 'package:teen_tigada/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      // Get.toNamed(AppRoute.signIn);
    });
  }
}