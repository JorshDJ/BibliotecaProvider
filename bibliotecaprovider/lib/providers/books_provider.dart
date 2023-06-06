import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../../models/book.dart';

import 'package:bibliotecaprovider/models/book.dart';

class BooksProvider extends ChangeNotifier {
  final _booksCollection = FirebaseFirestore.instance.collection('books');

  Stream<List<Book>> getBooksStream() {
    return _booksCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromDocumentSnapshot(doc)).toList());
  }

  Future<void> addBook(Book book) async {
    await _booksCollection.add(book.toMap());
  }

  Future<void> updateBook(Book book) async {
    await _booksCollection.doc(book.bookId).update(book.toMap());
  }

  Future<void> deleteBook(String bookId) async {
    await _booksCollection.doc(bookId).delete();
  }

  Future<List<Book>> getBooksByTitleOrAuthor(String query) async {
    final snapshot = await _booksCollection.get();
    final books =
        snapshot.docs.map((doc) => Book.fromDocumentSnapshot(doc)).toList();

    final filteredBooks = books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredBooks;
  }
  // Future<Iterable<Book>> getBooksByTitleOrAuthor(String query) async {
  //   final snapshot = await _booksCollection.get();
  //   final books =
  //       snapshot.docs.map((doc) => Book.fromDocumentSnapshot(doc)).toList();

  //   final filteredBooks = books.where((book) =>
  //       book.title.toLowerCase().contains(query.toLowerCase()) ||
  //       book.author.toLowerCase().contains(query.toLowerCase()));

  //   return filteredBooks;
  // }

  Stream<List<Book>> getBooksStreamReservation(String query) {
    return _booksCollection.snapshots().map((snapshot) {
      final books =
          snapshot.docs.map((doc) => Book.fromDocumentSnapshot(doc)).toList();

      if (query.isEmpty) {
        return books;
      } else {
        final filteredBooks = books
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()) ||
                book.author.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return filteredBooks;
      }
    });
  }

  Future<Book> getBookById(String bookId) async {
    final snapshot = await _booksCollection.doc(bookId).get();
    return Book.fromDocumentSnapshot(snapshot);
  }
}
