import 'package:flutter/material.dart';

enum TransactionCategory {
  food('Food', Icons.restaurant),
  transport('Transport', Icons.directions_car),
  entertainment('Entertainment', Icons.movie),
  shopping('Shopping', Icons.shopping_bag),
  bills('Bills', Icons.receipt),
  health('Health', Icons.medical_services),
  education('Education', Icons.school),
  travel('Travel', Icons.flight),
  groceries('Groceries', Icons.shopping_cart),
  coffee('Coffee', Icons.coffee),
  other('Other', Icons.more_horiz);

  const TransactionCategory(this.label, this.icon);

  final String label;
  final IconData icon;

  static TransactionCategory fromString(String value) {
    return TransactionCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => TransactionCategory.other,
    );
  }
}
