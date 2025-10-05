import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';
import 'package:teen_tigada/utils/image_const.dart';
import 'package:teen_tigada/widgets/custom_appbar.dart';
import 'package:teen_tigada/widgets/custom_button.dart';
import 'package:teen_tigada/widgets/custom_textfield.dart';

import '../../models/user_model.dart';

///CLAUDE AI GENERATED CODE - DO NOT MODIFY BY HAND

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> with SingleTickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  final userController = Get.find<UserController>();
  final expenseController = Get.find<ExpenseController>();

  final dateController = EasyInfiniteDateTimelineController();
  final itemNameController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();
  final newCategoryController = TextEditingController();

  final selectedCategory = 'Food'.obs;
  final selectedRoommates = <UserModel>[].obs;
  final showNewCategoryField = false.obs;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  // late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    // slideAnimation = Tween<Offset>(
    //   begin: const Offset(0, 0.3),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: Curves.easeOutCubic,
    // ));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    itemNameController.dispose();
    amountController.dispose();
    notesController.dispose();
    newCategoryController.dispose();
    super.dispose();
  }

  Widget _buildDatePicker(
      BuildContext context,
      bool isDarkTheme,
      Color cardBackgroundColor,
      Color subTextColor,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: EasyInfiniteDateTimeLine(
        controller: dateController,
        firstDate: DateTime(2020, 1, 1),
        lastDate: DateTime(2030, 12, 31),
        focusDate: expenseController.selectedDate.value,
        dayProps: EasyDayProps(
          todayHighlightStyle: TodayHighlightStyle.withBorder,
          todayStyle: DayStyle(
            dayNumStyle: TextStyle(
              color: subTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            dayStrStyle: TextStyle(
              color: subTextColor.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          todayHighlightColor: isDarkTheme
              ? AppColors.blueDarkPrimary
              : AppColors.bluePrimary,
          height: 90,
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            dayNumStyle: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
            dayStrStyle: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            monthStrStyle: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            decoration: BoxDecoration(
              color: isDarkTheme
                  ? AppColors.blueDarkPrimary
                  : AppColors.bluePrimary,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          inactiveDayStyle: DayStyle(
            monthStrStyle: TextStyle(
              color: subTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            decoration: const BoxDecoration(border: null),
            dayNumStyle: TextStyle(
              color: subTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
            dayStrStyle: TextStyle(
              color: subTextColor.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onDateChange: (selected) {
          expenseController.selectedDate.value = selected;
        },
        headerBuilder: (ctx, datetime) {
          final formattedDate = DateFormat.yMMMd().format(datetime);
          return Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: OutfitText(
                text: formattedDate.toString(),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkTheme
                    ? AppColors.textDarkSecondary
                    : AppColors.textSecondary,
              ),
            ),
          );
        },
        selectionMode: const SelectionMode.autoCenter(),
        physics: const BouncingScrollPhysics(),
        locale: 'en',
      ),
    );
  }

  Widget _buildCategoryDropdown(bool isDark, Color textColor) {
    final primaryColor = isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary;
    final fillColor = isDark
        ? AppColors.blackBackground.withOpacity(0.3)
        : AppColors.backgroundFill;

    return Obx(
          () => Container(
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedCategory.value,
          padding: EdgeInsets.zero,
          decoration: InputDecoration(
            labelText: "Select Category",
            labelStyle: GoogleFonts.outfit(
              color: isDark
                  ? AppColors.greyDarkText.withOpacity(0.75)
                  : AppColors.greyText.withOpacity(0.75),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            floatingLabelStyle: GoogleFonts.outfit(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            // contentPadding: const EdgeInsets.symmetric(
            //   horizontal: 16,
            //   vertical: 16,
            // ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            filled: true,
            fillColor: fillColor,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: primaryColor,
            size: 24,
          ),
          isExpanded: true,
          items: expenseController.categories.map((category) {
            return DropdownMenuItem<String>(
              value: category['name'],
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.getRandomColor(
                        isDark,
                        category['colorIndex'],
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      category['icon'],
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.getRandomColor(
                          isDark,
                          category['colorIndex'],
                        ),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutfitText(
                    text: category['name'],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              selectedCategory.value = value;
              showNewCategoryField.value = value == 'Other';
              if (value != 'Other') newCategoryController.clear();
            }
          },
          dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          menuMaxHeight: 300,
        ),
      ),
    );
  }

  Widget _buildRoommateCard(UserModel roommate, bool isDark, Color textColor) {
    final isSelected = selectedRoommates.contains(roommate);
    final primaryColor = isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(
        //   color: isSelected ? primaryColor : Colors.transparent,
        //   width: 2,
        // ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isSelected) {
              selectedRoommates.remove(roommate);
            } else {
              selectedRoommates.add(roommate);
            }
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.getRandomColor(
                      isDark,
                      roommate.name.hashCode % 10,
                    ).withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: roommate.profileUrl != null
                        ? Image.network(
                      roommate.profileUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.person,
                        color: AppColors.getRandomColor(
                          isDark,
                          roommate.name.hashCode % 10,
                        ),
                        size: 24,
                      ),
                    )
                        : Icon(
                      Icons.person,
                      color: AppColors.getRandomColor(
                        isDark,
                        roommate.name.hashCode % 10,
                      ),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutfitText(
                    text: roommate.name ?? 'Unknown',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? primaryColor
                          : (isDark
                          ? AppColors.greyDarkText
                          : AppColors.greyText),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isSelected
                      ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleAddExpense(bool isDark) {
    if (itemNameController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedRoommates.isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please fill all fields and select roommates',
        backgroundColor: isDark ? AppColors.redDarkError : AppColors.redError,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    final amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: isDark ? AppColors.redDarkError : AppColors.redError,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    String category = selectedCategory.value;
    if (category == 'Other' && newCategoryController.text.isNotEmpty) {
      // expenseController.addCategory(newCategoryController.text);
      category = newCategoryController.text;
    }

    expenseController.addExpense(
      itemName: itemNameController.text,
      amount: amount,
      category: category,
      roommates: selectedRoommates.map((r) => r.name!).toList(),
      notes: notesController.text,
      paidBy: userController.currentUser.value.name!,
    );

    Get.back();
    Get.snackbar(
      'Success',
      'Expense added successfully',
      backgroundColor: isDark ? AppColors.greenDarkSuccess : AppColors.greenSuccess,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final cardColor = isDark ? AppColors.darkSurface : Colors.white;
      final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;

      return Scaffold(
        backgroundColor: bgColor,
        appBar: CustomAppBar(title: "Add Expense", subtitle: "Split expenses with roommates",),
        body: Stack(
          children: [
            // Gradient Background
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
              child:
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: isDark
                      ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
                      : [AppColors.royalBlue, AppColors.bluePrimary],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: SingleChildScrollView(
                      // physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date Picker
                          _buildDatePicker(context, isDark, cardColor, subTextColor),

                          const SizedBox(height: 24),

                          // Amount & Item Name
                          OutfitText(
                            text: "Expense Details",
                            fontSize: isSmall ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            controller: amountController,
                            labelText: "Amount",
                            hintText: "₹ 0.00",
                            keyboardType: TextInputType.number,
                            // prefixSvgAsset: '',
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            controller: itemNameController,
                            labelText: "Item Name",
                            hintText: "e.g., Groceries",
                          ),

                          const SizedBox(height: 24),

                          // Category
                          OutfitText(
                            text: "Category",
                            fontSize: isSmall ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                          const SizedBox(height: 16),

                          _buildCategoryDropdown(isDark, textColor),

                          if (showNewCategoryField.value) ...[
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: newCategoryController,
                              labelText: "New Category Name",
                              hintText: "e.g., Entertainment",
                            ),
                          ],

                          const SizedBox(height: 24),

                          // Roommates
                          OutfitText(
                            text: "Split With",
                            fontSize: isSmall ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                          const SizedBox(height: 4),
                          OutfitText(
                            text: "Select roommates to split this expense",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: subTextColor,
                          ),
                          const SizedBox(height: 16),

                          Obx(() => Column(
                            children: userController.roommates
                                .map((roommate) => _buildRoommateCard(
                              roommate,
                              isDark,
                              textColor,
                            ))
                                .toList(),
                          )),

                          const SizedBox(height: 24),

                          // Notes
                          OutfitText(
                            text: "Notes (Optional)",
                            fontSize: isSmall ? 18 : 20,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            controller: notesController,
                            labelText: "Notes",
                            hintText: "Add additional details...",
                            maxLines: 3,
                          ),

                          const SizedBox(height: 32),

                          // Add Button
                          CustomButton(
                            text: "Add Expense",
                            onTap: () => handleAddExpense(isDark),
                            leadingIcon: const Icon(Icons.add_rounded),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}