import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teen_tigada/utils/image_const.dart';
import '../utils/color_const.dart';
import 'user_controller.dart';

// class ExpenseController extends GetxController {
//   final userController = Get.find<UserController>();
//   final RxString currentDate = DateTime.now().toString().obs;
//   final RxString currentMonth = DateTime.now().month.toString().obs;
//   final Rx<DateTime> selectedDate = DateTime.now().obs;
//
//   final RxMap<String, dynamic> splitData = <String, dynamic>{}.obs;
//
//   final RxList<Map<String, dynamic>> categories = [
//     {
//       'name': 'Food',
//       'colorIndex': 1,
//       'icon': AppAssets.food,
//     },
//     {
//       'name': 'Grocery & Spices',
//       'colorIndex': 3,
//       'icon': AppAssets.grocery,
//     },
//     {
//       'name': 'Drinking Water',
//       'colorIndex': 4,
//       'icon': AppAssets.bottle,
//     },
//     {
//       'name': 'Personal Care',
//       'colorIndex': 9,
//       'icon': AppAssets.care,
//     },
//     {
//       'name': 'Household Essentials',
//       'colorIndex': 8,
//       'icon': AppAssets.household,
//     },
//     {
//       'name': 'Rent',
//       'colorIndex': 2,
//       'icon': AppAssets.rent,
//     },
//     {
//       'name': 'Gas',
//       'colorIndex': 0,
//       'icon': AppAssets.gas,
//     },
//     {
//       'name': 'Other',
//       'colorIndex': 7,
//       'icon': AppAssets.other,
//     },
//   ].obs;
//
//   final RxList<Map<String, dynamic>> transactions = [
//     {
//       'icon': AppAssets.grocery,
//       'title': 'Groceries',
//       'subtitle': 'Vegetables',
//       'amount': '- ₹450',
//       'time': 'Today, 2:30 PM',
//       'isExpense': true,
//       'colorIndex': 0,
//       'paidBy': 'Maddy',
//       'category': 'Grocery & Spices',
//     },
//     // {
//     //   'icon': AppAssets.grocery,
//     //   'title': 'Groceries',
//     //   'subtitle': 'Spices',
//     //   'amount': '- ₹150',
//     //   'time': 'Today, 1:15 PM',
//     //   'isExpense': true,
//     //   'colorIndex': 1,
//     //   'paidBy': 'Shovan',
//     //   'category': 'Grocery & Spices',
//     // },
//     // {
//     //   'icon': AppAssets.gas,
//     //   'title': 'Utilities',
//     //   'subtitle': 'Gas',
//     //   'amount': '- ₹800',
//     //   'time': 'Today, 11:30 AM',
//     //   'isExpense': true,
//     //   'colorIndex': 2,
//     //   'paidBy': 'Rishav',
//     //   'category': 'Gas',
//     // },
//     // {
//     //   'icon': AppAssets.household,
//     //   'title': 'Household',
//     //   'subtitle': 'Cleaning Supplies',
//     //   'amount': '- ₹300',
//     //   'time': 'Yesterday, 10:00 AM',
//     //   'isExpense': true,
//     //   'colorIndex': 3,
//     //   'paidBy': 'Rishav',
//     //   'category': 'Household Essentials',
//     // },
//     {
//       'icon': AppAssets.grocery,
//       'title': 'Groceries',
//       'subtitle': 'Fruits',
//       'amount': '- ₹400',
//       'time': 'Yesterday, 8:45 AM',
//       'isExpense': true,
//       'colorIndex': 4,
//       'paidBy': 'Maddy',
//       'category': 'Grocery & Spices',
//     },
//     // {
//     //   'icon': AppAssets.other,
//     //   'title': 'Utilities',
//     //   'subtitle': 'Internet Bill',
//     //   'amount': '- ₹999',
//     //   'time': '2 days ago',
//     //   'isExpense': true,
//     //   'colorIndex': 5,
//     //   'paidBy': 'Rishav',
//     //   'category': 'Other',
//     // },
//     {
//       'icon': AppAssets.other,
//       'title': 'Utilities',
//       'subtitle': 'Electricity Bill',
//       'amount': '- ₹1500',
//       'time': '3 days ago',
//       'isExpense': true,
//       'colorIndex': 6,
//       'paidBy': 'Maddy',
//       'category': 'Other',
//     },
//     {
//       'icon': AppAssets.grocery,
//       'title': 'Groceries',
//       'subtitle': 'Dairy Products',
//       'amount': '- ₹600',
//       'time': '3 days ago',
//       'isExpense': true,
//       'colorIndex': 7,
//       'paidBy': 'Maddy',
//       'category': 'Grocery & Spices',
//     },
//   ].obs;
//
//   final RxList<Map<String, dynamic>> prevMonthTransactions = [
//     {
//       'icon': AppAssets.grocery,
//       'title': 'Groceries',
//       'subtitle': 'Vegetables',
//       'amount': '- ₹500',
//       'isExpense': true,
//       'paidBy': 'Maddy',
//       'category': 'Grocery & Spices',
//     },
//     {
//       'icon': AppAssets.other,
//       'title': 'Utilities',
//       'subtitle': 'Internet Bill',
//       'amount': '- ₹999',
//       'isExpense': true,
//       'paidBy': 'Rishav',
//       'category': 'Other',
//     },
//     {
//       'icon': AppAssets.other,
//       'title': 'Utilities',
//       'subtitle': 'Electricity Bill',
//       'amount': '- ₹1200',
//       'isExpense': true,
//       'paidBy': 'Shovan',
//       'category': 'Other',
//     },
//   ].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     calculateSplits();
//     initializeFixedExpenses();
//     // checkMonthChange();
//   }
//
//   void updateSelectedDate(DateTime date) {
//     selectedDate.value = DateTime(date.year, date.month, date.day);
//   }
//
//   void addCategory(String categoryName) {
//     if (categoryName.isNotEmpty &&
//         !categories.any((cat) => cat['name'] == categoryName)) {
//       categories.add({
//         'name': categoryName,
//         'colorIndex': 7, // Default to 'Other' color
//         'icon': AppAssets.other, // Default SVG for new categories
//       });
//     }
//   }
//
//   void addExpense({
//     required String itemName,
//     required double amount,
//     required String category,
//     required List<String> roommates,
//     required String notes,
//     required String paidBy,
//   }) {
//     final categoryData = categories.firstWhere(
//           (cat) => cat['name'] == category,
//       orElse: () => {
//         'name': category,
//         'colorIndex': 7,
//         'icon': AppAssets.other,
//       },
//     );
//
//     transactions.insert(0, {
//       'icon': categoryData['icon'],
//       'title': category,
//       'subtitle': itemName,
//       'amount': '- ₹${amount.toStringAsFixed(2)}',
//       'time': 'Today, ${DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}',
//       'isExpense': true,
//       'colorIndex': categoryData['colorIndex'],
//       'paidBy': paidBy,
//       'category': category,
//       'notes': notes,
//       'sharedWith': roommates,
//     });
//
//     calculateSplits();
//   }
//
//   void addFixedExpenseWithElectricity({
//     required String name,
//     required double roomRent,
//     required double fromReading,
//     required double toReading,
//     required double ratePerUnit,
//     required String recordedBy,
//     String? notes,
//   }) {
//     final unitsConsumed = toReading - fromReading;
//     final electricityAmount = unitsConsumed * ratePerUnit;
//     final totalAmount = roomRent + electricityAmount;
//     final now = DateTime.now();
//
//     final categoryData = categories.firstWhere(
//           (cat) => cat['name'] == 'Rent',
//       orElse: () => {
//         'name': 'Rent',
//         'colorIndex': 2,
//         'icon': AppAssets.rent,
//       },
//     );
//
//     transactions.insert(0, {
//       'icon': categoryData['icon'],
//       'title': 'Rent',
//       'subtitle': name,
//       'amount': '- ₹${totalAmount.toStringAsFixed(2)}',
//       'time': 'Today, ${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}',
//       'isExpense': true,
//       'colorIndex': categoryData['colorIndex'],
//       'paidBy': recordedBy,
//       'category': 'Rent',
//       'notes': notes ?? 'Room rent: ₹$roomRent, Electricity: ₹$electricityAmount (Units: ${unitsConsumed.toStringAsFixed(1)}, Rate: ₹$ratePerUnit/unit)',
//       'sharedWith': userController.roommates,
//       'isFixed': true,
//       'isElectricity': true,
//     });
//
//     electricityReadings.insert(0, {
//       'id': 'elec_${now.millisecondsSinceEpoch}',
//       'currentReading': toReading,
//       'previousReading': fromReading,
//       'unitsConsumed': unitsConsumed,
//       'ratePerUnit': ratePerUnit,
//       'totalAmount': electricityAmount,
//       'readingDate': now.toIso8601String(),
//       'recordedBy': recordedBy,
//       'notes': notes ?? '',
//       'month': now.month.toString(),
//       'year': now.year.toString(),
//     });
//
//     calculateSplits();
//   }
//
//   void calculateSplits() {
//     final roommates = userController.roommates;
//     Map<String, double> totalPaid = {for (var roommate in roommates) roommate.name!: 0.0};
//     double totalExpense = 0.0;
//     int transactionCount = 0;
//
//     for (var transaction in transactions) {
//       if (transaction['isExpense'] == true) {
//         final amountString = transaction['amount'] as String?;
//         if (amountString != null) {
//           double amount = double.tryParse(
//               amountString.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')) ??
//               0.0;
//           totalPaid[transaction['paidBy'] as String] =
//               totalPaid[transaction['paidBy'] as String]! + amount;
//           totalExpense += amount;
//           transactionCount++;
//         }
//       }
//     }
//
//     double prevMonthTotal = 0.0;
//     for (var transaction in prevMonthTransactions) {
//       if (transaction['isExpense'] == true) {
//         final amountString = transaction['amount'] as String?;
//         if (amountString != null) {
//           prevMonthTotal += double.tryParse(
//               amountString.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')) ??
//               0.0;
//         }
//       }
//     }
//
//     double perPersonShare = roommates.isNotEmpty ? totalExpense / roommates.length : 0.0;
//
//     Map<String, Map<String, dynamic>> splits = {};
//     for (var roommate in roommates) {
//       double balance = totalPaid[roommate.name]! - perPersonShare;
//       splits[roommate.name!] = {
//         'paid': totalPaid[roommate.name],
//         'owes': balance < 0 ? -balance : 0.0,
//         'owed': balance > 0 ? balance : 0.0,
//       };
//     }
//
//     splitData.value = {
//       'splits': splits,
//       'totalExpense': totalExpense,
//       'transactionCount': transactionCount,
//       'avgPerPerson': perPersonShare,
//       'prevMonthTotal': prevMonthTotal,
//     };
//   }
//
//   // List<String> get roommates => userController.roommates.;
//
//   // ADDITIONAL METHODS FOR ENHANCED FUNCTIONALITY
//
//   // Fixed expenses management
//   final RxList<Map<String, dynamic>> fixedExpenses = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> electricityReadings = <Map<String, dynamic>>[].obs;
//   final RxList<Map<String, dynamic>> settlements = <Map<String, dynamic>>[].obs;
//
//   void initializeFixedExpenses() {
//     // Initialize with default room rent
//     if (fixedExpenses.isEmpty) {
//       fixedExpenses.add({
//         'id': 'rent_default',
//         'name': 'Room Rent',
//         'amount': 6000.0,
//         'description': 'Monthly room rent',
//         'category': 'RENT',
//         'isActive': true,
//         'createdAt': DateTime.now().toIso8601String(),
//         'nextDueDate': DateTime(DateTime.now().year, DateTime.now().month + 1, 1).toIso8601String(),
//       });
//     }
//   }
//
//   void addFixedExpense({
//     required String name,
//     required double amount,
//     required String description,
//     required String category,
//   }) {
//     final fixedExpense = {
//       'id': 'fixed_${DateTime.now().millisecondsSinceEpoch}',
//       'name': name,
//       'amount': amount,
//       'description': description,
//       'category': category,
//       'isActive': true,
//       'createdAt': DateTime.now().toIso8601String(),
//       'nextDueDate': DateTime(DateTime.now().year, DateTime.now().month + 1, 1).toIso8601String(),
//     };
//
//     fixedExpenses.add(fixedExpense);
//     generateMonthlyFixedExpense(fixedExpense);
//   }
//
//   void generateMonthlyFixedExpense(Map<String, dynamic> fixedExpense) {
//     final now = DateTime.now();
//     final categoryData = categories.firstWhere(
//           (cat) => cat['name'].toString().toLowerCase().contains(fixedExpense['category'].toString().toLowerCase()),
//       orElse: () => categories.firstWhere((cat) => cat['name'] == 'Other'),
//     );
//
//     final expense = {
//       'icon': categoryData['icon'],
//       'title': fixedExpense['category'],
//       'subtitle': fixedExpense['name'],
//       'amount': '- ₹${(fixedExpense['amount'] as double).toStringAsFixed(2)}',
//       'time': '${now.day}/${now.month}, 12:00 AM',
//       'isExpense': true,
//       'colorIndex': categoryData['colorIndex'],
//       'paidBy': 'System',
//       'category': fixedExpense['category'],
//       'notes': 'Auto-generated monthly ${fixedExpense['name']}',
//       'sharedWith': userController.roommates,
//       'isFixed': true,
//       'fixedExpenseId': fixedExpense['id'],
//     };
//
//     transactions.add(expense);
//     calculateSplits();
//   }
//
//   void addElectricityReading({
//     required double currentReading,
//     required double previousReading,
//     required double ratePerUnit,
//     required String recordedBy,
//     String? notes,
//   }) {
//     final unitsConsumed = currentReading - previousReading;
//     final totalAmount = unitsConsumed * ratePerUnit;
//     final now = DateTime.now();
//
//     final reading = {
//       'id': 'elec_${now.millisecondsSinceEpoch}',
//       'currentReading': currentReading,
//       'previousReading': previousReading,
//       'unitsConsumed': unitsConsumed,
//       'ratePerUnit': ratePerUnit,
//       'totalAmount': totalAmount,
//       'readingDate': now.toIso8601String(),
//       'recordedBy': recordedBy,
//       'notes': notes ?? '',
//       'month': now.month.toString(),
//       'year': now.year.toString(),
//     };
//
//     electricityReadings.insert(0, reading);
//
//     // Auto-create electricity expense
//     final electricityExpense = {
//       'icon': AppAssets.gas, // Using gas icon for electricity
//       'title': 'Utilities',
//       'subtitle': 'Electricity Bill',
//       'amount': '- ₹${totalAmount.toStringAsFixed(2)}',
//       'time': 'Today, ${now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}',
//       'isExpense': true,
//       'colorIndex': 5,
//       'paidBy': recordedBy,
//       'category': 'Other',
//       'notes': 'Units: ${unitsConsumed.toStringAsFixed(1)}, Rate: ₹$ratePerUnit/unit',
//       'sharedWith': userController.roommates,
//       'isElectricity': true,
//       'readingId': reading['id'],
//     };
//
//     transactions.insert(0, electricityExpense);
//     calculateSplits();
//   }
//
//   void settleBalance(String fromUser, String toUser, double amount, {String? notes}) {
//     final settlement = {
//       'id': 'settlement_${DateTime.now().millisecondsSinceEpoch}',
//       'fromUser': fromUser,
//       'toUser': toUser,
//       'amount': amount,
//       'settledAt': DateTime.now().toIso8601String(),
//       'notes': notes ?? '',
//       'status': 'COMPLETED',
//     };
//
//     settlements.add(settlement);
//
//     // Create a settlement transaction record
//     final settlementTransaction = {
//       'icon': AppAssets.other,
//       'title': 'Settlement',
//       'subtitle': '$fromUser → $toUser',
//       'amount': '₹${amount.toStringAsFixed(2)}',
//       'time': 'Today, ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}',
//       'isExpense': false,
//       'colorIndex': 9,
//       'paidBy': fromUser,
//       'category': 'Settlement',
//       'notes': notes ?? 'Settlement payment',
//       'sharedWith': [fromUser, toUser],
//       'isSettlement': true,
//       'settlementId': settlement['id'],
//     };
//
//     transactions.insert(0, settlementTransaction);
//     calculateSplits();
//   }
//
//   void checkMonthChange() {
//     final now = DateTime.now();
//     final lastMonth = now.month == 1 ? 12 : now.month - 1;
//     final lastYear = now.month == 1 ? now.year - 1 : now.year;
//
//     // Check if we need to auto-generate fixed expenses for new month
//     final currentMonthFixedExpenses = transactions.where((t) =>
//     t['isFixed'] == true &&
//         DateTime.parse(t['time'].toString().split(',')[0]).month == now.month
//     ).toList();
//
//     if (currentMonthFixedExpenses.isEmpty && fixedExpenses.isNotEmpty) {
//       // Auto-generate fixed expenses for new month
//       for (var fixedExpense in fixedExpenses) {
//         if (fixedExpense['isActive'] == true) {
//           generateMonthlyFixedExpense(fixedExpense);
//         }
//       }
//     }
//   }
//
//   // Filter and search methods
//   List<Map<String, dynamic>> getTransactionsByCategory(String category) {
//     return transactions.where((t) => t['category'] == category).toList();
//   }
//
//   List<Map<String, dynamic>> getTransactionsByUser(String userName) {
//     return transactions.where((t) => t['paidBy'] == userName).toList();
//   }
//
//   List<Map<String, dynamic>> getTransactionsByMonth(int month, int year) {
//     return transactions.where((t) {
//       try {
//         final timeStr = t['time'] as String;
//         if (timeStr.contains('Today') || timeStr.contains('Yesterday')) {
//           final now = DateTime.now();
//           return now.month == month && now.year == year;
//         }
//         // For other date formats, you might need to parse differently
//         return true; // Fallback for now
//       } catch (e) {
//         return false;
//       }
//     }).toList();
//   }
//
//   List<Map<String, dynamic>> getFixedExpensesOnly() {
//     return transactions.where((t) => t['isFixed'] == true).toList();
//   }
//
//   List<Map<String, dynamic>> getAdditionalExpensesOnly() {
//     return transactions.where((t) => t['isFixed'] != true && t['isSettlement'] != true).toList();
//   }
//
//   Map<String, double> getCategoryWiseExpenses() {
//     Map<String, double> categoryTotals = {};
//
//     for (var transaction in transactions) {
//       if (transaction['isExpense'] == true && transaction['isSettlement'] != true) {
//         final category = transaction['category'] as String;
//         final amountString = transaction['amount'] as String;
//         final amount = double.tryParse(
//             amountString.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')
//         ) ?? 0.0;
//
//         categoryTotals[category] = (categoryTotals[category] ?? 0.0) + amount;
//       }
//     }
//
//     return categoryTotals;
//   }
//
//   double getTotalOwedByUser(String userName) {
//     final userSplit = splitData.value['splits'][userName];
//     return userSplit != null ? (userSplit['owes'] as double?) ?? 0.0 : 0.0;
//   }
//
//   double getTotalOwedToUser(String userName) {
//     final userSplit = splitData.value['splits'][userName];
//     return userSplit != null ? (userSplit['owed'] as double?) ?? 0.0 : 0.0;
//   }
//
//   double getUserTotalPaid(String userName) {
//     final userSplit = splitData.value['splits'][userName];
//     return userSplit != null ? (userSplit['paid'] as double?) ?? 0.0 : 0.0;
//   }
//
//   List<Map<String, dynamic>> getPendingSettlements() {
//     List<Map<String, dynamic>> pendingSettlements = [];
//     final splits = splitData.value['splits'] as Map<String, dynamic>? ?? {};
//
//     for (String user1 in splits.keys) {
//       for (String user2 in splits.keys) {
//         if (user1 != user2) {
//           final user1Data = splits[user1] as Map<String, dynamic>;
//           final user2Data = splits[user2] as Map<String, dynamic>;
//           final user1Owes = (user1Data['owes'] as double?) ?? 0.0;
//           final user2Owed = (user2Data['owed'] as double?) ?? 0.0;
//
//           if (user1Owes > 0 && user2Owed > 0) {
//             final settlementAmount = math.min(user1Owes, user2Owed);
//             if (settlementAmount > 1.0) {
//               pendingSettlements.add({
//                 'from': user1,
//                 'to': user2,
//                 'amount': settlementAmount,
//               });
//             }
//           }
//         }
//       }
//     }
//
//     return pendingSettlements;
//   }
//
//   Map<String, dynamic> getMonthlyStatistics() {
//     final totalExpense = splitData.value['totalExpense'] as double? ?? 0.0;
//     final avgPerPerson = splitData.value['avgPerPerson'] as double? ?? 0.0;
//     final transactionCount = splitData.value['transactionCount'] as int? ?? 0;
//     final prevMonthTotal = splitData.value['prevMonthTotal'] as double? ?? 0.0;
//
//     final categoryTotals = getCategoryWiseExpenses();
//     final fixedTotal = getFixedExpensesOnly().fold<double>(0.0, (sum, expense) {
//       final amountString = expense['amount'] as String;
//       return sum + (double.tryParse(
//           amountString.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')
//       ) ?? 0.0);
//     });
//
//     final additionalTotal = totalExpense - fixedTotal;
//
//     return {
//       'totalExpense': totalExpense,
//       'fixedExpenses': fixedTotal,
//       'additionalExpenses': additionalTotal,
//       'avgPerPerson': avgPerPerson,
//       'transactionCount': transactionCount,
//       'prevMonthTotal': prevMonthTotal,
//       'categoryBreakdown': categoryTotals,
//       'monthOverMonthChange': prevMonthTotal > 0 ? ((totalExpense - prevMonthTotal) / prevMonthTotal * 100) : 0.0,
//     };
//   }
//
//   void updateFixedExpense(String id, Map<String, dynamic> updates) {
//     final index = fixedExpenses.indexWhere((expense) => expense['id'] == id);
//     if (index != -1) {
//       fixedExpenses[index] = {...fixedExpenses[index], ...updates};
//
//       // Update related transactions if amount changed
//       if (updates.containsKey('amount')) {
//         final relatedTransactions = transactions.where((t) => t['fixedExpenseId'] == id).toList();
//         for (var transaction in relatedTransactions) {
//           final transactionIndex = transactions.indexOf(transaction);
//           if (transactionIndex != -1) {
//             transactions[transactionIndex]['amount'] = '- ₹${(updates['amount'] as double).toStringAsFixed(2)}';
//           }
//         }
//         calculateSplits();
//       }
//     }
//   }
//
//   void deleteFixedExpense(String id) {
//     fixedExpenses.removeWhere((expense) => expense['id'] == id);
//     transactions.removeWhere((t) => t['fixedExpenseId'] == id);
//     calculateSplits();
//   }
//
//   void editTransaction(int index, Map<String, dynamic> updates) {
//     if (index >= 0 && index < transactions.length) {
//       transactions[index] = {...transactions[index], ...updates};
//       calculateSplits();
//     }
//   }
//
//   void deleteTransaction(int index) {
//     if (index >= 0 && index < transactions.length) {
//       transactions.removeAt(index);
//       calculateSplits();
//     }
//   }
//
//   void markFixedExpenseInactive(String id) {
//     updateFixedExpense(id, {'isActive': false});
//   }
//
//   void markFixedExpenseActive(String id) {
//     updateFixedExpense(id, {'isActive': true});
//   }
//
//   List<Map<String, dynamic>> getRecentTransactions({int limit = 10}) {
//     return transactions.take(limit).toList();
//   }
//
//   List<Map<String, dynamic>> getTransactionsByDateRange(DateTime startDate, DateTime endDate) {
//     // For now, return all transactions as we're using relative time strings
//     // In a real implementation, you'd store actual DateTime objects
//     return transactions.toList();
//   }
//
//   void exportMonthlyData(int month, int year) {
//     final monthTransactions = getTransactionsByMonth(month, year);
//     final statistics = getMonthlyStatistics();
//
//     // This would typically export to CSV or PDF
//     // For now, just print the data structure
//     print('Monthly Export Data:');
//     print('Transactions: ${monthTransactions.length}');
//     print('Total Expense: ₹${statistics['totalExpense']}');
//     print('Category Breakdown: ${statistics['categoryBreakdown']}');
//   }
//
//   // void resetMonthlyData() {
//   //   // Move current transactions to previous month
//   //   prevMonthTransactions.clear();
//   //   prevMonthTransactions.addAll(transactions.where((t) => t['isExpense'] == true).toList());
//   //
//   //   // Clear current transactions except fixed ones that should continue
//   //   transactions.removeWhere((t) => t['isFixed'] != true);
//   //
//   //   // Reset split data
//   //   calculateSplits();
//   // }
//
//   bool isBalanceSettled() {
//     final splits = splitData.value['splits'] as Map<String, dynamic>? ?? {};
//     for (var userSplit in splits.values) {
//       final userData = userSplit as Map<String, dynamic>;
//       final owes = (userData['owes'] as double?) ?? 0.0;
//       if (owes > 1.0) return false; // Consider settled if owes less than ₹1
//     }
//     return true;
//   }
//
//   String getNextSettlementSuggestion() {
//     final pendingSettlements = getPendingSettlements();
//     if (pendingSettlements.isEmpty) {
//       return "All balances are settled!";
//     }
//
//     final settlement = pendingSettlements.first;
//     return "${settlement['from']} should pay ₹${(settlement['amount'] as double).toStringAsFixed(2)} to ${settlement['to']}";
//   }
//
//   void addCustomCategory({
//     required String name,
//     required String icon,
//     required int colorIndex,
//   }) {
//     if (name.isNotEmpty && !categories.any((cat) => cat['name'] == name)) {
//       categories.add({
//         'name': name,
//         'colorIndex': colorIndex,
//         'icon': icon,
//         'isCustom': true,
//         'createdAt': DateTime.now().toIso8601String(),
//       });
//     }
//   }
//
//   void updateCategory(String name, Map<String, dynamic> updates) {
//     final index = categories.indexWhere((cat) => cat['name'] == name);
//     if (index != -1) {
//       categories[index] = {...categories[index], ...updates};
//     }
//   }
//
//   void deleteCustomCategory(String name) {
//     // Only allow deletion of custom categories, not default ones
//     final category = categories.firstWhere(
//           (cat) => cat['name'] == name,
//       orElse: () => {},
//     );
//
//     if (category.isNotEmpty && category['isCustom'] == true) {
//       categories.removeWhere((cat) => cat['name'] == name);
//
//       // Update transactions using this category to 'Other'
//       for (int i = 0; i < transactions.length; i++) {
//         if (transactions[i]['category'] == name) {
//           transactions[i]['category'] = 'Other';
//           final otherCategory = categories.firstWhere((cat) => cat['name'] == 'Other');
//           transactions[i]['icon'] = otherCategory['icon'];
//           transactions[i]['colorIndex'] = otherCategory['colorIndex'];
//         }
//       }
//       calculateSplits();
//     }
//   }
//
//   // Notification helpers
//   List<Map<String, dynamic>> getNotifications() {
//     List<Map<String, dynamic>> notifications = [];
//
//     // Check for pending settlements
//     final pendingSettlements = getPendingSettlements();
//     for (var settlement in pendingSettlements) {
//       notifications.add({
//         'id': 'settlement_${settlement['from']}_${settlement['to']}',
//         'title': 'Settlement Pending',
//         'message': '${settlement['from']} owes ₹${(settlement['amount'] as double).toStringAsFixed(2)} to ${settlement['to']}',
//         'type': 'SETTLEMENT',
//         'createdAt': DateTime.now().toIso8601String(),
//         'isRead': false,
//         'data': settlement,
//       });
//     }
//
//     // Check for month-end reminders
//     final now = DateTime.now();
//     final daysLeft = DateTime(now.year, now.month + 1, 0).day - now.day;
//     if (daysLeft <= 3) {
//       notifications.add({
//         'id': 'month_end_${now.month}_${now.year}',
//         'title': 'Month Ending Soon',
//         'message': 'Only $daysLeft days left in ${getMonthName(now.month)}. Time to settle up!',
//         'type': 'REMINDER',
//         'createdAt': DateTime.now().toIso8601String(),
//         'isRead': false,
//         'data': {'daysLeft': daysLeft},
//       });
//     }
//
//     return notifications;
//   }
//
//   String getMonthName(int month) {
//     const monthNames = [
//       'January', 'February', 'March', 'April', 'May', 'June',
//       'July', 'August', 'September', 'October', 'November', 'December',
//     ];
//     return monthNames[month - 1];
//   }
//
//   // Validation helpers
//   bool isValidExpenseAmount(String amountText) {
//     final amount = double.tryParse(amountText);
//     return amount != null && amount > 0;
//   }
//
//   bool isValidElectricityReading(double current, double previous) {
//     return current > 0 && previous >= 0 && current > previous;
//   }
//
//   // Data persistence helpers (for future local storage implementation)
//   Map<String, dynamic> exportAllData() {
//     return {
//       'transactions': transactions.toList(),
//       'fixedExpenses': fixedExpenses.toList(),
//       'electricityReadings': electricityReadings.toList(),
//       'settlements': settlements.toList(),
//       'categories': categories.toList(),
//       'splitData': splitData.value,
//       'exportedAt': DateTime.now().toIso8601String(),
//     };
//   }
//
//   void importAllData(Map<String, dynamic> data) {
//     try {
//       if (data.containsKey('transactions')) {
//         transactions.clear();
//         transactions.addAll(List<Map<String, dynamic>>.from(data['transactions']));
//       }
//       if (data.containsKey('fixedExpenses')) {
//         fixedExpenses.clear();
//         fixedExpenses.addAll(List<Map<String, dynamic>>.from(data['fixedExpenses']));
//       }
//       if (data.containsKey('electricityReadings')) {
//         electricityReadings.clear();
//         electricityReadings.addAll(List<Map<String, dynamic>>.from(data['electricityReadings']));
//       }
//       if (data.containsKey('settlements')) {
//         settlements.clear();
//         settlements.addAll(List<Map<String, dynamic>>.from(data['settlements']));
//       }
//       if (data.containsKey('categories')) {
//         categories.clear();
//         categories.addAll(List<Map<String, dynamic>>.from(data['categories']));
//       }
//
//       calculateSplits();
//     } catch (e) {
//       print('Error importing data: $e');
//     }
//   }
//
//   void clearAllData() {
//     transactions.clear();
//     fixedExpenses.clear();
//     electricityReadings.clear();
//     settlements.clear();
//     splitData.clear();
//     calculateSplits();
//   }
//
//   // Search functionality
//   List<Map<String, dynamic>> searchTransactions(String query) {
//     final lowercaseQuery = query.toLowerCase();
//     return transactions.where((transaction) {
//       final category = (transaction['category'] as String? ?? '').toLowerCase();
//       final subtitle = (transaction['subtitle'] as String? ?? '').toLowerCase();
//       final paidBy = (transaction['paidBy'] as String? ?? '').toLowerCase();
//       final notes = (transaction['notes'] as String? ?? '').toLowerCase();
//
//       return category.contains(lowercaseQuery) ||
//           subtitle.contains(lowercaseQuery) ||
//           paidBy.contains(lowercaseQuery) ||
//           notes.contains(lowercaseQuery);
//     }).toList();
//   }
//
//   // Analytics methods
//   Map<String, double> getUserExpenseBreakdown(String userName) {
//     Map<String, double> userExpenses = {};
//
//     final userTransactions = getTransactionsByUser(userName);
//     for (var transaction in userTransactions) {
//       final category = transaction['category'] as String;
//       final amountString = transaction['amount'] as String;
//       final amount = double.tryParse(
//           amountString.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')
//       ) ?? 0.0;
//
//       userExpenses[category] = (userExpenses[category] ?? 0.0) + amount;
//     }
//
//     return userExpenses;
//   }
//
//   double getAverageMonthlyExpense() {
//     // Calculate average based on current and previous month
//     final currentTotal = splitData.value['totalExpense'] as double? ?? 0.0;
//     final prevTotal = splitData.value['prevMonthTotal'] as double? ?? 0.0;
//
//     if (prevTotal > 0) {
//       return (currentTotal + prevTotal) / 2;
//     }
//     return currentTotal;
//   }
//
//   List<Map<String, dynamic>> getTopCategories({int limit = 5}) {
//     final categoryTotals = getCategoryWiseExpenses();
//     final sortedCategories = categoryTotals.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));
//
//     return sortedCategories.take(limit).map((entry) {
//       // Find category data - handle the case where category might not be found
//       Map<String, dynamic>? categoryData;
//
//       try {
//         categoryData = categories.firstWhere(
//               (cat) => cat['name'] == entry.key,
//         );
//       } catch (e) {
//         // If category not found, use default
//         categoryData = {
//           'name': entry.key,
//           'colorIndex': 7,
//           'icon': AppAssets.other,
//         };
//       }
//
//       return {
//         'name': entry.key,
//         'amount': entry.value,
//         'percentage': ((entry.value / (splitData.value['totalExpense'] as double? ?? 1.0)) * 100),
//         'colorIndex': categoryData['colorIndex'] as int,
//         'icon': categoryData['icon'] as String,
//       };
//     }).toList();
//   }
//
//   Map<String, dynamic> getBalanceSummary() {
//     final splits = splitData.value['splits'] as Map<String, dynamic>? ?? {};
//     double totalOwes = 0.0;
//     double totalOwed = 0.0;
//     int usersWhoOwe = 0;
//     int usersWhoAreOwed = 0;
//
//     for (var userSplit in splits.values) {
//       final userData = userSplit as Map<String, dynamic>;
//       final owes = (userData['owes'] as double?) ?? 0.0;
//       final owed = (userData['owed'] as double?) ?? 0.0;
//
//       if (owes > 0) {
//         totalOwes += owes;
//         usersWhoOwe++;
//       }
//       if (owed > 0) {
//         totalOwed += owed;
//         usersWhoAreOwed++;
//       }
//     }
//
//     return {
//       'totalOwes': totalOwes,
//       'totalOwed': totalOwed,
//       'usersWhoOwe': usersWhoOwe,
//       'usersWhoAreOwed': usersWhoAreOwed,
//       'isBalanced': (totalOwes - totalOwed).abs() < 1.0,
//     };
//   }
//
//   // Utility methods for UI
//   String getRelativeTimeString(String timeString) {
//     if (timeString.contains('Today')) return timeString;
//     if (timeString.contains('Yesterday')) return timeString;
//
//     // For other formats, you might want to parse and calculate
//     return timeString;
//   }
//
//   Color getTransactionColor(Map<String, dynamic> transaction, bool isDark) {
//     final colorIndex = transaction['colorIndex'] as int? ?? 7;
//     return AppColors.getRandomColor(isDark, colorIndex);
//   }
//
//   String formatCurrency(double amount) {
//     return '₹${amount.toStringAsFixed(2)}';
//   }
//
//   String formatAmountWithSign(double amount, bool isExpense) {
//     final sign = isExpense ? '-' : '+';
//     return '$sign ₹${amount.toStringAsFixed(2)}';
//   }
// }

import 'dart:math';
import 'package:get/get.dart';
import 'package:teen_tigada/models/expense_model.dart';
import 'package:teen_tigada/models/user_model.dart';

class ExpenseController extends GetxController {
  // Observable list of all expenses
  final RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;

  // Selected date for adding expense
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  // Predefined categories with icons
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[
    {
      'name': 'Food',
      'icon': AppAssets.food,
      'colorIndex': 0, // Red 🍎
    },
    {
      'name': 'Care Products',
      'icon': AppAssets.care,
      'colorIndex': 1, // Orange 🧼
    },
    {
      'name': 'Vegetables',
      'icon': AppAssets.grocery,
      'colorIndex': 2, // Green 🥦
    },
    {
      'name': 'Gas',
      'icon': AppAssets.gas,
      'colorIndex': 3, // Blue ⛽
    },
    {
      'name': 'Electricity',
      'icon': AppAssets.electric,
      'colorIndex': 4, // Yellow ⚡
    },
    {
      'name': 'Household Items',
      'icon': AppAssets.household,
      'colorIndex': 5, // Indigo 🏠
    },
    {
      'name': 'Room Rent',
      'icon': AppAssets.rent,
      'colorIndex': 6, // Violet 🏢
    },
    {
      'name': 'Water Bill',
      'icon': AppAssets.bottle,
      'colorIndex': 7, // Teal 💧
    },
    {
      'name': 'Other',
      'icon': AppAssets.other,
      'colorIndex': 8, // Grey ⚪
    },
  ].obs;


  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  // Load dummy data for testing
  void _loadDummyData() {
    final now = DateTime.now();

    // Create user models for roommates
    final maddy = UserModel(
      id: '1',
      name: 'Maddy',
      email: 'areyoucrazyy@gmail.com',
      phoneNumber: '+91 7586960740',
      profileUrl: "https://avatar.iran.liara.run/public/48",
    );

    final rishav = UserModel(
      id: '2',
      name: 'Rishav',
      profileUrl: "https://avatar.iran.liara.run/public/15",
    );

    final shovan = UserModel(
      id: '3',
      name: 'Shovan',
      profileUrl: "https://avatar.iran.liara.run/public/16",
    );

    expenses.addAll([
      // Today's expenses
      ExpenseModel(
        id: '1',
        time: now.subtract(const Duration(hours: 2)),
        itemName: 'Monthly Groceries',
        amount: 1250.00,
        categoryName: 'Food',
        categoryIcon: AppAssets.food,
        splitWith: ['Rishav', 'Shovan'],
        notes: 'Monthly grocery shopping',
        colorIndex: 0, // Food → Red
        addedBy: maddy,
      ),
      ExpenseModel(
        id: '2',
        time: now.subtract(const Duration(hours: 5)),
        itemName: 'Shampoo & Soap',
        amount: 450.00,
        categoryName: 'Care Products',
        categoryIcon: AppAssets.care,
        splitWith: ['Maddy'],
        notes: 'Personal care items',
        colorIndex: 1, // Care → Orange
        addedBy: rishav,
      ),
      ExpenseModel(
        id: '3',
        time: now.subtract(const Duration(hours: 7)),
        itemName: 'Electricity Bill',
        amount: 2840.00,
        categoryName: 'Electricity',
        categoryIcon: AppAssets.electric,
        splitWith: ['Maddy', 'Rishav'],
        notes: 'October electricity bill',
        colorIndex: 2, // Electricity → Yellow
        addedBy: shovan,
      ),

      // Yesterday's expenses
      ExpenseModel(
        id: '4',
        time: now.subtract(const Duration(days: 1, hours: 3)),
        itemName: 'Gas Cylinder',
        amount: 900.00,
        categoryName: 'Gas',
        categoryIcon: AppAssets.gas,
        splitWith: ['Rishav', 'Shovan'],
        notes: 'Cooking gas refill',
        colorIndex: 8, // Gas → Cyan
        addedBy: maddy,
      ),
      ExpenseModel(
        id: '5',
        time: now.subtract(const Duration(days: 1, hours: 10)),
        itemName: 'Dinner at Restaurant',
        amount: 1850.00,
        categoryName: 'Food',
        categoryIcon: AppAssets.food,
        splitWith: ['Maddy', 'Shovan'],
        notes: 'Italian restaurant',
        colorIndex: 0, // Food → Red
        addedBy: rishav,
      ),

      // 2 days ago
      ExpenseModel(
        id: '6',
        time: now.subtract(const Duration(days: 2, hours: 5)),
        itemName: 'Fresh Vegetables',
        amount: 680.00,
        categoryName: 'Vegetables',
        categoryIcon: AppAssets.grocery,
        splitWith: ['Shovan'],
        notes: 'Weekly vegetables and fruits',
        colorIndex: 3, // Vegetables → Green
        addedBy: shovan,
      ),
      ExpenseModel(
        id: '7',
        time: now.subtract(const Duration(days: 2, hours: 12)),
        itemName: 'Cleaning Supplies',
        amount: 850.00,
        categoryName: 'Household Items',
        categoryIcon: AppAssets.household,
        splitWith: [],
        notes: 'Broom, mop, detergent',
        colorIndex: 5, // Household → Indigo
        addedBy: maddy,
      ),

      // 3 days ago
      ExpenseModel(
        id: '8',
        time: now.subtract(const Duration(days: 3, hours: 4)),
        itemName: 'Water Bill',
        amount: 580.00,
        categoryName: 'Water Bill',
        categoryIcon: AppAssets.bottle,
        splitWith: ['Maddy', 'Shovan'],
        notes: 'Monthly water charges',
        colorIndex: 4, // Water → Blue
        addedBy: rishav,
      ),

      // 5 days ago
      ExpenseModel(
        id: '9',
        time: now.subtract(const Duration(days: 5, hours: 6)),
        itemName: 'Room Rent',
        amount: 8500.00,
        categoryName: 'Room Rent',
        categoryIcon: AppAssets.rent,
        splitWith: ['Maddy', 'Rishav'],
        notes: 'October room rent',
        colorIndex: 6, // Room Rent → Violet
        addedBy: shovan,
      ),
      ExpenseModel(
        id: '10',
        time: now.subtract(const Duration(days: 5, hours: 16)),
        itemName: 'Toothpaste & Brush',
        amount: 280.00,
        categoryName: 'Care Products',
        categoryIcon: AppAssets.care,
        splitWith: ['Rishav'],
        notes: 'Oral care products',
        colorIndex: 1, // Care → Orange
        addedBy: maddy,
      ),

      // 7 days ago
      ExpenseModel(
        id: '11',
        time: now.subtract(const Duration(days: 7)),
        itemName: 'Kitchen Utensils',
        amount: 1200.00,
        categoryName: 'Household Items',
        categoryIcon: AppAssets.household,
        splitWith: ['Maddy', 'Shovan'],
        notes: 'Plates and bowls',
        colorIndex: 5, // Household → Indigo
        addedBy: rishav,
      ),
      ExpenseModel(
        id: '12',
        time: now.subtract(const Duration(days: 7, hours: 5)),
        itemName: 'Emergency Repair',
        amount: 800.00,
        categoryName: 'Other',
        categoryIcon: AppAssets.other,
        splitWith: ['Rishav', 'Shovan'],
        notes: 'Plumbing repair',
        colorIndex: 7, // Other → Pink/Violet
        addedBy: maddy,
      ),

      // 10 days ago
      ExpenseModel(
        id: '13',
        time: now.subtract(const Duration(days: 10)),
        itemName: 'Organic Vegetables',
        amount: 950.00,
        categoryName: 'Vegetables',
        categoryIcon: AppAssets.grocery,
        splitWith: [],
        notes: 'Premium organic produce',
        colorIndex: 3, // Vegetables → Green
        addedBy: shovan,
      ),
      ExpenseModel(
        id: '14',
        time: now.subtract(const Duration(days: 10, hours: 8)),
        itemName: 'Snacks & Beverages',
        amount: 620.00,
        categoryName: 'Food',
        categoryIcon: AppAssets.food,
        splitWith: ['Rishav', 'Shovan'],
        notes: 'Movie night snacks',
        colorIndex: 0, // Food → Red
        addedBy: maddy,
      ),

      // 15 days ago
      ExpenseModel(
        id: '15',
        time: now.subtract(const Duration(days: 15)),
        itemName: 'Gas Cylinder',
        amount: 900.00,
        categoryName: 'Gas',
        categoryIcon: AppAssets.gas,
        splitWith: ['Maddy', 'Rishav'],
        notes: 'Gas refill',
        colorIndex: 8, // Gas → Cyan
        addedBy: shovan,
      ),
    ]);

  }

  /// Add a new expense
  void addExpense({
    required String itemName,
    required double amount,
    required String category,
    required List<String> roommates,
    required String notes,
    required String paidBy,
  }) {
    // Find category details
    final categoryData = categories.firstWhere(
          (cat) => cat['name'] == category,
      orElse: () => categories.last,
    );

    final colorIndex = categoryData['colorIndex'] ?? Random().nextInt(10);

    // Create user model for the person who paid
    final addedByUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: paidBy,
    );

    final expense = ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      time: selectedDate.value,
      itemName: itemName,
      amount: amount,
      categoryName: category,
      categoryIcon: categoryData['icon'],
      splitWith: roommates,
      notes: notes,
      colorIndex: colorIndex,
      addedBy: addedByUser,
    );

    expenses.insert(0, expense);
  }

  /// Update an existing expense
  void updateExpense(String id, ExpenseModel updatedExpense) {
    final index = expenses.indexWhere((exp) => exp.id == id);
    if (index != -1) {
      expenses[index] = updatedExpense;
    }
  }

  /// Delete an expense
  void deleteExpense(String id) {
    expenses.removeWhere((exp) => exp.id == id);
  }

  /// Add a new category (restricted to predefined categories only)
  void addCategory(String categoryName) {
    // Only allow predefined categories, map to 'Other' if not found
    final existingCategory = categories.firstWhere(
          (cat) => cat['name'] == categoryName,
      orElse: () => categories.last, // Returns 'Other' category
    );
    // Categories are predefined and cannot be dynamically added
  }

  /// Get expenses by date range
  List<ExpenseModel> getExpensesByDateRange(DateTime start, DateTime end) {
    return expenses.where((expense) {
      return expense.time.isAfter(start.subtract(const Duration(days: 1))) &&
          expense.time.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  /// Get expenses by category
  List<ExpenseModel> getExpensesByCategory(String category) {
    return expenses.where((expense) => expense.categoryName == category).toList();
  }

  /// Get total amount spent
  double getTotalAmount() {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  /// Get total by category
  double getTotalByCategory(String category) {
    return expenses
        .where((expense) => expense.categoryName == category)
        .fold(0, (sum, expense) => sum + expense.amount);
  }

  /// Calculate owed amount
  double calculateOwedAmount(String fromUser, String toUser) {
    double totalOwed = 0;
    for (var expense in expenses) {
      if (expense.addedBy.name == toUser && expense.splitWith.contains(fromUser)) {
        totalOwed += expense.splitAmount;
      }
    }
    return totalOwed;
  }

  /// Get settlement summary
  Map<String, double> getSettlementSummary(String userName) {
    Map<String, double> summary = {};
    for (var expense in expenses) {
      if (expense.addedBy.name != userName && expense.splitWith.contains(userName)) {
        final payer = expense.addedBy.name!;
        summary[payer] = (summary[payer] ?? 0) + expense.splitAmount;
      }
      if (expense.addedBy.name == userName) {
        for (var roommate in expense.splitWith) {
          summary[roommate] = (summary[roommate] ?? 0) - expense.splitAmount;
        }
      }
    }
    return summary;
  }

  /// Get expenses for current month
  List<ExpenseModel> getCurrentMonthExpenses() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    return getExpensesByDateRange(firstDay, lastDay);
  }

  /// Get category-wise spending breakdown
  Map<String, double> getCategoryBreakdown() {
    Map<String, double> breakdown = {};
    for (var expense in expenses) {
      breakdown[expense.categoryName] =
          (breakdown[expense.categoryName] ?? 0) + expense.amount;
    }
    return breakdown;
  }

  /// Clear all expenses
  void clearAllExpenses() {
    expenses.clear();
  }
}