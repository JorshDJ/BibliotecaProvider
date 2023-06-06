import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../providers/books_provider.dart';
// import '../models/book.dart';
// import '../widgets/book_list_item.dart';

import 'package:bibliotecaprovider/widgets/book_list_item.dart';
import 'package:bibliotecaprovider/models/book.dart';
import 'package:bibliotecaprovider/providers/books_provider.dart';

class BooksStudentsScreen extends StatefulWidget {
  @override
  _BooksStudentsScreenState createState() => _BooksStudentsScreenState();
}

class _BooksStudentsScreenState extends State<BooksStudentsScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libros'),
      ),
      body: Column(
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
              stream: Provider.of<BooksProvider>(context)
                  .getBooksStreamReservation(_searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final books = snapshot.data!;

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return BookListItem(
                      book: books[index],
                      onTap: () {
                        // Acción al seleccionar un libro
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
