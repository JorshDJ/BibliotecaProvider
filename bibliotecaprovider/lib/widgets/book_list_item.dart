import 'package:bibliotecaprovider/widgets/book_info.dart';
import 'package:flutter/material.dart';
//import '../models/book.dart';

import 'package:bibliotecaprovider/models/book.dart';

// class BookListItem extends StatelessWidget {
//   final Book book;
//   final Function onTap;
//   final Function? onDelete;

//   BookListItem({required this.book, required this.onTap, this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(book.title),
//       subtitle: Text(book.author),
//       leading: book.coverImageUrl != null && book.coverImageUrl.isNotEmpty
//           ? Image.network(book.coverImageUrl, fit: BoxFit.cover)
//           : Icon(Icons.book),
//       onTap: () => onTap(),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () => onDelete!(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

// class BookListItem extends StatelessWidget {
//   final Book book;
//   final Function onTap;
//   final Function? onDelete;

//   BookListItem({required this.book, required this.onTap, this.onDelete});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(book.title),
//       subtitle: Text(book.author),
//       leading: book.coverImageUrl != null && book.coverImageUrl.isNotEmpty
//           ? Image.network(book.coverImageUrl, fit: BoxFit.cover)
//           : Icon(Icons.book),
//       onTap: () => onTap(),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (onDelete != null)
//             IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () => onDelete!(),
//             ),
//         ],
//       ),
//     );
//   }
// }

class BookListItem extends StatelessWidget {
  final Book book;
  final Function onTap;
  final Function? onDelete;

  BookListItem({required this.book, required this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.author),
      leading: book.coverImageUrl != null && book.coverImageUrl.isNotEmpty
          ? Image.network(book.coverImageUrl, fit: BoxFit.cover)
          : Icon(Icons.book),
      onTap: () => onTap(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onDelete != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onDelete!(),
            ),
          if (onDelete == null)
            IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                // Acción cuando se presiona el ícono de ver
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookInfo(book: book)));
              },
            ),
        ],
      ),
    );
  }
}
