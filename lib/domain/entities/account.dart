import 'package:flutter/material.dart';

enum AccountType { debit, credit, savings, investment }

class Account {
  final String id;
  final String name;
  final double balance;
  final Color color;
  final IconData iconData;
  final AccountType accountType;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.color,
    required this.iconData,
    required this.accountType,
    required this.createdAt,
    required this.updatedAt,
  });

  Account copyWith({
    String? id,
    String? name,
    double? balance,
    Color? color,
    IconData? iconData,
    AccountType? accountType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      color: color ?? this.color,
      iconData: iconData ?? this.iconData,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'color': color.toARGB32(),
      'iconData': iconData.codePoint,
      'accountType': accountType.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      name: json['name'] as String,
      balance: (json['balance'] as num).toDouble(),
      color: Color(json['color'] as int),
      iconData: IconData(json['iconData'] as int, fontFamily: 'MaterialIcons'),
      accountType: AccountType.values[json['accountType'] as int],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Account &&
        other.id == id &&
        other.name == name &&
        other.balance == balance &&
        other.color == color &&
        other.iconData.codePoint == iconData.codePoint &&
        other.accountType == accountType;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      balance,
      color,
      iconData.codePoint,
      accountType,
    );
  }

  @override
  String toString() {
    return 'Account(id: $id, name: $name, balance: $balance, color: $color, accountType: $accountType)';
  }
}
