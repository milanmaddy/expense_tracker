import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';


class PayOwnerPage extends StatefulWidget {
  const PayOwnerPage({super.key});

  @override
  State<PayOwnerPage> createState() => _PayOwnerPageState();
}

class _PayOwnerPageState extends State<PayOwnerPage>
    with TickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  final expenseController = Get.find<ExpenseController>();
  final userController = Get.find<UserController>();

  late AnimationController _animationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _cardScaleAnimation;

  // Fixed rent distribution
  final double totalRoomRent = 8300.0;
  final Map<String, double> rentDistribution = {
    'Rishav': 2650.0,
    'Maddy': 2650.0,
    'Shovan': 3000.0,
  };

  // Electricity settings - using regular double, not Rx
  double ratePerUnit = 11.0;
  double previousReading = 0.0;
  double currentReading = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _cardScaleAnimation = CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutBack,
    );

    _animationController.forward();
    _cardAnimationController.forward();

    // if (expenseController.electricityReadings.isNotEmpty) {
    //   final lastReading = expenseController.electricityReadings.first;
    //   previousReading = lastReading['currentReading'] as double;
    // }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  double get unitsConsumed => currentReading - previousReading;
  double get electricityBillTotal => unitsConsumed * ratePerUnit;
  double get electricityPerPerson =>
      electricityBillTotal / userController.roommates.length;

  double getTotalForPerson(String name) {
    final rentAmount = rentDistribution[name] ?? 0.0;
    return rentAmount + electricityPerPerson;
  }

  double get grandTotal => totalRoomRent + electricityBillTotal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor =
      isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final cardColor = isDark ? AppColors.darkSurface : Colors.white;
      final textColor =
      isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;

      return Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: isDark
                      ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
                      : [AppColors.royalBlue, AppColors.bluePrimary],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Material(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () => Get.back(),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white,
                                  size: isSmall ? 22 : 24,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutfitText(
                                  text: "Pay Owner",
                                  fontSize: isSmall ? 24 : 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: "Monthly payment breakdown",
                                  fontSize: isSmall ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: ScaleTransition(
                                  scale: _cardScaleAnimation,
                                  child: _buildGrandTotalCard(isDark, textColor, isSmall),
                                ),
                              ),
                              const SizedBox(height: 24),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: _buildElectricitySection(
                                      isDark, cardColor, textColor, subTextColor, isSmall),
                                ),
                              ),
                              const SizedBox(height: 24),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OutfitText(
                                      text: "Fixed Expenses",
                                      fontSize: isSmall ? 20 : 22,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFixedExpenseCard(
                                      "Room Rent",
                                      totalRoomRent,
                                      Icons.home_rounded,
                                      isDark, cardColor, textColor, subTextColor, isSmall,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildFixedExpenseCard(
                                      "Electricity Bill",
                                      electricityBillTotal,
                                      Icons.electric_bolt_rounded,
                                      isDark, cardColor, textColor, subTextColor, isSmall,
                                      subtitle: "${unitsConsumed.toStringAsFixed(1)} units × ₹${ratePerUnit.toStringAsFixed(0)}",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OutfitText(
                                      text: "Individual Breakdown",
                                      fontSize: isSmall ? 20 : 22,
                                      fontWeight: FontWeight.w700,
                                      color: textColor,
                                    ),
                                    const SizedBox(height: 16),
                                    ..._buildMemberBreakdown(
                                        isDark, cardColor, textColor, subTextColor, isSmall),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: currentReading > previousReading
            ? ScaleTransition(
          scale: _cardScaleAnimation,
          child: FloatingActionButton.extended(
            onPressed: () => _confirmPayment(isDark),
            backgroundColor: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
            icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
            label: OutfitText(
              text: "Confirm Payment",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        )
            : null,
      );
    });
  }

  Widget _buildGrandTotalCard(bool isDark, Color textColor, bool isSmall) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.blueDarkPrimary, AppColors.blueDarkPrimary.withOpacity(0.7)]
              : [AppColors.bluePrimary, AppColors.royalBlue],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: Colors.white,
                  size: isSmall ? 24 : 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutfitText(
                  text: "Total Payment to Owner",
                  fontSize: isSmall ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween(begin: 0.0, end: grandTotal),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return OutfitText(
                text: "₹${value.toStringAsFixed(2)}",
                fontSize: isSmall ? 36 : 42,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              );
            },
          ),
          const SizedBox(height: 8),
          OutfitText(
            text: "Due this month",
            fontSize: isSmall ? 13 : 14,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  Widget _buildElectricitySection(
      bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.brightYellowDark : AppColors.brightYellow).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.electric_meter_rounded,
                  color: isDark ? AppColors.brightYellowDark : AppColors.brightYellow,
                  size: isSmall ? 22 : 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutfitText(
                  text: "Electricity Meter Reading",
                  fontSize: isSmall ? 18 : 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          OutfitText(
            text: "Previous Reading",
            fontSize: isSmall ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: subTextColor,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: textColor, fontSize: isSmall ? 15 : 16, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: "Enter previous reading",
              hintStyle: TextStyle(color: subTextColor.withOpacity(0.5)),
              filled: true,
              fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixText: "units",
              suffixStyle: TextStyle(color: subTextColor, fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                previousReading = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 16),
          OutfitText(
            text: "Current Reading",
            fontSize: isSmall ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: subTextColor,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: textColor, fontSize: isSmall ? 15 : 16, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: "Enter current reading",
              hintStyle: TextStyle(color: subTextColor.withOpacity(0.5)),
              filled: true,
              fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixText: "units",
              suffixStyle: TextStyle(color: subTextColor, fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                currentReading = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 16),
          OutfitText(
            text: "Rate per Unit",
            fontSize: isSmall ? 13 : 14,
            fontWeight: FontWeight.w600,
            color: subTextColor,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: ratePerUnit.toString()),
            style: TextStyle(color: textColor, fontSize: isSmall ? 15 : 16, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: "Enter rate per unit",
              hintStyle: TextStyle(color: subTextColor.withOpacity(0.5)),
              filled: true,
              fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              prefixText: "₹",
              prefixStyle: TextStyle(color: textColor, fontWeight: FontWeight.w700),
              suffixText: "/ unit",
              suffixStyle: TextStyle(color: subTextColor, fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              setState(() {
                ratePerUnit = double.tryParse(value) ?? 11.0;
              });
            },
          ),
          if (currentReading > previousReading) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (isDark ? AppColors.brightGreenDark : AppColors.brightGreen).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (isDark ? AppColors.brightGreenDark : AppColors.brightGreen).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutfitText(
                          text: "Units Consumed",
                          fontSize: isSmall ? 12 : 13,
                          fontWeight: FontWeight.w500,
                          color: subTextColor,
                        ),
                        const SizedBox(height: 4),
                        OutfitText(
                          text: "${unitsConsumed.toStringAsFixed(1)} units",
                          fontSize: isSmall ? 16 : 18,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        OutfitText(
                          text: "Total Bill",
                          fontSize: isSmall ? 12 : 13,
                          fontWeight: FontWeight.w500,
                          color: subTextColor,
                        ),
                        const SizedBox(height: 4),
                        OutfitText(
                          text: "₹${electricityBillTotal.toStringAsFixed(2)}",
                          fontSize: isSmall ? 16 : 18,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.brightGreenDark : AppColors.brightGreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFixedExpenseCard(
      String title,
      double amount,
      IconData icon,
      bool isDark,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      bool isSmall, {
        String? subtitle,
      }) {
    final color = isDark ? AppColors.brightBlueDark : AppColors.brightBlue;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: isSmall ? 22 : 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutfitText(
                  text: title,
                  fontSize: isSmall ? 15 : 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  OutfitText(
                    text: subtitle,
                    fontSize: isSmall ? 12 : 13,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ],
              ],
            ),
          ),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: amount),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return OutfitText(
                text: "₹${value.toStringAsFixed(2)}",
                fontSize: isSmall ? 16 : 17,
                fontWeight: FontWeight.w700,
                color: textColor,
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMemberBreakdown(
      bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    return userController.roommates.asMap().entries.map((entry) {
      final index = entry.key;
      final roommate = entry.value;
      final name = roommate.name ?? 'Unknown';
      final rentAmount = rentDistribution[name] ?? 0.0;
      final total = getTotalForPerson(name);
      final color = AppColors.getRandomColor(isDark, index + 1);

      return TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 400 + (index * 100)),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: isSmall ? 40 : 44,
                          height: isSmall ? 40 : 44,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: roommate.profileUrl != null
                                ? Image.network(
                              roommate.profileUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.person,
                                size: isSmall ? 22 : 24,
                                color: color,
                              ),
                            )
                                : Icon(Icons.person, size: isSmall ? 22 : 24, color: color),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OutfitText(
                                text: name,
                                fontSize: isSmall ? 16 : 17,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                              const SizedBox(height: 4),
                              OutfitText(
                                text: "Total to pay",
                                fontSize: isSmall ? 12 : 13,
                                fontWeight: FontWeight.w500,
                                color: subTextColor,
                              ),
                            ],
                          ),
                        ),
                        OutfitText(
                          text: "₹${total.toStringAsFixed(2)}",
                          fontSize: isSmall ? 18 : 20,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.brightGreenDark : AppColors.brightGreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutfitText(
                                text: "Room Rent",
                                fontSize: isSmall ? 13 : 14,
                                fontWeight: FontWeight.w500,
                                color: subTextColor,
                              ),
                              OutfitText(
                                text: "₹${rentAmount.toStringAsFixed(2)}",
                                fontSize: isSmall ? 13 : 14,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutfitText(
                                text: "Electricity",
                                fontSize: isSmall ? 13 : 14,
                                fontWeight: FontWeight.w500,
                                color: subTextColor,
                              ),
                              OutfitText(
                                text: "₹${electricityPerPerson.toStringAsFixed(2)}",
                                fontSize: isSmall ? 13 : 14,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  void _confirmPayment(bool isDark) {
    if (currentReading <= previousReading) {
      Get.snackbar(
        'Invalid Reading',
        'Current reading must be greater than previous reading',
        backgroundColor: isDark ? AppColors.redDarkError : AppColors.redError,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
        borderRadius: 12,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    Get.dialog(
      Dialog(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.brightGreenDark : AppColors.brightGreen).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 48,
                  color: isDark ? AppColors.brightGreenDark : AppColors.brightGreen,
                ),
              ),
              const SizedBox(height: 20),
              OutfitText(
                text: "Confirm Payment Record",
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
              ),
              const SizedBox(height: 12),
              OutfitText(
                text: "This will record the electricity reading and add it to expenses.",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.greyDarkText : AppColors.greyText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow("Units Consumed", "${unitsConsumed.toStringAsFixed(1)} units", isDark),
                    const SizedBox(height: 8),
                    _buildSummaryRow("Electricity Bill", "₹${electricityBillTotal.toStringAsFixed(2)}", isDark),
                    const SizedBox(height: 8),
                    Divider(color: (isDark ? Colors.white : Colors.black).withOpacity(0.1)),
                    const SizedBox(height: 8),
                    _buildSummaryRow("Total to Owner", "₹${grandTotal.toStringAsFixed(2)}", isDark, isTotal: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(
                          color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: OutfitText(
                        text: "Cancel",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // expenseController.addFixedExpenseWithElectricity(
                        //   name: "Room Rent + Electricity",
                        //   roomRent: totalRoomRent,
                        //   fromReading: previousReading,
                        //   toReading: currentReading,
                        //   ratePerUnit: ratePerUnit,
                        //   recordedBy: userController.currentUser.value.name ?? 'User',
                        //   notes: "Monthly payment to owner - Rent: ₹${totalRoomRent.toStringAsFixed(2)}, Electricity: ₹${electricityBillTotal.toStringAsFixed(2)}",
                        // );

                        Get.back();
                        Get.back();

                        Get.snackbar(
                          'Payment Recorded',
                          'Fixed expenses have been added successfully',
                          backgroundColor: isDark ? AppColors.brightGreenDark : AppColors.brightGreen,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(20),
                          borderRadius: 12,
                          icon: const Icon(Icons.check_circle, color: Colors.white),
                          duration: const Duration(seconds: 3),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: OutfitText(
                        text: "Confirm",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutfitText(
          text: label,
          fontSize: isTotal ? 15 : 14,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          color: isDark
              ? (isTotal ? AppColors.textDarkSecondary : AppColors.greyDarkText)
              : (isTotal ? AppColors.textSecondary : AppColors.greyText),
        ),
        OutfitText(
          text: value,
          fontSize: isTotal ? 16 : 14,
          fontWeight: FontWeight.w700,
          color: isDark
              ? (isTotal ? AppColors.brightGreenDark : AppColors.textDarkSecondary)
              : (isTotal ? AppColors.brightGreen : AppColors.textSecondary),
        ),
      ],
    );
  }
}