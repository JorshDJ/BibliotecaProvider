// lib/widgets/book_search.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../providers/books_provider.dart';
// import '../models/book.dart';

import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:bibliotecaprovider/models/book.dart';

typedef OnBookSelected = void Function(String bookId);

class BookSearch extends StatefulWidget {
  final OnBookSelected onBookSelected;

  BookSearch({required this.onBookSelected});

  @override
  _BookSearchState createState() => _BookSearchState();
}

class _BookSearchState extends State<BookSearch> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Buscar libro',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Book>>(
            stream: Provider.of<BooksProvider>(context).getBooksStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final books = snapshot.data!
                  .where((book) => book.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  .toList();

              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(books[index].title),
                    subtitle: Text(books[index].author),
                    onTap: () {
                      widget.onBookSelected(books[index].bookId);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
