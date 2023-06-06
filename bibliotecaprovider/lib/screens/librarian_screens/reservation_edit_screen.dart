import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

// import '../../models/loan.dart';
// import '../../providers/loans_provider.dart';
// import '../../providers/reservations_provider.dart';
// import '../../models/reservation.dart';
// import '../../providers/users_provider.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:bibliotecaprovider/models/loan.dart';
import 'package:bibliotecaprovider/providers/loans_provider.dart';
import 'package:bibliotecaprovider/providers/reservations_provider.dart';
import 'package:bibliotecaprovider/models/reservation.dart';
import 'package:bibliotecaprovider/providers/users_provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class ReservationEditScreen extends StatefulWidget {
//   final Reservation? reservation;

//   ReservationEditScreen({this.reservation});

//   @override
//   _ReservationEditScreenState createState() => _ReservationEditScreenState();
// }

// class _ReservationEditScreenState extends State<ReservationEditScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _userIdController;
//   late TextEditingController _bookIdController;
//   late TextEditingController _startDateController;
//   late TextEditingController _endDateController;

//   @override
//   void initState() {
//     super.initState();

//     // Inicializar los controladores de texto con los valores de la reserva (si existe)
//     _userIdController =
//         TextEditingController(text: widget.reservation?.userId ?? '');
//     _bookIdController =
//         TextEditingController(text: widget.reservation?.bookId ?? '');
//     _startDateController = TextEditingController(
//         text: widget.reservation?.startDate.toString() ?? '');
//     _endDateController = TextEditingController(
//         text: widget.reservation?.endDate.toString() ?? '');
//   }

//   @override
//   void dispose() {
//     // Liberar los recursos de los controladores de texto
//     _userIdController.dispose();
//     _bookIdController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     super.dispose();
//   }

//   void _saveForm() {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }

//     final userId = _userIdController.text;
//     final bookId = _bookIdController.text;
//     final startDate = DateTime.parse(_startDateController.text);
//     final endDate = DateTime.parse(_endDateController.text);

//     if (widget.reservation != null) {
//       // Actualizar la reserva existente
//       final updatedReservation = widget.reservation!.copyWith(
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .updateReservation(updatedReservation);
//     } else {
//       // Crear una nueva reserva
//       final newReservation = Reservation(
//         reservationId: null,
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//         status: 'Activa',
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .addReservation(newReservation);
//     }

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             widget.reservation != null ? 'Editar Reserva' : 'Crear Reserva'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _userIdController,
//                 decoration: InputDecoration(labelText: 'ID de usuario'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa el ID de usuario';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _bookIdController,
//                 decoration: InputDecoration(labelText: 'ID de libro'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa el ID de libro';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _startDateController,
//                 decoration:
//                     InputDecoration(labelText: 'Fecha de inicio (yyyy-mm-dd)'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa la fecha de inicio';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _endDateController,
//                 decoration:
//                     InputDecoration(labelText: 'Fecha de fin (yyyy-mm-dd)'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa la fecha de fin';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 child: Text('Guardar'),
//                 onPressed: _saveForm,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ReservationEditScreen extends StatefulWidget {
//   final Reservation? reservation;

//   ReservationEditScreen({this.reservation});

//   @override
//   _ReservationEditScreenState createState() => _ReservationEditScreenState();
// }

// class _ReservationEditScreenState extends State<ReservationEditScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _quantityBookController = TextEditingController();
//   // Otros controladores y variables necesarios para el formulario

//   @override
//   void initState() {
//     super.initState();
//     if (widget.reservation != null) {
//       // Inicializar los controladores de texto con los valores existentes de la reserva
//       _quantityBookController.text =
//           widget.reservation!.quantityBook.toString();
//       // Otros campos del formulario
//     }
//   }

//   @override
//   void dispose() {
//     _quantityBookController.dispose();
//     // Otros controladores y recursos del formulario
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Obtener los valores del formulario
//       final quantityBook = int.parse(_quantityBookController.text);
//       // Otros campos del formulario

//       // Crear una nueva instancia de Reservation con los valores del formulario
//       final reservation = Reservation(
//         reservationId: widget.reservation?.reservationId,
//         //userId: widget.reservation?.userId,
//         userId: widget.reservation!.userId,
//         //bookId: widget.reservation?.bookId,
//         bookId: widget.reservation!.bookId,
//         startDate: widget.reservation?.startDate ?? DateTime.now(),
//         endDate: widget.reservation?.endDate ?? DateTime.now(),
//         status: widget.reservation?.status ?? '',
//         quantityBook: quantityBook,
//         // Otros campos del formulario
//       );

//       // Guardar o actualizar la reserva según sea el caso
//       if (widget.reservation != null) {
//         // Actualizar la reserva existente
//         Provider.of<ReservationProvider>(context, listen: false)
//             .updateReservation(reservation);
//       } else {
// // Agregar una nueva reserva
//         Provider.of<ReservationProvider>(context, listen: false)
//             .addReservation(reservation);
//       }
// // Navegar de regreso a la pantalla de gestión de reservas
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             widget.reservation != null ? 'Editar Reserva' : 'Crear Reserva'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _quantityBookController,
//                 decoration: InputDecoration(labelText: 'Cantidad de Libros'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Ingrese la cantidad de libros';
//                   }
//                   return null;
//                 },
//               ),
// // Otros campos del formulario
//               ElevatedButton(
//                 child: Text('Guardar'),
//                 onPressed: _submitForm,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//ESTE CODIGO SI FUNCIONA

// class ReservationEditScreen extends StatefulWidget {
//   final Reservation? reservation;

//   ReservationEditScreen({this.reservation});

//   @override
//   _ReservationEditScreenState createState() => _ReservationEditScreenState();
// }

// class _ReservationEditScreenState extends State<ReservationEditScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _userIdController;
//   late TextEditingController _bookIdController;
//   late TextEditingController _startDateController;
//   late TextEditingController _endDateController;
//   late TextEditingController _quantityBookController;

//   @override
//   void initState() {
//     super.initState();

//     // Inicializar los controladores de texto con los valores de la reserva (si existe)
//     _userIdController =
//         TextEditingController(text: widget.reservation?.userId ?? '');
//     _bookIdController =
//         TextEditingController(text: widget.reservation?.bookId ?? '');
//     _startDateController = TextEditingController(
//         text: widget.reservation?.startDate.toString() ?? '');
//     _endDateController = TextEditingController(
//         text: widget.reservation?.endDate.toString() ?? '');
//     _quantityBookController = TextEditingController(
//         text: widget.reservation?.quantityBook.toString() ?? '');
//   }

//   @override
//   void dispose() {
//     // Liberar los recursos de los controladores de texto
//     _userIdController.dispose();
//     _bookIdController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     _quantityBookController.dispose();
//     super.dispose();
//   }

//   void _saveForm() {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }

//     final userId = _userIdController.text;
//     final bookId = _bookIdController.text;
//     final startDate = DateTime.parse(_startDateController.text);
//     final endDate = DateTime.parse(_endDateController.text);
//     final quantityBook = int.parse(_quantityBookController.text);

//     if (widget.reservation != null) {
//       // Actualizar la reserva existente
//       final updatedReservation = widget.reservation!.copyWith(
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//         quantityBook: quantityBook,
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .updateReservation(updatedReservation);
//     } else {
//       // Crear una nueva reserva
//       final newReservation = Reservation(
//         reservationId: null,
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//         quantityBook: quantityBook,
//         status: 'Activa',
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .addReservation(newReservation);
//     }

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//               widget.reservation != null ? 'Editar Reserva' : 'Crear Reserva'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 TextFormField(
//                   controller: _userIdController,
//                   decoration: InputDecoration(labelText: 'ID de usuario'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor, ingresa el ID de usuario';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _bookIdController,
//                   decoration: InputDecoration(labelText: 'ID de libro'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor, ingresa el ID de libro';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _startDateController,
//                   decoration: InputDecoration(
//                       labelText: 'Fecha de inicio (yyyy-mm-dd)'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor, ingresa la fecha de inicio';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _endDateController,
//                   decoration:
//                       InputDecoration(labelText: 'Fecha de fin (yyyy-mm-dd)'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor, ingresa la fecha de fin';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _quantityBookController,
//                   decoration: InputDecoration(labelText: 'Cantidad de libros'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Por favor, ingresa la cantidad de libros';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   child: Text('Guardar'),
//                   onPressed: _saveForm,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

///
///
//FUNCIONA MUCHO MEJOR

// import '../../models/usuario.dart';

// class ReservationEditScreen extends StatefulWidget {
//   final Reservation? reservation;

//   ReservationEditScreen({this.reservation});

//   @override
//   _ReservationEditScreenState createState() => _ReservationEditScreenState();
// }

// class _ReservationEditScreenState extends State<ReservationEditScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _userIdController;
//   late TextEditingController _bookIdController;
//   late TextEditingController _startDateController;
//   late TextEditingController _endDateController;
//   late TextEditingController _quantityBookController;

//   @override
//   void initState() {
//     super.initState();

//     // Inicializar los controladores de texto con los valores de la reserva (si existe)
//     _userIdController =
//         TextEditingController(text: widget.reservation?.userId ?? '');
//     _bookIdController =
//         TextEditingController(text: widget.reservation?.bookId ?? '');
//     _startDateController = TextEditingController(
//         text: widget.reservation?.startDate.toString() ?? '');
//     _endDateController = TextEditingController(
//         text: widget.reservation?.endDate.toString() ?? '');
//     _quantityBookController = TextEditingController(
//         text: widget.reservation?.quantityBook.toString() ?? '');
//   }

//   @override
//   void dispose() {
//     // Liberar los recursos de los controladores de texto
//     _userIdController.dispose();
//     _bookIdController.dispose();
//     _startDateController.dispose();
//     _endDateController.dispose();
//     _quantityBookController.dispose();
//     super.dispose();
//   }

//   void _saveForm() {
//     final isValid = _formKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }

//     final userId = _userIdController.text;
//     final bookId = _bookIdController.text;
//     final startDate = DateTime.parse(_startDateController.text);
//     final endDate = DateTime.parse(_endDateController.text);
//     final quantityBook = int.parse(_quantityBookController.text);

//     if (widget.reservation != null) {
//       // Actualizar la reserva existente
//       final updatedReservation = widget.reservation!.copyWith(
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//         quantityBook: quantityBook,
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .updateReservation(updatedReservation);
//     } else {
//       // Crear una nueva reserva
//       final newReservation = Reservation(
//         reservationId: null,
//         userId: userId,
//         bookId: bookId,
//         startDate: startDate,
//         endDate: endDate,
//         quantityBook: quantityBook,
//         status: 'Activa',
//       );
//       Provider.of<ReservationProvider>(context, listen: false)
//           .addReservation(newReservation);
//     }

//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.reservation != null ? 'Editar Reserva' : 'Crear Reserva',
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               FutureBuilder<List<Usuario>>(
//                 future: Provider.of<UsersProvider>(context)
//                     .getUsers(), // Obtén la lista de usuarios
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     final users = snapshot.data ?? [];

//                     return TypeAheadFormField<Usuario>(
//                       textFieldConfiguration: TextFieldConfiguration(
//                         controller: _userIdController,
//                         decoration: InputDecoration(
//                           labelText: 'ID de usuario',
//                           hintText: 'Buscar usuario',
//                         ),
//                       ),
//                       suggestionsCallback: (pattern) {
//                         // Filtra la lista de usuarios según el patrón de búsqueda
//                         return users.where(
//                           (user) =>
//                               user.name!
//                                   .toLowerCase()
//                                   .contains(pattern.toLowerCase()) ||
//                               user.email!
//                                   .toLowerCase()
//                                   .contains(pattern.toLowerCase()),
//                         );
//                       },
//                       itemBuilder: (context, user) {
//                         // Construye la apariencia de cada sugerencia en el menú desplegable
//                         return ListTile(
//                           title: Text(user.name!),
//                           subtitle: Text(user.email!),
//                         );
//                       },
//                       onSuggestionSelected: (user) {
//                         // Actualiza el valor del controlador de texto con el ID del usuario seleccionado
//                         _userIdController.text = user.uid!;
//                       },
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Por favor, ingresa el ID de usuario';
//                         }
//                         return null;
//                       },
//                     );
//                   }
//                 },
//               ),
//               TextFormField(
//                 controller: _bookIdController,
//                 decoration: InputDecoration(labelText: 'ID de libro'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa el ID de libro';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _startDateController,
//                 decoration: InputDecoration(
//                   labelText: 'Fecha de inicio (yyyy-mm-dd)',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa la fecha de inicio';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _endDateController,
//                 decoration: InputDecoration(
//                   labelText: 'Fecha de fin (yyyy-mm-dd)',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa la fecha de fin';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _quantityBookController,
//                 decoration: InputDecoration(labelText: 'Cantidad de libros'),
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Por favor, ingresa la cantidad de libros';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 child: Text('Guardar'),
//                 onPressed: _saveForm,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//               // Campo de texto para buscar y seleccionar el usuario

//

//

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:provider/provider.dart';
// import '../../providers/reservations_provider.dart';
// import '../../models/reservation.dart';
// import '../../providers/users_provider.dart';

// import '../../models/usuario.dart';
// import '../../providers/books_provider.dart';
// import '../../models/book.dart';

import 'package:bibliotecaprovider/models/usuario.dart';
import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:bibliotecaprovider/models/book.dart';

class ReservationEditScreen extends StatefulWidget {
  final Reservation? reservation;

  ReservationEditScreen({this.reservation});

  @override
  _ReservationEditScreenState createState() => _ReservationEditScreenState();
}

class _ReservationEditScreenState extends State<ReservationEditScreen> {
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
    _userIdController =
        TextEditingController(text: widget.reservation?.userId ?? '');
    _bookIdController =
        TextEditingController(text: widget.reservation?.bookId ?? '');
    _startDateController = TextEditingController(
        text: widget.reservation?.startDate.toString() ?? '');
    _endDateController = TextEditingController(
        text: widget.reservation?.endDate.toString() ?? '');
    _quantityBookController = TextEditingController(
        text: widget.reservation?.quantityBook.toString() ?? '');
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

    if (widget.reservation != null) {
      // Actualizar la reserva existente
      final updatedReservation = widget.reservation!.copyWith(
        userId: userId,
        bookId: bookId,
        startDate: startDate,
        endDate: endDate,
        quantityBook: quantityBook,
      );
      Provider.of<ReservationProvider>(context, listen: false)
          .updateReservation(updatedReservation);
    } else {
      // Crear una nueva reserva
      final newReservation = Reservation(
        reservationId: null,
        userId: userId,
        bookId: bookId,
        startDate: startDate,
        endDate: endDate,
        quantityBook: quantityBook,
        status: 'Activa',
      );
      Provider.of<ReservationProvider>(context, listen: false)
          .addReservation(newReservation);

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

  void _convertToLoan() async {
    final reservation = widget.reservation;
    if (reservation != null) {
      final loanProvider = Provider.of<LoansProvider>(context, listen: false);

      final newLoan = Loan(
        loanId: null,
        userId: reservation.userId,
        bookId: reservation.bookId,
        startDate: DateTime.now(),
        dueDate: reservation.endDate,
        quantity: reservation.quantityBook,
      );

      await loanProvider.addLoan(newLoan);
      await Provider.of<ReservationProvider>(context, listen: false)
          .deleteReservation(reservation.reservationId!);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.reservation != null ? 'Editar Reserva' : 'Crear Reserva',
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
              SizedBox(height: 8),
              if (widget.reservation != null)
                ElevatedButton(
                  child: Text('Convertir a préstamo'),
                  onPressed: _convertToLoan,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
