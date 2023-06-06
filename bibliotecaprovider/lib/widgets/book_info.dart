// import 'package:flutter/material.dart';
// import '../models/book.dart';

// class BookInfo extends StatelessWidget {
//   final Book book;

//   BookInfo({required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalles del libro'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Título: ${book.title}'),
//             Text('Autor: ${book.author}'),
//             // Agrega más detalles del libro aquí según tus necesidades
//             ElevatedButton(
//               onPressed: () {
//                 // Acción cuando se presiona el botón de reserva
//                 // Puedes agregar aquí la lógica para realizar la reserva del libro
//               },
//               child: Text('Reservar libro'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bibliotecaprovider/providers/reservations_provider.dart';
// import '../models/book.dart';
// import '../models/reservation.dart';

import 'package:bibliotecaprovider/models/book.dart';
import 'package:bibliotecaprovider/models/reservation.dart';

class BookInfo extends StatefulWidget {
  final Book book;

  BookInfo({required this.book});

  @override
  _BookInfoState createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  DateTime? startDate;
  DateTime? endDate;
  int quantityBook = 1;

  // void createReservation() {
  //   if (startDate != null && endDate != null) {
  //     final reservation = Reservation(
  //       reservationId: null,
  //       userId: 'user_id', // Reemplaza 'user_id' con el ID del usuario actual
  //       bookId: widget.book.bookId,
  //       startDate: startDate!,
  //       endDate: endDate!,
  //       status: 'pending',
  //       quantityBook: quantityBook,
  //     );

  //     final reservationProvider = ReservationProvider();
  //     reservationProvider.addReservation(reservation);

  //     // Mostrar un mensaje de éxito o realizar alguna acción adicional si es necesario

  //     Navigator.pop(context); // Cerrar la ventana flotante
  //   } else {
  //     // Mostrar un mensaje de error o realizar alguna acción si las fechas no están seleccionadas
  //   }
  // }

  void createReservation() async {
    if (startDate != null && endDate != null) {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String userId = user.uid;
        final reservation = Reservation(
          reservationId: null,
          userId: userId, // Reemplaza 'user_id' con el ID del usuario actual
          bookId: widget.book.bookId,
          startDate: startDate!,
          endDate: endDate!,
          status: 'pending',
          quantityBook: quantityBook,
        );

        final reservationProvider = ReservationProvider();
        await reservationProvider.addReservation(reservation);

        final bookProvider = BooksProvider();

        // Obtener el libro actual de la base de datos
        final currentBook = await bookProvider.getBookById(widget.book.bookId);

        // Actualizar la cantidad de libros disponibles
        final updatedAvailableCopies =
            currentBook.availableCopies - quantityBook;
        final updatedBook = currentBook.copyWith(
          availableCopies: updatedAvailableCopies,
        );
        await bookProvider.updateBook(updatedBook);

        // Mostrar un mensaje de éxito o realizar alguna acción adicional si es necesario

        Navigator.pop(context);
      }
      // Cerrar la ventana flotante
    } else {
      // Mostrar un mensaje de error o realizar alguna acción si las fechas no están seleccionadas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del libro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Título: ${widget.book.title}'),
            Text('Autor: ${widget.book.author}'),
            Text('Category: ${widget.book.category}'),
            Text('Descripción: ${widget.book.description}'),
            Text('Copias disponibles: ${widget.book.availableCopies}'),
            Text('Copias totales: ${widget.book.totalCopies}'),

            // Agrega más detalles del libro aquí según tus necesidades

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Crear reserva'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              'Selecciona las fechas y la cantidad de libros:'),
                          DatePicker(
                            initialDate: DateTime.now(),
                            onSelectedDate: (date) {
                              setState(() {
                                startDate = date;
                              });
                            },
                          ),
                          DatePicker(
                            initialDate: DateTime.now(),
                            onSelectedDate: (date) {
                              setState(() {
                                endDate = date;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          Text('Cantidad de libros:'),
                          Text('$quantityBook')

                          // Slider(
                          //   min: 1,
                          //   max: 10,
                          //   value: quantityBook.toDouble(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       quantityBook = value.toInt();
                          //     });
                          //   },
                          // ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: createReservation,
                          child: Text('Reservar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Reservar libro'),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime>? onSelectedDate;

  DatePicker({required this.initialDate, required this.onSelectedDate});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: initialDate,
        onDateTimeChanged: (DateTime? newDateTime) {
          if (newDateTime != null && onSelectedDate != null) {
            onSelectedDate!(newDateTime);
          }
        },
      ),
    );
  }
}
