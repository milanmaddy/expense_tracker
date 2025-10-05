import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teen_tigada/controllers/expense_controller.dart';
import 'package:teen_tigada/controllers/theme_controller.dart';
import 'package:teen_tigada/controllers/user_controller.dart';
import 'package:teen_tigada/utils/color_const.dart';
import 'package:teen_tigada/utils/custom_text.dart';

// class ExpenseOverviewPage extends StatefulWidget {
//   const ExpenseOverviewPage({super.key});
//
//   @override
//   State<ExpenseOverviewPage> createState() => _ExpenseOverviewPageState();
// }
//
// class _ExpenseOverviewPageState extends State<ExpenseOverviewPage>
//     with SingleTickerProviderStateMixin {
//   final themeController = Get.find<ThemeController>();
//   final expenseController = Get.find<ExpenseController>();
//   final userController = Get.find<UserController>();
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     );
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Map<String, dynamic> get statistics {
//     return expenseController.getOverviewStatistics();
//   }
//
//   List<Map<String, dynamic>> get allCategoriesWithTotals {
//     final breakdown = expenseController.getCategoryBreakdown();
//     return expenseController.categories.map((category) {
//       final categoryName = category['name'] as String;
//       final amount = breakdown[categoryName] ?? 0.0;
//       final total = expenseController.getTotalAmount();
//       return {
//         'name': categoryName,
//         'amount': amount,
//         'percentage': total > 0 ? (amount / total * 100) : 0.0,
//         'icon': category['icon'],
//         'colorIndex': category['colorIndex'],
//         'expenseCount': expenseController.expenses
//             .where((e) => e.categoryName == categoryName).length,
//       };
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isSmall = size.width < 600;
//
//     return Obx(() {
//       final isDark = themeController.isDarkMode.value;
//       final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
//       final cardColor = isDark ? AppColors.darkSurface : Colors.white;
//       final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
//       final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;
//       final stats = statistics;
//       final categories = allCategoriesWithTotals;
//
//       return Scaffold(
//         backgroundColor: bgColor,
//         body: Stack(
//           children: [
//             Container(
//               height: size.height * 0.25,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.topRight,
//                   colors: isDark
//                       ? [AppColors.blackBackground, AppColors.blueDarkPrimary]
//                       : [AppColors.royalBlue, AppColors.bluePrimary],
//                 ),
//               ),
//             ),
//             SafeArea(
//               bottom: false,
//               child: Column(
//                 children: [
//                   _buildHeader(isSmall),
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.only(top: 20),
//                       decoration: BoxDecoration(
//                         color: cardColor,
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildTotalCard(stats, isDark, isSmall),
//                             const SizedBox(height: 36),
//                             _buildSectionHeader("Spending Overview", textColor, isSmall),
//                             const SizedBox(height: 20),
//                             _buildPieChart(categories, stats['totalExpenses'], isDark, cardColor, textColor, subTextColor, isSmall),
//                             const SizedBox(height: 28),
//                             _buildSectionHeader("All Categories", textColor, isSmall),
//                             const SizedBox(height: 16),
//                             _buildCategoryList(categories, isDark, cardColor, textColor, subTextColor, isSmall),
//                             const SizedBox(height: 36),
//                             _buildSectionHeader("Member Contributions", textColor, isSmall),
//                             const SizedBox(height: 16),
//                             _buildMemberContributions(isDark, cardColor, textColor, subTextColor, isSmall),
//                             const SizedBox(height: 100),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildHeader(bool isSmall) {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   OutfitText(
//                     text: "Expense Overview",
//                     fontSize: isSmall ? 24 : 28,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(height: 4),
//                   OutfitText(
//                     text: "Group spending insights",
//                     fontSize: isSmall ? 14 : 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white.withValues(alpha: 0.8),
//                   ),
//                 ],
//               ),
//             ),
//             Material(
//               color: Colors.white.withValues(alpha: 0.15),
//               borderRadius: BorderRadius.circular(12),
//               child: InkWell(
//                 onTap: () {},
//                 borderRadius: BorderRadius.circular(12),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Icon(Icons.settings, color: Colors.white, size: isSmall ? 22 : 24),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title, Color textColor, bool isSmall) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: OutfitText(
//         text: title,
//         fontSize: isSmall ? 20 : 22,
//         fontWeight: FontWeight.w700,
//         color: textColor,
//       ),
//     );
//   }
//
//   Widget _buildTotalCard(Map<String, dynamic> stats, bool isDark, bool isSmall) {
//     final total = stats['totalExpenses'] as double;
//     final roomRent = stats['totalRoomRent'] as double;
//     final sharedExpenses = stats['sharedExpenses'] as double;
//
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: isDark
//                 ? [AppColors.blueDarkPrimary, AppColors.blueDarkPrimary.withValues(alpha: 0.7)]
//                 : [AppColors.bluePrimary, AppColors.royalBlue],
//           ),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary).withValues(alpha: 0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             OutfitText(
//               text: "Total Group Expense",
//               fontSize: isSmall ? 16 : 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.white.withValues(alpha: 0.9),
//             ),
//             const SizedBox(height: 16),
//             TweenAnimationBuilder<double>(
//               duration: const Duration(milliseconds: 800),
//               tween: Tween(begin: 0.0, end: total),
//               curve: Curves.easeOut,
//               builder: (context, value, child) {
//                 return OutfitText(
//                   text: "₹${value.toStringAsFixed(2)}",
//                   fontSize: isSmall ? 36 : 42,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.white,
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             Divider(color: Colors.white.withValues(alpha: 0.3)),
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     OutfitText(
//                       text: "Room Rent",
//                       fontSize: isSmall ? 12 : 13,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white.withValues(alpha: 0.7),
//                     ),
//                     const SizedBox(height: 4),
//                     OutfitText(
//                       text: "₹${roomRent.toStringAsFixed(0)}",
//                       fontSize: isSmall ? 16 : 18,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     OutfitText(
//                       text: "Shared Expenses",
//                       fontSize: isSmall ? 12 : 13,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white.withValues(alpha: 0.7),
//                     ),
//                     const SizedBox(height: 4),
//                     OutfitText(
//                       text: "₹${sharedExpenses.toStringAsFixed(0)}",
//                       fontSize: isSmall ? 16 : 18,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPieChart(List<Map<String, dynamic>> categories, double total, bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
//     if (total == 0) {
//       return Container(
//         height: 200,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.pie_chart_outline_rounded, size: isSmall ? 48 : 56, color: subTextColor),
//             const SizedBox(height: 16),
//             OutfitText(text: "No expense data", fontSize: isSmall ? 16 : 18, fontWeight: FontWeight.w600, color: textColor),
//           ],
//         ),
//       );
//     }
//
//     final activeCategories = categories.where((cat) => (cat['amount'] as double) > 0).toList();
//
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           margin: const EdgeInsets.symmetric(horizontal: 20),
//           decoration: BoxDecoration(
//             color: cardColor,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: isSmall ? 200 : 240,
//                 child: TweenAnimationBuilder<double>(
//                   duration: const Duration(milliseconds: 1500),
//                   tween: Tween(begin: 0.0, end: 1.0),
//                   curve: Curves.easeOutCubic,
//                   builder: (context, animValue, child) {
//                     return CustomPaint(
//                       size: Size.infinite,
//                       painter: PieChartPainter(
//                         categories: activeCategories,
//                         isDark: isDark,
//                         animationValue: animValue,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 alignment: WrapAlignment.center,
//                 children: activeCategories.map((cat) {
//                   final color = AppColors.getRandomColor(isDark, cat['colorIndex']);
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 12,
//                         height: 12,
//                         decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
//                       ),
//                       const SizedBox(width: 8),
//                       OutfitText(
//                         text: "${cat['name']} (${(cat['percentage'] as double).toStringAsFixed(1)}%)",
//                         fontSize: isSmall ? 12 : 13,
//                         fontWeight: FontWeight.w600,
//                         color: textColor,
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCategoryList(List<Map<String, dynamic>> categories, bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
//     return Column(
//       children: categories.asMap().entries.map((entry) {
//         final index = entry.key;
//         final cat = entry.value;
//         final color = AppColors.getRandomColor(isDark, cat['colorIndex']);
//         final amount = cat['amount'] as double;
//         final expenseCount = cat['expenseCount'] as int;
//
//         return TweenAnimationBuilder<double>(
//           duration: Duration(milliseconds: 200 + (index * 40)),
//           tween: Tween(begin: 0.95, end: 1.0),
//           curve: Curves.easeOutBack,
//           builder: (context, value, child) {
//             return Transform.translate(
//               offset: Offset(0, 15 * (1 - value)),
//               child: Opacity(
//                 opacity: value,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: cardColor,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {},
//                       borderRadius: BorderRadius.circular(16),
//                       highlightColor: color.withValues(alpha: 0.05),
//                       child: Padding(
//                         padding: const EdgeInsets.all(18),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: isSmall ? 48 : 52,
//                               height: isSmall ? 48 : 52,
//                               decoration: BoxDecoration(
//                                 color: color.withValues(alpha: 0.12),
//                                 borderRadius: BorderRadius.circular(14),
//                               ),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   cat['icon'],
//                                   height: isSmall ? 24 : 26,
//                                   width: isSmall ? 24 : 26,
//                                   colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   OutfitText(
//                                     text: cat['name'],
//                                     fontSize: isSmall ? 15 : 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: textColor,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   OutfitText(
//                                     text: expenseCount == 0 ? "No expenses" : "$expenseCount expense${expenseCount > 1 ? 's' : ''}",
//                                     fontSize: isSmall ? 12 : 13,
//                                     fontWeight: FontWeight.w500,
//                                     color: subTextColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 OutfitText(
//                                   text: "₹${amount.toStringAsFixed(0)}",
//                                   fontSize: isSmall ? 16 : 17,
//                                   fontWeight: FontWeight.w700,
//                                   color: amount > 0 ? textColor : subTextColor,
//                                 ),
//                                 if (amount > 0) ...[
//                                   const SizedBox(height: 4),
//                                   OutfitText(
//                                     text: "${(cat['percentage'] as double).toStringAsFixed(1)}%",
//                                     fontSize: isSmall ? 11 : 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: color,
//                                   ),
//                                 ],
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildMemberContributions(bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
//     final total = expenseController.getTotalAmount();
//
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: userController.roommates.asMap().entries.map((entry) {
//           final index = entry.key;
//           final roommate = entry.value;
//           final contribution = expenseController.getRoommateContribution(roommate.name ?? '');
//           final paidExpenses = contribution['paid'] as double;
//           final percentage = total > 0 ? (paidExpenses / total * 100) : 0.0;
//           final color = AppColors.getRandomColor(isDark, index + 1);
//
//           return TweenAnimationBuilder<double>(
//             duration: Duration(milliseconds: 400 + (index * 60)),
//             tween: Tween(begin: 0.0, end: 1.0),
//             curve: Curves.easeOut,
//             builder: (context, value, child) {
//               return Opacity(
//                 opacity: value,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             width: isSmall ? 40 : 44,
//                             height: isSmall ? 40 : 44,
//                             decoration: BoxDecoration(
//                               color: color.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: roommate.profileUrl != null
//                                   ? Image.network(
//                                 roommate.profileUrl!,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (_, __, ___) => Icon(Icons.person, size: isSmall ? 22 : 24, color: color),
//                               )
//                                   : Icon(Icons.person, size: isSmall ? 22 : 24, color: color),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 OutfitText(
//                                   text: roommate.name ?? 'Unknown',
//                                   fontSize: isSmall ? 15 : 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: textColor,
//                                 ),
//                                 const SizedBox(height: 4),
//                                 OutfitText(
//                                   text: "${percentage.toStringAsFixed(1)}% of total",
//                                   fontSize: isSmall ? 12 : 13,
//                                   fontWeight: FontWeight.w500,
//                                   color: subTextColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           OutfitText(
//                             text: "₹${paidExpenses.toStringAsFixed(0)}",
//                             fontSize: isSmall ? 16 : 17,
//                             fontWeight: FontWeight.w700,
//                             color: textColor,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: TweenAnimationBuilder<double>(
//                           duration: Duration(milliseconds: 600 + (index * 60)),
//                           tween: Tween(begin: 0.0, end: percentage / 100),
//                           curve: Curves.easeOut,
//                           builder: (context, animValue, child) {
//                             return LinearProgressIndicator(
//                               value: animValue,
//                               backgroundColor: color.withValues(alpha: 0.15),
//                               valueColor: AlwaysStoppedAnimation<Color>(color),
//                               minHeight: 8,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class PieChartPainter extends CustomPainter {
//   final List<Map<String, dynamic>> categories;
//   final bool isDark;
//   final double animationValue;
//
//   PieChartPainter({
//     required this.categories,
//     required this.isDark,
//     required this.animationValue,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (categories.isEmpty) return;
//
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = math.min(size.width, size.height) / 2.5;
//     double startAngle = -math.pi / 2;
//
//     // Draw subtle glow for each slice
//     for (var category in categories) {
//       final percentage = category['percentage'] as double;
//       final sweepAngle = (percentage / 100) * 2 * math.pi * animationValue;
//       final color = AppColors.getRandomColor(isDark, category['colorIndex']);
//
//       if (isDark && sweepAngle > 0) {
//         final glowPaint = Paint()
//           ..color = color.withValues(alpha: 0.15)
//           ..style = PaintingStyle.fill
//           ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
//
//         canvas.drawArc(
//           Rect.fromCircle(center: center, radius: radius + 5),
//           startAngle,
//           sweepAngle,
//           true,
//           glowPaint,
//         );
//       }
//
//       final paint = Paint()
//         ..color = color
//         ..style = PaintingStyle.fill
//         ..shader = isDark
//             ? LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [color, color.withValues(alpha: 0.75)],
//         ).createShader(Rect.fromCircle(center: center, radius: radius))
//             : null;
//
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius),
//         startAngle,
//         sweepAngle,
//         true,
//         paint,
//       );
//
//       startAngle += sweepAngle;
//     }
//
//     // Inner circle for donut effect
//     final innerPaint = Paint()
//       ..color = isDark ? AppColors.darkSurface : Colors.white
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(center, radius * 0.65, innerPaint);
//
//     // Center text
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.center,
//     );
//
//     textPainter.text = TextSpan(
//       text: 'Total',
//       style: GoogleFonts.outfit(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//         color: isDark ? AppColors.greyDarkText : AppColors.greyText,
//       ),
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - 20));
//
//     double total = categories.fold<double>(0.0, (sum, cat) => sum + (cat['amount'] as double));
//
//     textPainter.text = TextSpan(
//       text: '₹${total.toStringAsFixed(0)}',
//       style: GoogleFonts.outfit(
//         fontSize: 18,
//         fontWeight: FontWeight.w700,
//         color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
//       ),
//     );
//     textPainter.layout();
//     textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy + 2));
//   }
//
//   @override
//   bool shouldRepaint(PieChartPainter oldDelegate) =>
//       oldDelegate.animationValue != animationValue || oldDelegate.isDark != isDark;
// }

class ExpenseOverviewPage extends StatefulWidget {
  const ExpenseOverviewPage({super.key});

  @override
  State<ExpenseOverviewPage> createState() => _ExpenseOverviewPageState();
}

class _ExpenseOverviewPageState extends State<ExpenseOverviewPage>
    with SingleTickerProviderStateMixin {
  final themeController = Get.find<ThemeController>();
  final expenseController = Get.find<ExpenseController>();
  final userController = Get.find<UserController>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, dynamic> get statistics {
    final total = expenseController.getTotalAmount();
    final expenses = expenseController.expenses;
    final currentMonth = expenseController.getCurrentMonthExpenses();
    final now = DateTime.now();
    final prevMonthStart = DateTime(now.year, now.month - 1, 1);
    final prevMonthEnd = DateTime(now.year, now.month, 0);
    final prevMonthExpenses = expenseController.getExpensesByDateRange(prevMonthStart, prevMonthEnd);
    final prevTotal = prevMonthExpenses.fold<double>(0.0, (sum, exp) => sum + exp.amount);
    final monthChange = prevTotal > 0 ? ((total - prevTotal) / prevTotal * 100) : 0.0;

    return {
      'totalExpense': total,
      'prevMonthTotal': prevTotal,
      'monthOverMonthChange': monthChange,
      'transactionCount': expenses.length,
      'avgPerPerson': total / (userController.roommates.isNotEmpty ? userController.roommates.length : 1),
      'fixedExpenses': currentMonth.where((e) => ['Bills', 'Health'].contains(e.categoryName)).fold<double>(0.0, (sum, e) => sum + e.amount),
      'additionalExpenses': currentMonth.where((e) => !['Bills', 'Health'].contains(e.categoryName)).fold<double>(0.0, (sum, e) => sum + e.amount),
    };
  }

  List<Map<String, dynamic>> get allCategoriesWithTotals {
    final breakdown = expenseController.getCategoryBreakdown();
    return expenseController.categories.map((category) {
      final categoryName = category['name'] as String;
      final amount = breakdown[categoryName] ?? 0.0;
      final total = expenseController.getTotalAmount();
      return {
        'name': categoryName,
        'amount': amount,
        'percentage': total > 0 ? (amount / total * 100) : 0.0,
        'icon': category['icon'],
        'colorIndex': category['colorIndex'],
        'expenseCount': expenseController.expenses.where((e) => e.categoryName == categoryName).length,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? AppColors.blackBackground : AppColors.backgroundFill;
      final cardColor = isDark ? AppColors.darkSurface : Colors.white;
      final textColor = isDark ? AppColors.textDarkSecondary : AppColors.textSecondary;
      final subTextColor = isDark ? AppColors.greyDarkText : AppColors.greyText;
      final stats = statistics;
      final categories = allCategoriesWithTotals;

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
                  _buildHeader(isSmall),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTotalCard(stats, isDark, isSmall),
                            const SizedBox(height: 36),
                            // _buildStatsGrid(stats, isDark, cardColor, textColor, subTextColor, isSmall),
                            // const SizedBox(height: 36),
                            _buildSectionHeader("Spending Overview", textColor, isSmall),
                            const SizedBox(height: 20),
                            _buildPieChart(categories, stats['totalExpense'], isDark, cardColor, textColor, subTextColor, isSmall),
                            const SizedBox(height: 28),
                            _buildSectionHeader("All Categories", textColor, isSmall),
                            const SizedBox(height: 16),
                            _buildCategoryList(categories, isDark, cardColor, textColor, subTextColor, isSmall),
                            const SizedBox(height: 36),
                            _buildSectionHeader("Member Contributions", textColor, isSmall),
                            const SizedBox(height: 16),
                            _buildMemberContributions(isDark, cardColor, textColor, subTextColor, isSmall),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(bool isSmall) {
    return FadeTransition(
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
                    text: "Expense Overview",
                    fontSize: isSmall ? 24 : 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  OutfitText(
                    text: "Group spending insights",
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.settings, color: Colors.white, size: isSmall ? 22 : 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor, bool isSmall) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutfitText(
        text: title,
        fontSize: isSmall ? 20 : 22,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
    );
  }

  Widget _buildTotalCard(Map<String, dynamic> stats, bool isDark, bool isSmall) {
    final total = stats['totalExpense'] as double;
    final prevTotal = stats['prevMonthTotal'] as double;
    final change = stats['monthOverMonthChange'] as double;
    final isIncrease = change > 0;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [AppColors.blueDarkPrimary, AppColors.blueDarkPrimary.withValues(alpha: 0.7)]
                : [AppColors.bluePrimary, AppColors.royalBlue],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: (isDark ? AppColors.blueDarkPrimary : AppColors.bluePrimary).withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutfitText(
                  text: "Total Group Expense",
                  fontSize: isSmall ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(isIncrease ? Icons.trending_up : Icons.trending_down, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      OutfitText(
                        text: "${change.abs().toStringAsFixed(1)}%",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 0.0, end: total),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return OutfitText(
                  text: "₹${value.toStringAsFixed(2)}",
                  fontSize: isSmall ? 36 : 42,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                OutfitText(
                  text: "Previous month: ",
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
                OutfitText(
                  text: "₹${prevTotal.toStringAsFixed(2)}",
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> stats, bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    final statsList = [
      {'title': 'Fixed Expenses', 'value': '₹${(stats['fixedExpenses'] as double).toStringAsFixed(0)}', 'icon': Icons.receipt_long_rounded, 'color': isDark ? AppColors.brightGreenDark : AppColors.brightGreen},
      {'title': 'Additional', 'value': '₹${(stats['additionalExpenses'] as double).toStringAsFixed(0)}', 'icon': Icons.add_shopping_cart_rounded, 'color': isDark ? AppColors.brightOrangeDark : AppColors.brightOrange},
      {'title': 'Per Person', 'value': '₹${(stats['avgPerPerson'] as double).toStringAsFixed(0)}', 'icon': Icons.person_outline_rounded, 'color': isDark ? AppColors.brightBlueDark : AppColors.brightBlue},
      {'title': 'Transactions', 'value': '${stats['transactionCount']}', 'icon': Icons.swap_horiz_rounded, 'color': isDark ? AppColors.brightVioletDark : AppColors.brightViolet},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: isSmall ? 1.4 : 1.6,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: statsList.length,
        itemBuilder: (context, index) {
          final stat = statsList[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 60)),
            tween: Tween(begin: 0.95, end: 1.0),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Material(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    // splashColor: (stat['color'] as Color).withValues(alpha: 0.1),
                    // highlightColor: (stat['color'] as Color).withValues(alpha: 0.05),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                      //       blurRadius: 12,
                      //       offset: const Offset(0, 4),
                      //     ),
                      //   ],
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (stat['color'] as Color).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: isSmall ? 22 : 24),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OutfitText(
                                text: stat['title'] as String,
                                fontSize: isSmall ? 12 : 13,
                                fontWeight: FontWeight.w500,
                                color: subTextColor,
                              ),
                              const SizedBox(height: 4),
                              OutfitText(
                                text: stat['value'] as String,
                                fontSize: isSmall ? 16 : 18,
                                fontWeight: FontWeight.w700,
                                color: textColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPieChart(List<Map<String, dynamic>> categories, double total, bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    if (total == 0) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline_rounded, size: isSmall ? 48 : 56, color: subTextColor),
            const SizedBox(height: 16),
            OutfitText(text: "No expense data", fontSize: isSmall ? 16 : 18, fontWeight: FontWeight.w600, color: textColor),
          ],
        ),
      );
    }

    final activeCategories = categories.where((cat) => (cat['amount'] as double) > 0).toList();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: isSmall ? 200 : 240,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1500),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeOutCubic,
                  builder: (context, animValue, child) {
                    return CustomPaint(
                      size: Size.infinite,
                      painter: PieChartPainter(
                        categories: activeCategories,
                        isDark: isDark,
                        animationValue: animValue,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: activeCategories.map((cat) {
                  final color = AppColors.getRandomColor(isDark, cat['colorIndex']);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
                      ),
                      const SizedBox(width: 8),
                      OutfitText(
                        text: "${cat['name']} (${(cat['percentage'] as double).toStringAsFixed(1)}%)",
                        fontSize: isSmall ? 12 : 13,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(List<Map<String, dynamic>> categories, bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    return Column(
      children: categories.asMap().entries.map((entry) {
        final index = entry.key;
        final cat = entry.value;
        final color = AppColors.getRandomColor(isDark, cat['colorIndex']);
        final amount = cat['amount'] as double;
        final expenseCount = cat['expenseCount'] as int;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 200 + (index * 40)),
          tween: Tween(begin: 0.95, end: 1.0),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 15 * (1 - value)),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: cardColor,
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
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    highlightColor: color.withValues(alpha: 0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: isSmall ? 48 : 52,
                            height: isSmall ? 48 : 52,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                cat['icon'],
                                height: isSmall ? 24 : 26,
                                width: isSmall ? 24 : 26,
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
                                  text: cat['name'],
                                  fontSize: isSmall ? 15 : 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: expenseCount == 0 ? "No expenses" : "$expenseCount expense${expenseCount > 1 ? 's' : ''}",
                                  fontSize: isSmall ? 12 : 13,
                                  fontWeight: FontWeight.w500,
                                  color: subTextColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              OutfitText(
                                text: "₹${amount.toStringAsFixed(0)}",
                                fontSize: isSmall ? 16 : 17,
                                fontWeight: FontWeight.w700,
                                color: amount > 0 ? textColor : subTextColor,
                              ),
                              if (amount > 0) ...[
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: "${(cat['percentage'] as double).toStringAsFixed(1)}%",
                                  fontSize: isSmall ? 11 : 12,
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildMemberContributions(bool isDark, Color cardColor, Color textColor, Color subTextColor, bool isSmall) {
    final total = expenseController.getTotalAmount();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: userController.roommates.asMap().entries.map((entry) {
          final index = entry.key;
          final roommate = entry.value;
          final paidExpenses = expenseController.expenses.where((e) => e.addedBy.name == roommate.name).fold<double>(0.0, (sum, e) => sum + e.amount);
          final percentage = total > 0 ? (paidExpenses / total * 100) : 0.0;
          final color = AppColors.getRandomColor(isDark, index + 1);

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 400 + (index * 60)),
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: isSmall ? 40 : 44,
                            height: isSmall ? 40 : 44,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: roommate.profileUrl != null
                                  ? Image.network(
                                roommate.profileUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(Icons.person, size: isSmall ? 22 : 24, color: color),
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
                                  text: roommate.name ?? 'Unknown',
                                  fontSize: isSmall ? 15 : 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                                const SizedBox(height: 4),
                                OutfitText(
                                  text: "${percentage.toStringAsFixed(1)}% of total",
                                  fontSize: isSmall ? 12 : 13,
                                  fontWeight: FontWeight.w500,
                                  color: subTextColor,
                                ),
                              ],
                            ),
                          ),
                          OutfitText(
                            text: "₹${paidExpenses.toStringAsFixed(0)}",
                            fontSize: isSmall ? 16 : 17,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 600 + (index * 60)),
                          tween: Tween(begin: 0.0, end: percentage / 100),
                          curve: Curves.easeOut,
                          builder: (context, animValue, child) {
                            return LinearProgressIndicator(
                              value: animValue,
                              backgroundColor: color.withValues(alpha: 0.15),
                              valueColor: AlwaysStoppedAnimation<Color>(color),
                              minHeight: 8,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> categories;
  final bool isDark;
  final double animationValue;

  PieChartPainter({
    required this.categories,
    required this.isDark,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (categories.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2.5;
    double startAngle = -math.pi / 2;

    // Draw subtle glow for each slice
    for (var category in categories) {
      final percentage = category['percentage'] as double;
      final sweepAngle = (percentage / 100) * 2 * math.pi * animationValue;
      final color = AppColors.getRandomColor(isDark, category['colorIndex']);

      if (isDark && sweepAngle > 0) {
        final glowPaint = Paint()
          ..color = color.withValues(alpha: 0.15)
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius + 5),
          startAngle,
          sweepAngle,
          true,
          glowPaint,
        );
      }

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..shader = isDark
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: 0.75)],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
            : null;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }

    // Inner circle for donut effect
    final innerPaint = Paint()
      ..color = isDark ? AppColors.darkSurface : Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.65, innerPaint);

    // Center text
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.text = TextSpan(
      text: 'Total',
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.greyDarkText : AppColors.greyText,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - 20));

    double total = categories.fold<double>(0.0, (sum, cat) => sum + (cat['amount'] as double));

    textPainter.text = TextSpan(
      text: '₹${total.toStringAsFixed(0)}',
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy + 2));
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue || oldDelegate.isDark != isDark;
}