import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/routes/app_routes.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:intl/intl.dart';
import 'package:teen_tigada/models/expense_model.dart';

/// CLAUDE AI GENERATED CODE - DO NOT MODIFY BY HAND

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> with SingleTickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  final expenseController = Get.find<ExpenseController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final expenseDate = DateTime(date.year, date.month, date.day);

    if (expenseDate == today) {
      return 'Today';
    } else if (expenseDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  Map<String, List<ExpenseModel>> get groupedExpenses {
    final Map<String, List<ExpenseModel>> grouped = {};

    for (var expense in expenseController.expenses) {
      final dateKey = _getDateLabel(expense.time);
      grouped.putIfAbsent(dateKey, () => []).add(expense);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;
      final cardColor = isDark ? AppColors.darkSurface : Colors.white;

      final grouped = groupedExpenses;
      final dateKeys = grouped.keys.toList();

      return Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            // Gradient background
            Container(
              height: size.height * 0.22,
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
                  // Header
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OutfitText(
                                  text: "Expense Summary",
                                  fontSize: isSmall ? 24 : 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: "${expenseController.expenses.length} transactions",
                                  fontSize: isSmall ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                          Material(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () {
                                // Filter action
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.filter_list_rounded,
                                  color: Colors.white,
                                  size: isSmall ? 22 : 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expense List
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: expenseController.expenses.isEmpty
                          ? _buildEmptyState(textColor, subTextColor, isSmall)
                          : FadeTransition(
                        opacity: _fadeAnimation,
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 80),
                          itemCount: dateKeys.length,
                          itemBuilder: (context, index) {
                            final dateKey = dateKeys[index];
                            final dayExpenses = grouped[dateKey]!;
                            final dayTotal = dayExpenses.fold<double>(
                              0.0,
                                  (sum, expense) => sum + expense.amount,
                            );

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date Header
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12, top: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutfitText(
                                        text: dateKey,
                                        fontSize: isSmall ? 16 : 18,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                      OutfitText(
                                        text: '₹${dayTotal.toStringAsFixed(2)}',
                                        fontSize: isSmall ? 16 : 18,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.redDarkError
                                            : AppColors.redError,
                                      ),
                                    ],
                                  ),
                                ),

                                // Expenses
                                ...dayExpenses.map((expense) =>
                                    _buildExpenseItem(
                                      expense,
                                      isDark,
                                      textColor,
                                      subTextColor,
                                      cardColor,
                                      isSmall,
                                    )
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ScaleTransition(
          scale: _fadeAnimation,
          child: FloatingActionButton(
            heroTag: "addExpenseFab",
            onPressed: () => Get.toNamed(AppRoute.addExpense),
            backgroundColor: isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary,
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      );
    });
  }

  Widget _buildExpenseItem(
      ExpenseModel expense,
      bool isDark,
      Color textColor,
      Color subTextColor,
      Color cardColor,
      bool isSmall,
      ) {
    final color = AppColors.getRandomColor(isDark, expense.colorIndex);
    final amountColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;

    // Create subtitle with split information
    String subtitle = expense.itemName;
    // expense.splitWith.isEmpty
    //     ? 'Personal expense'
    //     : 'Split with ${expense.splitWith.join(', ')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        child: InkWell(
          onTap: () {
            // Show expense details
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: isSmall ? 40 : 44,
                  height: isSmall ? 40 : 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      expense.categoryIcon,
                      height: isSmall ? 20 : 22,
                      width: isSmall ? 20 : 22,
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutfitText(
                        text: expense.categoryName,
                        fontSize: isSmall ? 16 : 17,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                      const SizedBox(height: 4),
                      OutfitText(
                        text: "$subtitle • by ${expense.addedBy.name ?? 'Unknown'}",
                        fontSize: isSmall ? 12 : 13,
                        fontWeight: FontWeight.w500,
                        color: subTextColor,
                      ),
                    ],
                  ),
                ),

                // Amount and time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OutfitText(
                      text: '₹${expense.amount.toStringAsFixed(2)}',
                      fontSize: isSmall ? 14 : 15,
                      fontWeight: FontWeight.w700,
                      color: amountColor,
                    ),
                    const SizedBox(height: 4),
                    OutfitText(
                      text: DateFormat('hh:mm a').format(expense.time),
                      fontSize: isSmall ? 11 : 12,
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

  Widget _buildEmptyState(Color textColor, Color subTextColor, bool isSmall) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: subTextColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: isSmall ? 48 : 56,
                color: subTextColor,
              ),
            ),
            const SizedBox(height: 24),
            OutfitText(
              text: 'No Expenses Yet',
              fontSize: isSmall ? 20 : 22,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            const SizedBox(height: 8),
            OutfitText(
              text: 'Add your first expense to get started',
              fontSize: isSmall ? 14 : 15,
              fontWeight: FontWeight.w400,
              color: subTextColor,
            ),
          ],
        ),
      ),
    );
  }
}