import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation {
  final String? reservationId;
  final String userId;
  final String bookId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int quantityBook; // Agregado el campo quantityBook

  Reservation({
    required this.reservationId,
    required this.userId,
    required this.bookId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.quantityBook, // Agregado el campo quantityBook
  });

  factory Reservation.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return Reservation(
      reservationId: document.id,
      userId: data['userId'],
      bookId: data['bookId'],
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      status: data['status'],
      quantityBook: data['quantityBook'], // Agregado el campo quantityBook
    );
  }

  Reservation copyWith({
    String? reservationId,
    String? userId,
    String? bookId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int? quantityBook, // Agregado el campo quantityBook
  }) {
    return Reservation(
      reservationId: reservationId ?? this.reservationId,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      quantityBook:
          quantityBook ?? this.quantityBook, // Agregado el campo quantityBook
    );
  }
}
