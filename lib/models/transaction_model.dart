import 'package:get/get.dart';

class Transaction {
  String? id;
  String icon;
  String title;
  String subtitle;
  String amount;
  String time;
  bool isExpense;
  int colorIndex;
  String paidBy;
  String category;
  String? notes;
  List<String>? sharedWith;
  bool? isFixed;
  bool? isElectricity;
  String? fixedExpenseId;
  bool? isSettlement;
  String? settlementId;
  String? readingId;

  Transaction({
    this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.isExpense,
    required this.colorIndex,
    required this.paidBy,
    required this.category,
    this.notes,
    this.sharedWith,
    this.isFixed = false,
    this.isElectricity = false,
    this.fixedExpenseId,
    this.isSettlement = false,
    this.settlementId,
    this.readingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 'trans_${DateTime.now().millisecondsSinceEpoch}',
      'icon': icon,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'time': time,
      'isExpense': isExpense,
      'colorIndex': colorIndex,
      'paidBy': paidBy,
      'category': category,
      'notes': notes,
      'sharedWith': sharedWith,
      'isFixed': isFixed,
      'isElectricity': isElectricity,
      'fixedExpenseId': fixedExpenseId,
      'isSettlement': isSettlement,
      'settlementId': settlementId,
      'readingId': readingId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String?,
      icon: map['icon'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      amount: map['amount'] as String,
      time: map['time'] as String,
      isExpense: map['isExpense'] as bool,
      colorIndex: map['colorIndex'] as int,
      paidBy: map['paidBy'] as String,
      category: map['category'] as String,
      notes: map['notes'] as String?,
      sharedWith: map['sharedWith'] != null ? List<String>.from(map['sharedWith']) : null,
      isFixed: map['isFixed'] as bool? ?? false,
      isElectricity: map['isElectricity'] as bool? ?? false,
      fixedExpenseId: map['fixedExpenseId'] as String?,
      isSettlement: map['isSettlement'] as bool? ?? false,
      settlementId: map['settlementId'] as String?,
      readingId: map['readingId'] as String?,
    );
  }
}