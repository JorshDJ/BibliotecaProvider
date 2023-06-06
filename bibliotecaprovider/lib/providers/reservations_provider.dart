import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation.dart';

class ReservationProvider with ChangeNotifier {
  final CollectionReference _reservationsCollection =
      FirebaseFirestore.instance.collection('reservations');

  Stream<List<Reservation>> getReservationsStream() {
    return _reservationsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Reservation.fromDocument(doc);
      }).toList();
    });
  }

  Future<void> addReservation(Reservation reservation) async {
    await _reservationsCollection.add({
      'userId': reservation.userId,
      'bookId': reservation.bookId,
      'startDate': reservation.startDate,
      'endDate': reservation.endDate,
      'status': reservation.status,
      'quantityBook': reservation.quantityBook,
    });
  }

  Future<void> updateReservation(Reservation reservation) async {
    return _reservationsCollection.doc(reservation.reservationId).update({
      'userId': reservation.userId,
      'bookId': reservation.bookId,
      'startDate': reservation.startDate,
      'endDate': reservation.endDate,
      'status': reservation.status,
      'quantityBook': reservation.quantityBook,
    });
  }

  Future<void> deleteReservation(String id) async {
    return _reservationsCollection.doc(id).delete();
  }
}
