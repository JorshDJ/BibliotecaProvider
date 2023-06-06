import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../models/loan.dart';
// import '../../providers/loans_provider.dart';

import 'package:bibliotecaprovider/models/loan.dart';
import 'package:bibliotecaprovider/providers/loans_provider.dart';

class LoanEditForm extends StatefulWidget {
  final String userId;
  final String bookId;

  LoanEditForm({required this.userId, required this.bookId});

  @override
  _LoanEditFormState createState() => _LoanEditFormState();
}

class _LoanEditFormState extends State<LoanEditForm> {
  DateTime? _startDate;
  DateTime? _dueDate;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              if (_startDate != null &&
                  _dueDate != null &&
                  // widget.userId!.isNotEmpty &&
                  widget.userId != null &&
                  // widget.bookId!.isNotEmpty) {
                  widget.bookId != null) {
                await Provider.of<LoansProvider>(context, listen: false)
                    .addLoan(
                  Loan(
                    loanId: '',
                    userId: widget.userId!,
                    bookId: widget.bookId!,
                    startDate: _startDate!,
                    dueDate: _dueDate!,
                    quantity: _quantity,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
            child: Text('Guardar'),
          ),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((date) {
                if (date != null) {
                  setState(() {
                    _startDate = date;
                  });
                }
              });
            },
            child: Text(_startDate != null
                ? 'Fecha de inicio: ${_startDate.toString()}'
                : 'Seleccione la fecha de inicio'),
          ),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((date) {
                if (date != null) {
                  setState(() {
                    _dueDate = date;
                  });
                }
              });
            },
            child: Text(_dueDate != null
                ? 'Fecha de vencimiento: ${_dueDate.toString()}'
                : 'Seleccione la fecha de vencimiento'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Cantidad de libros: '),
                DropdownButton<int>(
                  value: _quantity,
                  onChanged: (int? newValue) {
                    setState(() {
                      _quantity = newValue!;
                    });
                  },
                  items: List<int>.generate(10, (index) => index + 1)
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
