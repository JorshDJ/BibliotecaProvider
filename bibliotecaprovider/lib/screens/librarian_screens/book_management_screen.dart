import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../providers/books_provider.dart';
// import '../../models/book.dart';
// import '../../widgets/book_list_item.dart';
// import 'book_edit_screen.dart';

import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:bibliotecaprovider/models/book.dart';
import 'package:bibliotecaprovider/widgets/book_list_item.dart';
import 'book_edit_screen.dart';

class BookManagementScreen extends StatefulWidget {
  @override
  _BookManagementScreenState createState() => _BookManagementScreenState();
}

class _BookManagementScreenState extends State<BookManagementScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de libros'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla de creación de libros
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookEditScreen(),
                ),
              );
            },
          ),
        ],
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
                    return BookListItem(
                      book: books[index],
                      onTap: () {
                        // Navegar a la pantalla de edición de libros
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                BookEditScreen(book: books[index]),
                          ),
                        );
                      },
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirmar eliminación'),
                            content: Text(
                                '¿Estás seguro de que deseas eliminar este libro?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text('Sí'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text('No'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          Provider.of<BooksProvider>(context, listen: false)
                              .deleteBook(books[index].bookId);
                        }
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
