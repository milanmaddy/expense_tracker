import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:one_clock/one_clock.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:teen_tigada/controllers/home_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/models/user_model.dart';
import 'package:teen_tigada/routes/app_routes.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';
import 'package:teen_tigada/utils/image_const.dart';
import 'package:teen_tigada/widgets/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:teen_tigada/models/expense_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();
  final expenseController = Get.find<ExpenseController>();
  final themeController = Get.find<ThemeController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  String _formatDateWithDay() {
    final now = DateTime.now();
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${dayNames[now.weekday - 1]}, ${monthNames[now.month - 1]} ${now.day}, ${now.year}';
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final period = now.hour < 12 ? 'AM' : 'PM';

    setState(() {
      _currentTime = '$hour:$minute:$second $period';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: bgColor,
        drawer: CustomDrawer(
          isDarkTheme: isDark,
          textColor: textColor,
          subTextColor: subTextColor,
          padding: 20.0,
          bodyFontSize: isSmallScreen ? 12.0 : 14.0,
          isSmallScreen: isSmallScreen,
        ),
        body: Stack(
          children: [
            _buildGradientBackground(isDark),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _buildHeader(size, isDark, isSmallScreen),
                  _buildContent(isDark, textColor, subTextColor, isSmallScreen),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ScaleTransition(
          scale: _fadeAnimation,
          child: FloatingActionButton(
            heroTag: "homeFab",
            onPressed: () => Get.toNamed(AppRoute.addExpense),
            backgroundColor: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      );
    });
  }

  Widget _buildGradientBackground(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: isDark
              ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
              : [AppColors.royalBlue, AppColors.bluePrimary],
        ),
      ),
    );
  }

  Widget _buildHeader(Size size, bool isDark, bool isSmall) {
    final totalExpense = expenseController.getTotalAmount();
    final currentUserShare = _calculateUserShare();

    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(isDark, isSmall),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutfitText(
                    text: _formatDateWithDay(),
                    fontSize: isSmall ? 19 : 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  OutfitText(
                    text: _currentTime,
                    fontSize: isSmall ? 19 : 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ],
              ),
              const Spacer(),
              _buildExpenseOverview(totalExpense, currentUserShare, isSmall),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateUserShare() {
    final currentUserName = userController.currentUser.value.name;
    double share = 0.0;

    for (var expense in expenseController.expenses) {
      if (expense.addedBy.name == currentUserName) {
        share += expense.amount;
      }
      if (expense.splitWith.contains(currentUserName)) {
        share += expense.splitAmount;
      }
    }

    return share;
  }

  Widget _buildAppBar(bool isDark, bool isSmall) {
    return Row(
      children: [
        _buildIconButton(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          icon: AppAssets.menu,
          size: isSmall ? 24 : 28,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: OutfitText(
            text: "Hi ${userController.currentUser.value.name ?? 'User'}!",
            fontSize: isSmall ? 24 : 26,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        _buildIconButton(
          onTap: () {},
          icon: AppAssets.notification,
          size: isSmall ? 24 : 28,
        ),
      ],
    );
  }

  Widget _buildIconButton({required VoidCallback onTap, required String icon, required double size}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            icon,
            height: size,
            width: size,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseOverview(double totalExpense, double userShare, bool isSmall) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildExpenseColumn("Total Expense", totalExpense.toStringAsFixed(2), CrossAxisAlignment.start, isSmall),
          ),
          Container(
            height: 60,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: _buildExpenseColumn("Your Share", userShare.toStringAsFixed(2), CrossAxisAlignment.end, isSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseColumn(String title, String amount, CrossAxisAlignment align, bool isSmall) {
    return Column(
      crossAxisAlignment: align,
      children: [
        OutfitText(
          text: title,
          fontSize: isSmall ? 14 : 16,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(height: 8),
        RandomTextReveal(
          text: "₹${(double.tryParse(amount) ?? 0.0).toStringAsFixed(2)}",
          initialText: '₹0000.00',
          shouldPlayOnStart: true,
          duration: const Duration(milliseconds: 1100),
          style: GoogleFonts.outfit(
            fontSize: isSmall ? 28 : 36,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          randomString: '0123456789',
          curve: Curves.easeIn,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildContent(bool isDark, Color textColor, Color subTextColor, bool isSmall) {
    return Expanded(
      flex: 6,
      child: Container(padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(
                      title: "${homeController.currentMonth.value} Overview",
                      onViewAll: () {},
                      textColor: textColor,
                      isSmallScreen: isSmall,
                      isDarkTheme: isDark,
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryList(isDark, textColor, subTextColor, isSmall),
                    const SizedBox(height: 10),
                    _SectionHeader(
                      title: "Recent Transactions",
                      onViewAll: () {},
                      textColor: textColor,
                      isSmallScreen: isSmall,
                      isDarkTheme: isDark,
                    ),
                    // const SizedBox(height: 16),
                  ],
                ),
              ),
              _buildTransactionList(isDark, textColor, subTextColor, isSmall),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryList(bool isDark, Color textColor, Color subTextColor, bool isSmall) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10, bottom: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: userController.roommates.length,
        itemBuilder: (context, index) {
          return _RoommateCard(
            roommate: userController.roommates[index],
            expenseController: expenseController,
            isDarkTheme: isDark,
            textColor: textColor,
            subTextColor: subTextColor,
            isSmallScreen: isSmall,
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildTransactionList(bool isDark, Color textColor, Color subTextColor, bool isSmall) {
    final recentExpenses = expenseController.expenses.take(7).toList();

    return Column(
      children: List.generate(
        recentExpenses.length,
            (index) => _TransactionItem(
              expense: recentExpenses[index],
              isDarkTheme: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
              isSmallScreen: isSmall,
              index: index,
            ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;
  final Color textColor;
  final bool isSmallScreen;
  final bool isDarkTheme;

  const _SectionHeader({
    required this.title,
    required this.onViewAll,
    required this.textColor,
    required this.isSmallScreen,
    required this.isDarkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutfitText(
          text: title,
          fontSize: isSmallScreen ? 20 : 22,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        TextButton(
          onPressed: onViewAll,
          child: OutfitText(
            text: "View All",
            fontSize: isSmallScreen ? 14 : 15,
            fontWeight: FontWeight.w600,
            color: isDarkTheme ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
          ),
        ),
      ],
    );
  }
}

class _RoommateCard extends StatelessWidget {
  final UserModel roommate;
  final ExpenseController expenseController;
  final bool isDarkTheme;
  final Color textColor;
  final Color subTextColor;
  final bool isSmallScreen;
  final int index;

  const _RoommateCard({
    required this.roommate,
    required this.expenseController,
    required this.isDarkTheme,
    required this.textColor,
    required this.subTextColor,
    required this.isSmallScreen,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate what this roommate paid
    final paid = expenseController.expenses
        .where((e) => e.addedBy.name == roommate.name)
        .fold<double>(0.0, (sum, e) => sum + e.amount);

    // Calculate what this roommate owes
    final owes = expenseController.expenses
        .where((e) => e.addedBy.name != roommate.name && e.splitWith.contains(roommate.name))
        .fold<double>(0.0, (sum, e) => sum + e.splitAmount);

    // Calculate what others owe to this roommate
    final owed = expenseController.expenses
        .where((e) => e.addedBy.name == roommate.name)
        .fold<double>(0.0, (sum, e) => sum + (e.splitAmount * e.splitWith.length));

    final iconSize = isSmallScreen ? 36.0 : 40.0;
    final color = AppColors.getRandomColor(isDarkTheme, index + 1);

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: isDarkTheme? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkTheme ? 0.3 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
      child: Material(
        color: isDarkTheme ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: color.withOpacity(0.1),

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: roommate.profileUrl != null
                            ? Image.network(
                          roommate.profileUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(Icons.person, size: iconSize * 0.6, color: color),
                        )
                            : Icon(Icons.person, size: iconSize * 0.6, color: color),
                      ),
                    ),
                    OutfitText(
                      text: "₹${paid.toStringAsFixed(0)}",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                OutfitText(
                  text: roommate.name ?? 'Unknown',
                  fontSize: isSmallScreen ? 15 : 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                const SizedBox(height: 4),
                OutfitText(
                  text: "Owes: ₹${owes.toStringAsFixed(0)}",
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkTheme ? AppColors.brightRedDark : AppColors.brightRed,
                ),
                const Spacer(),
                OutfitText(
                  text: "Owed: ₹${owed.toStringAsFixed(0)}",
                  fontSize: isSmallScreen ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkTheme ? AppColors.brightGreenDark : AppColors.brightGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final ExpenseModel expense;
  final bool isDarkTheme;
  final Color textColor;
  final Color subTextColor;
  final bool isSmallScreen;
  final int index;

  const _TransactionItem({
    required this.expense,
    required this.isDarkTheme,
    required this.textColor,
    required this.subTextColor,
    required this.isSmallScreen,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getRandomColor(isDarkTheme, expense.colorIndex);
    final iconSize = isSmallScreen ? 40.0 : 44.0;
    final amountColor = isDarkTheme ? AppColors.textDarkSecondary : AppColors.textSecondary;

    final subtitle = expense.itemName;
    // expense.splitWith.isEmpty
    //     ? 'Personal expense'
    //     : 'Split with ${expense.splitWith.join(', ')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDarkTheme? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkTheme ? 0.3 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        // color: isDarkTheme ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      expense.categoryIcon,
                      height: iconSize * 0.5,
                      width: iconSize * 0.5,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutfitText(
                        text: expense.categoryName,
                        fontSize: isSmallScreen ? 16 : 17,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      const SizedBox(height: 4),
                      OutfitText(
                        text: "$subtitle • by ${expense.addedBy.name ?? 'Unknown'}",
                        fontSize: isSmallScreen ? 12 : 13,
                        fontWeight: FontWeight.w500,
                        color: subTextColor,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OutfitText(
                      text: '₹${expense.amount.toStringAsFixed(0)}',
                      fontSize: isSmallScreen ? 14 : 15,
                      fontWeight: FontWeight.w700,
                      color: amountColor,
                    ),
                    const SizedBox(height: 4),
                    OutfitText(
                      text: DateFormat('hh:mm a').format(expense.time),
                      fontSize: isSmallScreen ? 12 : 13,
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final homeController = Get.find<HomeController>();
//   final userController = Get.find<UserController>();
//   final expenseController = Get.find<ExpenseController>();
//   final themeController = Get.find<ThemeController>();
//
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Timer _timer;
//   String _currentTime = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOut,
//     );
//     _controller.forward();
//     _updateTime();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _timer.cancel();
//     super.dispose();
//   }
//
//   void _updateTime() {
//     final now = DateTime.now();
//     final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
//     final minute = now.minute.toString().padLeft(2, '0');
//     final period = now.hour < 12 ? 'AM' : 'PM';
//     setState(() => _currentTime = '$hour:$minute $period');
//   }
//
//   String _formatDate() {
//     final now = DateTime.now();
//     return DateFormat('EEE, MMM d').format(now);
//   }
//
//   double _calculateUserShare() {
//     final currentUserName = userController.currentUser.value.name;
//     double share = 0.0;
//     for (var expense in expenseController.expenses) {
//       if (expense.addedBy.name == currentUserName) {
//         share += expense.amount;
//       }
//       if (expense.splitWith.contains(currentUserName)) {
//         share += expense.splitAmount;
//       }
//     }
//     return share;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isSmall = size.width < 600;
//
//     return Obx(() {
//       final isDark = themeController.isDarkMode.value;
//       final theme = _ThemeData(isDark: isDark);
//
//       return Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: theme.bgColor,
//         drawer: CustomDrawer(
//           isDarkTheme: isDark,
//           textColor: theme.textColor,
//           subTextColor: theme.subTextColor,
//           padding: 20.0,
//           bodyFontSize: isSmall ? 12.0 : 14.0,
//           isSmallScreen: isSmall,
//         ),
//         body: Column(
//           children: [
//             _buildHeader(theme, isSmall),
//             Expanded(child: _buildContent(theme, isSmall)),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           heroTag: "homeFab",
//           onPressed: () => Get.toNamed(AppRoute.addExpense),
//           backgroundColor: theme.primaryColor,
//           child: const Icon(Icons.add, color: Colors.white, size: 28),
//         ),
//       );
//     });
//   }
//
//   Widget _buildHeader(_ThemeData theme, bool isSmall) {
//     final totalExpense = expenseController.getTotalAmount();
//     final userShare = _calculateUserShare();
//
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.primaryColor,
//         borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: EdgeInsets.all(isSmall ? 20 : 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   _buildIconButton(
//                     onTap: () => _scaffoldKey.currentState?.openDrawer(),
//                     icon: AppAssets.menu,
//                     size: isSmall ? 24 : 26,
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: OutfitText(
//                       text: "Hi ${userController.currentUser.value.name}!",
//                       fontSize: isSmall ? 20 : 24,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                   _buildIconButton(
//                     onTap: () {},
//                     icon: AppAssets.notification,
//                     size: isSmall ? 24 : 26,
//                   ),
//                 ],
//               ),
//               SizedBox(height: isSmall ? 20 : 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   OutfitText(
//                     text: _formatDate(),
//                     fontSize: isSmall ? 14 : 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                   OutfitText(
//                     text: _currentTime,
//                     fontSize: isSmall ? 14 : 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white.withOpacity(0.9),
//                   ),
//                 ],
//               ),
//               SizedBox(height: isSmall ? 24 : 32),
//               _buildExpenseCard(totalExpense, userShare, isSmall),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconButton({required VoidCallback onTap, required String icon, required double size}) {
//     return Material(
//       color: Colors.white.withOpacity(0.2),
//       borderRadius: BorderRadius.circular(12),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: SvgPicture.asset(
//             icon,
//             height: size,
//             width: size,
//             colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildExpenseCard(double total, double share, bool isSmall) {
//     return Container(
//       padding: EdgeInsets.all(isSmall ? 20 : 24),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           Expanded(child: _buildExpenseValue("Total Expense", total, isSmall)),
//           Container(
//             height: 50,
//             width: 1,
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             color: Colors.white.withOpacity(0.3),
//           ),
//           Expanded(child: _buildExpenseValue("Your Share", share, isSmall, align: CrossAxisAlignment.end)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildExpenseValue(String label, double amount, bool isSmall, {CrossAxisAlignment align = CrossAxisAlignment.start}) {
//     return Column(
//       crossAxisAlignment: align,
//       children: [
//         OutfitText(
//           text: label,
//           fontSize: isSmall ? 12 : 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.white.withOpacity(0.85),
//         ),
//         const SizedBox(height: 8),
//         RandomTextReveal(
//           text: "₹${amount.toStringAsFixed(2)}",
//           initialText: '₹0000.00',
//           shouldPlayOnStart: true,
//           duration: const Duration(milliseconds: 1000),
//           style: GoogleFonts.outfit(
//             fontSize: isSmall ? 24 : 28,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//           randomString: '0123456789',
//           curve: Curves.easeOut,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContent(_ThemeData theme, bool isSmall) {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Container(
//         color: theme.bgColor,
//         child: CustomScrollView(
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             SliverPadding(
//               padding: EdgeInsets.fromLTRB(
//                 isSmall ? 16 : 20,
//                 isSmall ? 20 : 24,
//                 isSmall ? 16 : 20,
//                 0,
//               ),
//               sliver: SliverToBoxAdapter(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _SectionHeader(
//                       title: "${homeController.currentMonth.value} Overview",
//                       onViewAll: () {},
//                       theme: theme,
//                       isSmall: isSmall,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildRoommatesList(theme, isSmall),
//                     const SizedBox(height: 24),
//                     _SectionHeader(
//                       title: "Recent Transactions",
//                       onViewAll: () {},
//                       theme: theme,
//                       isSmall: isSmall,
//                     ),
//                     const SizedBox(height: 12),
//                   ],
//                 ),
//               ),
//             ),
//             _buildTransactionsList(theme, isSmall),
//             const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoommatesList(_ThemeData theme, bool isSmall) {
//     return SizedBox(
//       height: isSmall ? 170 : 180,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: userController.roommates.length,
//         itemBuilder: (context, index) => _RoommateCard(
//           roommate: userController.roommates[index],
//           expenseController: expenseController,
//           theme: theme,
//           isSmall: isSmall,
//           index: index,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTransactionsList(_ThemeData theme, bool isSmall) {
//     final recent = expenseController.expenses.take(10).toList();
//     return SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: isSmall ? 16 : 20),
//       sliver: SliverList(
//         delegate: SliverChildBuilderDelegate(
//               (context, index) => _TransactionItem(
//             expense: recent[index],
//             theme: theme,
//             isSmall: isSmall,
//           ),
//           childCount: recent.length,
//         ),
//       ),
//     );
//   }
// }
//
// class _ThemeData {
//   final bool isDark;
//   _ThemeData({required this.isDark});
//
//   Color get bgColor => isDark ? AppColors.blackBackground : AppColors.backgroundFill;
//   Color get surfaceColor => isDark ? AppColors.darkSurface : Colors.white;
//   Color get textColor => isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
//   Color get subTextColor => isDark ? AppColors.greyDarkText : AppColors.greyText;
//   Color get primaryColor => isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary;
//   Color get dividerColor => isDark ? AppColors.greyDarkDivider : AppColors.greyDivider;
// }
//
// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final VoidCallback onViewAll;
//   final _ThemeData theme;
//   final bool isSmall;
//
//   const _SectionHeader({
//     required this.title,
//     required this.onViewAll,
//     required this.theme,
//     required this.isSmall,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         OutfitText(
//           text: title,
//           fontSize: isSmall ? 18 : 20,
//           fontWeight: FontWeight.w700,
//           color: theme.textColor,
//         ),
//         TextButton(
//           onPressed: onViewAll,
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           ),
//           child: OutfitText(
//             text: "View All",
//             fontSize: isSmall ? 13 : 14,
//             fontWeight: FontWeight.w600,
//             color: theme.primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _RoommateCard extends StatelessWidget {
//   final UserModel roommate;
//   final ExpenseController expenseController;
//   final _ThemeData theme;
//   final bool isSmall;
//   final int index;
//
//   const _RoommateCard({
//     required this.roommate,
//     required this.expenseController,
//     required this.theme,
//     required this.isSmall,
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final paid = expenseController.expenses
//         .where((e) => e.addedBy.name == roommate.name)
//         .fold<double>(0.0, (sum, e) => sum + e.amount);
//
//     final owes = expenseController.expenses
//         .where((e) => e.addedBy.name != roommate.name && e.splitWith.contains(roommate.name))
//         .fold<double>(0.0, (sum, e) => sum + e.splitAmount);
//
//     final owed = expenseController.expenses
//         .where((e) => e.addedBy.name == roommate.name)
//         .fold<double>(0.0, (sum, e) => sum + (e.splitAmount * e.splitWith.length));
//
//     final color = AppColors.getRandomColor(theme.isDark, index);
//
//     return Container(
//       width: isSmall ? 160 : 170,
//       margin: const EdgeInsets.only(right: 12),
//       decoration: BoxDecoration(
//         color: theme.surfaceColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(theme.isDark ? 0.2 : 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {},
//           borderRadius: BorderRadius.circular(16),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: isSmall ? 36 : 40,
//                       height: isSmall ? 36 : 40,
//                       decoration: BoxDecoration(
//                         color: color.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: ClipOval(
//                         child: roommate.profileUrl != null
//                             ? Image.network(
//                           roommate.profileUrl!,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => Icon(
//                             Icons.person,
//                             size: isSmall ? 20 : 22,
//                             color: color,
//                           ),
//                         )
//                             : Icon(
//                           Icons.person,
//                           size: isSmall ? 20 : 22,
//                           color: color,
//                         ),
//                       ),
//                     ),
//                     OutfitText(
//                       text: "₹${paid.toStringAsFixed(0)}",
//                       fontSize: isSmall ? 14 : 15,
//                       fontWeight: FontWeight.w700,
//                       color: theme.textColor,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 OutfitText(
//                   text: roommate.name ?? 'Unknown',
//                   fontSize: isSmall ? 14 : 15,
//                   fontWeight: FontWeight.w600,
//                   color: theme.textColor,
//                 ),
//                 const Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     OutfitText(
//                       text: "Owes",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: theme.subTextColor,
//                     ),
//                     OutfitText(
//                       text: "₹${owes.toStringAsFixed(0)}",
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: theme.isDark ? AppColors.brightRedDark : AppColors.brightRed,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     OutfitText(
//                       text: "Owed",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: theme.subTextColor,
//                     ),
//                     OutfitText(
//                       text: "₹${owed.toStringAsFixed(0)}",
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                       color: theme.isDark ? AppColors.brightGreenDark : AppColors.brightGreen,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _TransactionItem extends StatelessWidget {
//   final ExpenseModel expense;
//   final _ThemeData theme;
//   final bool isSmall;
//
//   const _TransactionItem({
//     required this.expense,
//     required this.theme,
//     required this.isSmall,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final color = AppColors.getRandomColor(theme.isDark, expense.colorIndex);
//     final subtitle = expense.splitWith.isEmpty
//         ? 'Personal'
//         : 'Split • ${expense.addedBy.name}';
//
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: theme.surfaceColor,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(theme.isDark ? 0.2 : 0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {},
//           borderRadius: BorderRadius.circular(14),
//           child: Padding(
//             padding: const EdgeInsets.all(14),
//             child: Row(
//               children: [
//                 Container(
//                   width: isSmall ? 40 : 44,
//                   height: isSmall ? 40 : 44,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       expense.categoryIcon,
//                       height: isSmall ? 20 : 22,
//                       width: isSmall ? 20 : 22,
//                       colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       OutfitText(
//                         text: expense.itemName,
//                         fontSize: isSmall ? 15 : 16,
//                         fontWeight: FontWeight.w600,
//                         color: theme.textColor,
//                       ),
//                       const SizedBox(height: 3),
//                       OutfitText(
//                         text: subtitle,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: theme.subTextColor,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     OutfitText(
//                       text: '₹${expense.amount.toStringAsFixed(0)}',
//                       fontSize: isSmall ? 15 : 16,
//                       fontWeight: FontWeight.w700,
//                       color: theme.isDark ? AppColors.redDarkError : AppColors.redError,
//                     ),
//                     const SizedBox(height: 3),
//                     OutfitText(
//                       text: DateFormat('hh:mm a').format(expense.time),
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: theme.subTextColor,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }