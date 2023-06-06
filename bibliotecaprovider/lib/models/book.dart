import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String bookId;
  final String title;
  final String author;
  final String isbn;
  final String category;
  final String description;
  final String coverImageUrl;
  final int availableCopies;
  final int totalCopies;

  Book({
    required this.bookId,
    required this.title,
    required this.author,
    required this.isbn,
    required this.category,
    required this.description,
    required this.coverImageUrl,
    required this.availableCopies,
    required this.totalCopies,
  });

  static Book fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Book(
      bookId: snapshot.id,
      // bookId: data['bookId'] ?? '', //lo que estoy agregando
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      isbn: data['isbn'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      coverImageUrl: data['coverImageUrl'] ?? '',
      availableCopies: data['availableCopies'] ?? 0,
      totalCopies: data['totalCopies'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'isbn': isbn,
      'category': category,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'availableCopies': availableCopies,
      'totalCopies': totalCopies,
    };
  }

  Book copyWith({
    String? bookId,
    String? title,
    String? author,
    String? isbn,
    String? category,
    String? description,
    String? coverImageUrl,
    int? availableCopies,
    int? totalCopies,
  }) {
    return Book(
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      author: author ?? this.author,
      isbn: isbn ?? this.isbn,
      category: category ?? this.category,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      availableCopies: availableCopies ?? this.availableCopies,
      totalCopies: totalCopies ?? this.totalCopies,
    );
  }
}
