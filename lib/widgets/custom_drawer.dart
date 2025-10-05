import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/routes/app_routes.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/utils/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/routes/app_routes.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/utils/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  final bool isDarkTheme;
  final Color textColor;
  final Color subTextColor;
  final double padding;
  final double bodyFontSize;
  final bool isSmallScreen;

  const CustomDrawer({
    super.key,
    required this.isDarkTheme,
    required this.textColor,
    required this.subTextColor,
    required this.padding,
    required this.bodyFontSize,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final themeController = Get.find<ThemeController>();

    // Initialize switchController with current theme state
    final switchController = ValueNotifier<bool>(themeController.isDarkMode.value);

    // Sync switchController with ThemeController's isDarkMode
    ever(themeController.isDarkMode, (bool isDark) {
      if (switchController.value != isDark) {
        switchController.value = isDark;
      }
    });

    return Drawer(
      backgroundColor: isDarkTheme ? AppColors.darkSurface : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: OutfitText(
              text: userController.currentUser.value.name!,
              fontSize: bodyFontSize + 4,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            accountEmail: OutfitText(
              text: userController.currentUser.value.email ?? 'areyoucrazy@gmail.com',
              fontSize: bodyFontSize,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(
              radius: isSmallScreen ? 30 : 40,
              backgroundImage: NetworkImage(
                userController.currentUser.value.profileUrl!,
              ),
              backgroundColor: AppColors.getRandomColor(isDarkTheme, 2),
              onBackgroundImageError: (_, __) =>
              const Icon(Icons.person, color: Colors.white),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkTheme
                    ? [AppColors.blueDarkPrimary, AppColors.brightIndigoDark]
                    : [AppColors.bluePrimary, AppColors.brightIndigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDarkTheme
                      ? AppColors.blueDarkPrimary.withOpacity(0.3)
                      : AppColors.bluePrimary.withOpacity(0.3),
                  blurRadius: isSmallScreen ? 6 : 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(padding),
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  title: "Home",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.home);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.monetization_on,
                  title: "Add Expense",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoute.addExpense);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.account_balance_wallet_rounded,
                  title: "Pay Owner",
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed(AppRoute.payOwner);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  title: "Transaction History",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.transactionDetails);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.account_balance,
                  title: "Balances",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.balance);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.bar_chart,
                  title: "Statistics",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.statistics);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.notifications);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.person,
                  title: "Profile",
                  onTap: () {
                    Navigator.pop(context);
                    // Get.toNamed(AppRoute.profile);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: _buildDrawerItem(
              icon: Icons.brightness_6,
              title: "Theme",
              onTap: () {
                themeController.toggleTheme();
              },
              isTrailing: true,
              switchController: switchController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    Color? highlightColor,
    bool isTrailing = false,
    ValueNotifier<bool>? switchController,
  }) {
    final themeController = Get.find<ThemeController>();
    final itemColor = highlightColor ?? color ?? textColor;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8.0 : 16.0),
      leading: Icon(
        icon,
        color: itemColor,
        size: isSmallScreen ? 20 : 24,
      ),
      trailing: isTrailing
          ? SizedBox(
        width: isSmallScreen ? 60.0 : 70.0,
        child: ValueListenableBuilder<bool>(
          valueListenable: switchController!,
          builder: (context, value, child) {
            return AdvancedSwitch(
              controller: switchController,
              activeColor: AppColors.bluePrimary,
              inactiveColor: AppColors.greyText,
              activeChild: Text(
                'Dark',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  color: Colors.white,
                ),
              ),
              inactiveChild: Text(
                'Light',
                style: TextStyle(
                  fontSize: bodyFontSize - 2,
                  color: Colors.white,
                ),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              width: isSmallScreen ? 60.0 : 70.0,
              height: isSmallScreen ? 30.0 : 35.0,
              enabled: true,
              thumb: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  value ? Icons.dark_mode : Icons.light_mode,
                  size: isSmallScreen ? 16 : 18,
                  color: value ? AppColors.bluePrimary : AppColors.amberAccent,
                ),
              ),
              onChanged: (value) {
                switchController.value = value;
                themeController.toggleTheme();
              },
            );
          },
        ),
      )
          : const SizedBox(),
      title: OutfitText(
        text: title,
        fontSize: bodyFontSize + 3,
        fontWeight: highlightColor != null ? FontWeight.w700 : FontWeight.w500,
        color: itemColor,
      ),
      onTap: onTap,
    );
  }
}

// Make sure to add these imports at the top of the file where you use this drawer
// import 'package:teen_tigada/screens/pay_owner_page.dart';
// import 'package:teen_tigada/screens/expense_overview_page.dart';