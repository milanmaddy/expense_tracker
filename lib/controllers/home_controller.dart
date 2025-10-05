import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  var currentTime = ''.obs;
  var currentDate = ''.obs;
  var currentMonth = ''.obs;
  // var roomRent = "8300".obs; // fixed room rent, can be updated dynamically
  // var electricityBill = "8300".obs; // fixed room rent, can be updated dynamically

  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateDateTime();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    currentTime.value =
    '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    currentDate.value =
    '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    currentMonth.value = _getMonthName(now.month);
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}