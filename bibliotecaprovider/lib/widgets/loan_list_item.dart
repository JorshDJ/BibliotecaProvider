import 'package:flutter/material.dart';

//import '../models/loan.dart';
import 'package:bibliotecaprovider/models/loan.dart';

class LoanListItem extends StatelessWidget {
  final Loan loan;
  final Function onTap;
  final Function? onDelete;

  LoanListItem({required this.loan, required this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Préstamo: ${loan.loanId}'),
      subtitle: Text(
          'Usuario: ${loan.userId}\nLibro: ${loan.bookId}\nFecha de inicio: ${loan.startDate}'),
      onTap: () => onTap(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onTap(),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete!(),
          ),
        ],
      ),
    );
  }
}
