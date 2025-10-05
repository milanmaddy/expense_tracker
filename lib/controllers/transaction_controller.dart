import 'package:get/get.dart';
import 'package:teen_tigada/models/transaction_model.dart';
import 'package:teen_tigada/utils/image_const.dart';

class TransactionController extends GetxController {
  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxList<Transaction> prevMonthTransactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeTransactions();
  }

  void initializeTransactions() {
    transactions.addAll([
      Transaction(
        icon: AppAssets.grocery,
        title: 'Groceries',
        subtitle: 'Vegetables',
        amount: '- ₹450',
        time: 'Today, 2:30 PM',
        isExpense: true,
        colorIndex: 0,
        paidBy: 'Maddy',
        category: 'Grocery & Spices',
      ),
      Transaction(
        icon: AppAssets.grocery,
        title: 'Groceries',
        subtitle: 'Spices',
        amount: '- ₹150',
        time: 'Today, 1:15 PM',
        isExpense: true,
        colorIndex: 1,
        paidBy: 'Shovan',
        category: 'Grocery & Spices',
      ),
      Transaction(
        icon: AppAssets.gas,
        title: 'Utilities',
        subtitle: 'Gas',
        amount: '- ₹800',
        time: 'Today, 11:30 AM',
        isExpense: true,
        colorIndex: 2,
        paidBy: 'Rishav',
        category: 'Gas',
      ),
      Transaction(
        icon: AppAssets.household,
        title: 'Household',
        subtitle: 'Cleaning Supplies',
        amount: '- ₹300',
        time: 'Yesterday, 10:00 AM',
        isExpense: true,
        colorIndex: 3,
        paidBy: 'Rishav',
        category: 'Household Essentials',
      ),
      Transaction(
        icon: AppAssets.grocery,
        title: 'Groceries',
        subtitle: 'Fruits',
        amount: '- ₹400',
        time: 'Yesterday, 8:45 AM',
        isExpense: true,
        colorIndex: 4,
        paidBy: 'Maddy',
        category: 'Grocery & Spices',
      ),
      Transaction(
        icon: AppAssets.other,
        title: 'Utilities',
        subtitle: 'Internet Bill',
        amount: '- ₹999',
        time: '2 days ago',
        isExpense: true,
        colorIndex: 5,
        paidBy: 'Rishav',
        category: 'Other',
      ),
      Transaction(
        icon: AppAssets.other,
        title: 'Utilities',
        subtitle: 'Electricity Bill',
        amount: '- ₹1500',
        time: '3 days ago',
        isExpense: true,
        colorIndex: 6,
        paidBy: 'Maddy',
        category: 'Other',
      ),
      Transaction(
        icon: AppAssets.grocery,
        title: 'Groceries',
        subtitle: 'Dairy Products',
        amount: '- ₹600',
        time: '3 days ago',
        isExpense: true,
        colorIndex: 7,
        paidBy: 'Maddy',
        category: 'Grocery & Spices',
      ),
    ]);

    prevMonthTransactions.addAll([
      Transaction(
        icon: AppAssets.grocery,
        title: 'Groceries',
        subtitle: 'Vegetables',
        amount: '- ₹500',
        isExpense: true,
        colorIndex: 0,
        paidBy: 'Maddy',
        category: 'Grocery & Spices', time: 'f',
      ),
      Transaction(
        icon: AppAssets.other,
        title: 'Utilities',
        subtitle: 'Internet Bill',
        amount: '- ₹999',
        isExpense: true,
        colorIndex: 5,
        paidBy: 'Rishav',
        category: 'Other', time: '',
      ),
      Transaction(
        icon: AppAssets.other,
        title: 'Utilities',
        subtitle: 'Electricity Bill',
        amount: '- ₹1200',
        isExpense: true,
        colorIndex: 6,
        paidBy: 'Shovan',
        category: 'Other', time: '',
      ),
    ]);
  }

  void addTransaction(Transaction transaction) {
    transactions.insert(0, transaction);
  }

  void editTransaction(int index, Transaction updatedTransaction) {
    if (index >= 0 && index < transactions.length) {
      transactions[index] = updatedTransaction;
    }
  }

  void deleteTransaction(int index) {
    if (index >= 0 && index < transactions.length) {
      transactions.removeAt(index);
    }
  }

  List<Transaction> getTransactionsByCategory(String category) {
    return transactions.where((t) => t.category == category).toList();
  }

  List<Transaction> getTransactionsByUser(String userName) {
    return transactions.where((t) => t.paidBy == userName).toList();
  }

  List<Transaction> getTransactionsByMonth(int month, int year) {
    return transactions.where((t) {
      try {
        final timeStr = t.time;
        if (timeStr.contains('Today') || timeStr.contains('Yesterday')) {
          final now = DateTime.now();
          return now.month == month && now.year == year;
        }
        return true; // Fallback for now
      } catch (e) {
        return false;
      }
    }).toList();
  }

  List<Transaction> getFixedExpensesOnly() {
    return transactions.where((t) => t.isFixed == true).toList();
  }

  List<Transaction> getAdditionalExpensesOnly() {
    return transactions.where((t) => t.isFixed != true && t.isSettlement != true).toList();
  }

  Map<String, double> getCategoryWiseExpenses() {
    Map<String, double> categoryTotals = {};
    for (var transaction in transactions) {
      if (transaction.isExpense && transaction.isSettlement != true) {
        final amount = double.tryParse(
            transaction.amount.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')) ??
            0.0;
        categoryTotals[transaction.category] = (categoryTotals[transaction.category] ?? 0.0) + amount;
      }
    }
    return categoryTotals;
  }

  List<Transaction> getRecentTransactions({int limit = 10}) {
    return transactions.take(limit).toList();
  }

  List<Transaction> getTransactionsByDateRange(DateTime startDate, DateTime endDate) {
    return transactions.toList(); // Simplified for now
  }

  List<Transaction> searchTransactions(String query) {
    final lowercaseQuery = query.toLowerCase();
    return transactions.where((transaction) {
      return transaction.category.toLowerCase().contains(lowercaseQuery) ||
          transaction.subtitle.toLowerCase().contains(lowercaseQuery) ||
          transaction.paidBy.toLowerCase().contains(lowercaseQuery) ||
          (transaction.notes?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  Map<String, double> getUserExpenseBreakdown(String userName) {
    Map<String, double> userExpenses = {};
    final userTransactions = getTransactionsByUser(userName);
    for (var transaction in userTransactions) {
      final amount = double.tryParse(
          transaction.amount.replaceAll('₹', '').replaceAll(',', '').replaceAll('-', '')) ??
          0.0;
      userExpenses[transaction.category] = (userExpenses[transaction.category] ?? 0.0) + amount;
    }
    return userExpenses;
  }
}