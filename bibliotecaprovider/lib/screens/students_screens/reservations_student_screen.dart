import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../../providers/reservations_provider.dart';
// import '../../models/reservation.dart';
// import '../../widgets/reservation_list_item.dart';

import 'package:bibliotecaprovider/providers/reservations_provider.dart';
import 'package:bibliotecaprovider/models/reservation.dart';
import 'package:bibliotecaprovider/widgets/reservation_list_item.dart';

// class ReservationsStudentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final User? user = FirebaseAuth.instance.currentUser;
//     final String userId = user!.uid;

//     // final userId =
//     //     'ID_DEL_USUARIO_ACTUAL'; // Reemplaza con el ID del usuario actual

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mis Reservaciones'),
//       ),
//       body: StreamBuilder<List<Reservation>>(
//         stream:
//             Provider.of<ReservationProvider>(context).getReservationsStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final reservations = snapshot.data
//               ?.where((reservation) => reservation.userId == userId)
//               .toList();

//           if (reservations == null || reservations.isEmpty) {
//             return Center(child: Text('No se encontraron reservas.'));
//           }

//           reservations.sort((a, b) => a.startDate.compareTo(b.startDate));

//           return ListView.builder(
//             itemCount: reservations.length,
//             itemBuilder: (context, index) {
//               return ReservationListItem(
//                 reservation: reservations[index],
//                 onTap: () {
//                   // Implementa la acción al hacer clic en una reserva
//                 },
//                 onDelete: () {
//                   // Implementa la acción al eliminar una reserva
//                   showDialog(
//                     context: context,
//                     builder: (ctx) => AlertDialog(
//                       title: Text('Eliminar reserva'),
//                       content: Text(
//                           '¿Está seguro de que desea eliminar esta reserva?'),
//                       actions: <Widget>[
//                         ElevatedButton(
//                           child: Text('No'),
//                           onPressed: () {
//                             Navigator.of(ctx).pop();
//                           },
//                         ),
//                         ElevatedButton(
//                           child: Text('Sí'),
//                           onPressed: () {
//                             Provider.of<ReservationProvider>(context,
//                                     listen: false)
//                                 .deleteReservation(
//                                     reservations[index].reservationId!);
//                             Navigator.of(ctx).pop();
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class ReservationsStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Reservaciones'),
      ),
      body: StreamBuilder<List<Reservation>>(
        stream:
            Provider.of<ReservationProvider>(context).getReservationsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final reservations = snapshot.data
              ?.where((reservation) => reservation.userId == userId)
              .toList();

          if (reservations == null || reservations.isEmpty) {
            return Center(child: Text('No se encontraron reservas.'));
          }

          reservations.sort((a, b) => a.startDate.compareTo(b.startDate));

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              return ReservationListItem(
                reservation: reservations[index],
                onTap: () {
                  // Implementa la acción al hacer clic en una reserva
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Eliminar reserva'),
                      content: Text(
                          '¿Está seguro de que desea eliminar esta reserva?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        ElevatedButton(
                          child: Text('Sí'),
                          onPressed: () async {
                            final reservationProvider =
                                Provider.of<ReservationProvider>(context,
                                    listen: false);
                            final booksProvider = Provider.of<BooksProvider>(
                                context,
                                listen: false);
                            final reservation = reservations[index];
                            final bookId = reservation.bookId;

                            // Obtener el libro correspondiente al ID
                            final book =
                                await booksProvider.getBookById(bookId);

                            // Calcular la nueva cantidad de libros disponibles
                            final newAvailableCopies =
                                book.availableCopies + reservation.quantityBook;

                            // Actualizar la cantidad de libros disponibles en la base de datos
                            final updatedBook = book.copyWith(
                                availableCopies: newAvailableCopies);
                            await booksProvider.updateBook(updatedBook);

                            // Eliminar la reserva
                            await reservationProvider
                                .deleteReservation(reservation.reservationId!);

                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
