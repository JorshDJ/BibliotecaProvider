import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bibliotecaprovider/models/book.dart';

//import '../../models/book.dart';
import 'package:bibliotecaprovider/providers/books_provider.dart';
//import '../../providers/books_provider.dart';

import 'package:bibliotecaprovider/widgets/book_edit_form.dart';
//import '../../widgets/book_edit_form.dart';

class BookEditScreen extends StatelessWidget {
  final Book? book;

  BookEditScreen({this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book == null ? 'Agregar libro' : 'Editar libro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BookEditForm(
            book: book,
            onSave: (title, author, isbn, category, description, coverImageUrl,
                availableCopies, totalCopies) {
              Book updatedBook = Book(
                bookId: book?.bookId ?? '',
                title: title,
                author: author,
                isbn: isbn,
                category: category,
                description: description,
                coverImageUrl: coverImageUrl,
                availableCopies: availableCopies,
                totalCopies: totalCopies,
              );

              if (book == null) {
                Provider.of<BooksProvider>(context, listen: false)
                    .addBook(updatedBook);
              } else {
                Provider.of<BooksProvider>(context, listen: false)
                    .updateBook(updatedBook);
              }

              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
