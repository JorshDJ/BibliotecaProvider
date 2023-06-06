import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

// import '../../models/book.dart';
// import '../../models/loan.dart';
// //import 'loan_edit_form.dart';
// import '../../models/usuario.dart';
// import '../../providers/books_provider.dart';
// import '../../providers/loans_provider.dart';
// import '../../providers/users_provider.dart';

import 'package:bibliotecaprovider/models/book.dart';
import 'package:bibliotecaprovider/models/loan.dart';
import 'package:bibliotecaprovider/models/usuario.dart';
import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:bibliotecaprovider/providers/loans_provider.dart';
import 'package:bibliotecaprovider/providers/users_provider.dart';

// import '../../widgets/loan_edit_form.dart';
// import '../../widgets/book_search.dart';
// import '../../widgets/user_search.dart';

// class LoanEditScreen extends StatefulWidget {
//   final Loan? loan;

//   LoanEditScreen({this.loan});

//   @override
//   _LoanEditScreenState createState() => _LoanEditScreenState();
// }

// class _LoanEditScreenState extends State<LoanEditScreen> {
//   String? _selectedUserId;
//   String? _selectedBookId;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crear préstamo'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Text('Seleccionar usuario'),
//             SizedBox(height: 10),
//             SizedBox(
//               height: 150,
//               child: UserSearch(
//                 onUserSelected: (userId) {
//                   setState(() {
//                     _selectedUserId = userId;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Text('Seleccionar libro'),
//             SizedBox(height: 10),
//             SizedBox(
//               height: 150,
//               child: BookSearch(
//                 onBookSelected: (bookId) {
//                   setState(() {
//                     _selectedBookId = bookId;
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             LoanEditForm(
//               userId: _selectedUserId ?? '',
//               bookId: _selectedBookId ?? '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoanEditScreen extends StatefulWidget {
  final Loan? loan;

  LoanEditScreen({this.loan});

  @override
  _ReservationEditScreenState createState() => _ReservationEditScreenState();
}

class _ReservationEditScreenState extends State<LoanEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _userIdController;
  late TextEditingController _bookIdController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _quantityBookController;
  List<Book> _suggestedBooks = [];
  TextEditingController _bookSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Inicializar los controladores de texto con los valores de la reserva (si existe)
    _userIdController = TextEditingController(text: widget.loan?.userId ?? '');
    _bookIdController = TextEditingController(text: widget.loan?.bookId ?? '');
    _startDateController =
        TextEditingController(text: widget.loan?.startDate.toString() ?? '');
    _endDateController =
        TextEditingController(text: widget.loan?.dueDate.toString() ?? '');
    _quantityBookController =
        TextEditingController(text: widget.loan?.quantity.toString() ?? '');
  }

  @override
  void dispose() {
    // Liberar los recursos de los controladores de texto
    _userIdController.dispose();
    _bookIdController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _quantityBookController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final userId = _userIdController.text;
    final bookId = _bookIdController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);
    final quantityBook = int.parse(_quantityBookController.text);

    if (widget.loan != null) {
      // Actualizar la reserva existente
      final updatedLoan = widget.loan!.copyWith(
        userId: userId,
        bookId: bookId,
        startDate: startDate,
        dueDate: endDate,
        quantity: quantityBook,
      );
      Provider.of<LoansProvider>(context, listen: false)
          .updateLoan(updatedLoan);
    } else {
      // Crear una nueva reserva
      final newLoan = Loan(
        loanId: null,
        userId: userId,
        bookId: bookId,
        startDate: startDate,
        dueDate: endDate,
        quantity: quantityBook,
      );
      Provider.of<LoansProvider>(context, listen: false).addLoan(newLoan);

      // Restar la cantidad de libros reservados de availableCopies
      final booksProvider = Provider.of<BooksProvider>(context, listen: false);
      final book = await booksProvider.getBookById(bookId);
      if (book != null) {
        final updatedBook = book.copyWith(
          availableCopies: book.availableCopies - quantityBook,
        );
        await booksProvider.updateBook(updatedBook);
      }
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.loan != null ? 'Editar Prestamo' : 'Crear Préstamo',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FutureBuilder<List<Usuario>>(
                future: Provider.of<UsersProvider>(context).getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final users = snapshot.data ?? [];

                    return TypeAheadFormField<Usuario>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _userIdController,
                        decoration: InputDecoration(
                          labelText: 'ID de usuario',
                          hintText: 'Buscar usuario',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return users.where(
                          (user) =>
                              user.name!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()) ||
                              user.email!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()),
                        );
                      },
                      itemBuilder: (context, user) {
                        return ListTile(
                          title: Text(user.name!),
                          subtitle: Text(user.email!),
                        );
                      },
                      onSuggestionSelected: (user) {
                        _userIdController.text = user.uid!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, ingresa el ID de usuario';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              TypeAheadFormField<Book>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _bookIdController,
                  decoration: InputDecoration(
                    labelText: 'ID de libro',
                    hintText: 'Buscar libro',
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  final booksProvider =
                      Provider.of<BooksProvider>(context, listen: false);
                  final books =
                      await booksProvider.getBooksByTitleOrAuthor(pattern);
                  return books;
                },
                itemBuilder: (context, book) {
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  );
                },
                onSuggestionSelected: (book) {
                  _bookIdController.text = book.bookId;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa el ID de libro';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2100, 12, 31),
                    onChanged: (date) {},
                    onConfirm: (date) {
                      _startDateController.text = date.toString();
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de inicio',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la fecha de inicio';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime(2000, 1, 1),
                    maxTime: DateTime(2100, 12, 31),
                    onChanged: (date) {},
                    onConfirm: (date) {
                      _endDateController.text = date.toString();
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      labelText: 'Fecha de fin',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa la fecha de fin';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: _quantityBookController,
                decoration: InputDecoration(labelText: 'Cantidad de libros'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa la cantidad de libros';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
