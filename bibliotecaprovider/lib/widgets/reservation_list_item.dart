import 'package:flutter/material.dart';

//import '../models/reservation.dart';

import 'package:bibliotecaprovider/models/reservation.dart';

class ReservationListItem extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ReservationListItem({
    required this.reservation,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reservation.reservationId ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Usuario: ${reservation.userId}'),
          Text('Libro: ${reservation.bookId}'),
          Text('Estado: ${reservation.status}'),
        ],
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed:
            //
            onDelete,
      ),
    );
  }
}
