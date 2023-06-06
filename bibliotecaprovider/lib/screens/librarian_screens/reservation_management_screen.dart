import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../providers/reservations_provider.dart';
// import '../../models/reservation.dart';
// import '../../widgets/reservation_list_item.dart';
// import 'reservation_edit_screen.dart';

import 'package:bibliotecaprovider/providers/reservations_provider.dart';
import 'package:bibliotecaprovider/models/reservation.dart';
import 'package:bibliotecaprovider/widgets/reservation_list_item.dart';
import 'reservation_edit_screen.dart';

// class ReservationManagementScreen extends StatefulWidget {
//   @override
//   _ReservationManagementScreenState createState() =>
//       _ReservationManagementScreenState();
// }

// class _ReservationManagementScreenState
//     extends State<ReservationManagementScreen> {
//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gestión de reservas'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Navegar a la pantalla de creación de reservas
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ReservationEditScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Buscar reserva',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<Reservation>>(
//               stream: Provider.of<ReservationProvider>(context)
//                   .getReservationsStream(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final reservations = snapshot.data!
//                     .where((reservation) =>
//                         reservation.reservationId!
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()) ||
//                         reservation.userId
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()) ||
//                         reservation.bookId
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()))
//                     .toList();

//                 return ListView.builder(
//                   itemCount: reservations.length,
//                   itemBuilder: (context, index) {
//                     return ReservationListItem(
//                       reservation: reservations[index],
//                       onTap: () {
//                         // Navegar a la pantalla de edición de reservas
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => ReservationEditScreen(
//                                 reservation: reservations[index]),
//                           ),
//                         );
//                       },
//                       onDelete: () {
//                         // Eliminar la reserva
//                         showDialog(
//                           context: context,
//                           builder: (ctx) => AlertDialog(
//                             title: Text('Eliminar reserva'),
//                             content: Text(
//                                 '¿Está seguro de que desea eliminar esta reserva?'),
//                             actions: <Widget>[
//                               ElevatedButton(
//                                 child: Text('No'),
//                                 onPressed: () {
//                                   Navigator.of(ctx).pop();
//                                 },
//                               ),
//                               ElevatedButton(
//                                 child: Text('Sí'),
//                                 onPressed: () {
//                                   Provider.of<ReservationProvider>(context,
//                                           listen: false)
//                                       .deleteReservation(
//                                           reservations[index].reservationId!);
//                                   Navigator.of(ctx).pop();
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ReservationManagementScreen extends StatefulWidget {
  @override
  _ReservationManagementScreenState createState() =>
      _ReservationManagementScreenState();
}

class _ReservationManagementScreenState
    extends State<ReservationManagementScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de reservas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla de creación de reservas
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReservationEditScreen(),
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
                labelText: 'Buscar reserva',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Reservation>>(
              stream: Provider.of<ReservationProvider>(context)
                  .getReservationsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final reservations = snapshot.data!
                    .where((reservation) =>
                        reservation.reservationId!
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()) ||
                        reservation.userId
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()) ||
                        reservation.bookId
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                    .toList();
                return ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    return ReservationListItem(
                      reservation: reservations[index],
                      onTap: () {
                        // Navegar a la pantalla de edición de reservas
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReservationEditScreen(
                              reservation: reservations[index],
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        // Eliminar la reserva
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
                                  final booksProvider =
                                      Provider.of<BooksProvider>(context,
                                          listen: false);
                                  final reservation = reservations[index];
                                  final bookId = reservation.bookId;

                                  // Obtener el libro correspondiente al ID
                                  final book =
                                      await booksProvider.getBookById(bookId);

                                  // Calcular la nueva cantidad de libros disponibles
                                  final newAvailableCopies =
                                      book.availableCopies +
                                          reservation.quantityBook;

                                  // Actualizar la cantidad de libros disponibles en la base de datos
                                  final updatedBook = book.copyWith(
                                      availableCopies: newAvailableCopies);
                                  await booksProvider.updateBook(updatedBook);

                                  // Eliminar la reserva
                                  await reservationProvider.deleteReservation(
                                      reservation.reservationId!);

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
          ),
        ],
      ),
    );
  }
}
