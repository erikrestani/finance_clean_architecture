enum TransactionType { credit, debit }

class Transaction {
  final String id;
  final double amount;
  final String description;
  final TransactionType type;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'type': type.name,
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      date: DateTime.parse(json['date'] as String),
    );
  }
}
