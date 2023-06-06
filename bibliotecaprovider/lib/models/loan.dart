import 'package:cloud_firestore/cloud_firestore.dart';

class Loan {
  final String? loanId;
  final String userId;
  final String bookId;
  final DateTime startDate;
  final DateTime dueDate;
  final DateTime? returnDate;
  final int quantity;

  Loan({
    required this.loanId,
    required this.userId,
    required this.bookId,
    required this.startDate,
    required this.dueDate,
    required this.quantity,
    this.returnDate,
  });

  factory Loan.fromDocument(Map<String, dynamic> document) {
    return Loan(
      loanId: document['loanId'],
      userId: document['userId'],
      bookId: document['bookId'],
      quantity: document['quantity'],
      startDate: DateTime.fromMillisecondsSinceEpoch(
          document['startDate'].seconds * 1000),
      dueDate: DateTime.fromMillisecondsSinceEpoch(
          document['dueDate'].seconds * 1000),
      returnDate: document['returnDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              document['returnDate'].seconds * 1000)
          : null,
    );
  }

  //Método copywith
  Loan copyWith({
    String? loanId,
    String? userId,
    String? bookId,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? returnDate,
    int? quantity,
  }) {
    return Loan(
      loanId: loanId ?? this.loanId,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
      returnDate: returnDate ?? this.returnDate,
      quantity: quantity ?? this.quantity,
    );
  }
}
