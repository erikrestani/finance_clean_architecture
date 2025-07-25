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
}
