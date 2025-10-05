import 'package:teen_tigada/models/user_model.dart';

class ExpenseModel {
  final String id;
  final DateTime time;
  final String itemName;
  final double amount;
  final String categoryName;
  final String categoryIcon;
  final List<String> splitWith; // List of roommate names
  final String notes;
  final int colorIndex;
  final UserModel addedBy; // Complete user model of who added the expense
  final DateTime createdAt;

  ExpenseModel({
    required this.id,
    required this.time,
    required this.itemName,
    required this.amount,
    required this.categoryName,
    required this.categoryIcon,
    required this.splitWith,
    this.notes = '',
    required this.colorIndex,
    required this.addedBy,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Calculate split amount per person (including the person who paid)
  double get splitAmount => amount / (splitWith.length + 1);

  // Get total number of people splitting
  int get totalPeople => splitWith.length + 1;

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time.toIso8601String(),
      'itemName': itemName,
      'amount': amount,
      'categoryName': categoryName,
      'categoryIcon': categoryIcon,
      'splitWith': splitWith,
      'notes': notes,
      'colorIndex': colorIndex,
      'addedBy': addedBy.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      time: DateTime.parse(json['time']),
      itemName: json['itemName'],
      amount: json['amount'].toDouble(),
      categoryName: json['categoryName'],
      categoryIcon: json['categoryIcon'],
      splitWith: List<String>.from(json['splitWith']),
      notes: json['notes'] ?? '',
      colorIndex: json['colorIndex'],
      addedBy: UserModel.fromJson(json['addedBy']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Create a copy with modified fields
  ExpenseModel copyWith({
    String? id,
    DateTime? time,
    String? itemName,
    double? amount,
    String? categoryName,
    String? categoryIcon,
    List<String>? splitWith,
    String? notes,
    int? colorIndex,
    UserModel? addedBy,
    DateTime? createdAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      time: time ?? this.time,
      itemName: itemName ?? this.itemName,
      amount: amount ?? this.amount,
      categoryName: categoryName ?? this.categoryName,
      categoryIcon: categoryIcon ?? this.categoryIcon,
      splitWith: splitWith ?? this.splitWith,
      notes: notes ?? this.notes,
      colorIndex: colorIndex ?? this.colorIndex,
      addedBy: addedBy ?? this.addedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'ExpenseModel(id: $id, itemName: $itemName, amount: $amount, addedBy: ${addedBy.name})';
  }
}