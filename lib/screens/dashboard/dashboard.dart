import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:teen_tigada/controllers/home_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/models/user_model.dart';
import 'package:teen_tigada/screens/expense_overview/expense_overview.dart';
import 'package:teen_tigada/screens/expense/expense_summary.dart';
import 'package:teen_tigada/screens/home/home.dart';
import 'package:teen_tigada/screens/profile/profile.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';
import 'package:teen_tigada/widgets/custom_appbar.dart';
import 'package:teen_tigada/widgets/custom_textfield.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final PersistentTabController tabController = PersistentTabController(
    initialIndex: 0,
  );
  final homeController = Get.find<HomeController>();

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      ExpenseScreen(),
      ExpenseOverviewPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navItems(bool isDark) {
    final activeColor = isDark
        ? AppColors.blueDarkPrimary
        : AppColors.bluePrimary;
    final inactiveColor = isDark
        ? AppColors.textDarkSecondary
        : AppColors.textSecondary;

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.receipt_long),
        title: "Expense",
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bar_chart),
        title: "Statistics",
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        iconSize: 26,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: activeColor,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        iconSize: 26,
      ),
    ];
  }

  void changeTab(int index) {
    if (index == homeController.currentIndex.value) {
      tabController.jumpToTab(index);
    } else {
      homeController.currentIndex.value = index;
      tabController.jumpToTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PersistentTabView(
      context,
      controller: tabController,
      screens: _buildScreens(),
      items: _navItems(isDark),
      backgroundColor: isDark
          ? AppColors.darkSurface
          : AppColors.backgroundFill,
      handleAndroidBackButtonPress: true,
      stateManagement: true,
      navBarHeight: 70,
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        colorBehindNavBar: isDark
            ? AppColors.blackBackground
            : AppColors.backgroundFill,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      // popAllScreensOnTapOfSelectedTab: true,
      // itemAnimationProperties: const ItemAnimationProperties(
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // ),
      onItemSelected: changeTab,
      navBarStyle: NavBarStyle.style10, // Modern style with centered icons
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.textDarkSecondary
        : AppColors.textSecondary;
    final bgColor = isDark
        ? AppColors.blackBackground
        : AppColors.backgroundFill;

    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutfitText(
              text: "Search",
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    (isDark ? AppColors.brightBlueDark : AppColors.brightBlue)
                        .withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black26
                        : Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: isDark
                        ? AppColors.brightBlueDark
                        : AppColors.brightBlue,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  OutfitText(
                    text: "Search Transactions",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
