// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/loan.dart';

// class LoansProvider with ChangeNotifier {
//   final _firestore = FirebaseFirestore.instance;

//   Stream<List<Loan>> getLoansStream() {
//     return _firestore.collection('loans').snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => Loan.fromDocument(doc.data())).toList());
//   }

//   Future<void> addLoan(Loan loan) async {
//     await _firestore.collection('loans').add({
//       'loanId': loan.loanId,
//       'userId': loan.userId,
//       'bookId': loan.bookId,
//       'startDate': Timestamp.fromDate(loan.startDate),
//       'dueDate': Timestamp.fromDate(loan.dueDate),
//       'returnDate':
//           loan.returnDate != null ? Timestamp.fromDate(loan.returnDate!) : null,
//     });
//     notifyListeners();
//   }

//   Future<void> updateLoan(Loan loan) async {
//     await _firestore.collection('loans').doc(loan.loanId).update({
//       'userId': loan.userId,
//       'bookId': loan.bookId,
//       'startDate': Timestamp.fromDate(loan.startDate),
//       'dueDate': Timestamp.fromDate(loan.dueDate),
//       'returnDate':
//           loan.returnDate != null ? Timestamp.fromDate(loan.returnDate!) : null,
//     });
//     notifyListeners();
//   }

//   Future<void> deleteLoan(String loanId) async {
//     await _firestore.collection('loans').doc(loanId).delete();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/loan.dart';

class LoansProvider with ChangeNotifier {
  final CollectionReference _loansCollection =
      FirebaseFirestore.instance.collection('loans');

  Stream<List<Loan>> getLoansStream() {
    return _loansCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Loan(
          loanId: doc.id,
          userId: data['userId'],
          bookId: data['bookId'],
          startDate: (data['startDate'] as Timestamp).toDate(),
          dueDate: (data['dueDate'] as Timestamp).toDate(),
          returnDate: data['returnDate'] != null
              ? (data['returnDate'] as Timestamp).toDate()
              : null,
          quantity: data['quantity'],
        );
      }).toList();
    });
  }

  Future<void> addLoan(Loan loan) async {
    await _loansCollection.add({
      'userId': loan.userId,
      'bookId': loan.bookId,
      'startDate': loan.startDate,
      'dueDate': loan.dueDate,
      'returnDate': loan.returnDate,
      'quantity': loan.quantity,
    });
  }

  Future<void> updateLoan(Loan loan) async {
    return _loansCollection.doc(loan.loanId).update({
      'userId': loan.userId,
      'bookId': loan.bookId,
      'startDate': loan.startDate,
      'dueDate': loan.dueDate,
      'returnDate': loan.returnDate,
      'quantity': loan.quantity,
    });
  }

  Future<void> deleteLoan(String id) async {
    return _loansCollection.doc(id).delete();
  }
}
