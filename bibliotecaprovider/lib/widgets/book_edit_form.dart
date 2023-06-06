import 'package:flutter/material.dart';
//import '../models/book.dart';

import 'package:bibliotecaprovider/models/book.dart';

class BookEditForm extends StatefulWidget {
  final Book? book;
  final Function onSave;

  BookEditForm({this.book, required this.onSave});

  @override
  _BookEditFormState createState() => _BookEditFormState();
}

class _BookEditFormState extends State<BookEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late TextEditingController _bookIdController; //lo que estoy agregando
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _isbnController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _coverImageUrlController;
  late TextEditingController _availableCopiesController;
  late TextEditingController _totalCopiesController;

  @override
  void initState() {
    super.initState();
    // _bookIdController = TextEditingController(text: widget.book?.bookId ?? ''); // lo que estoy agregando
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _isbnController = TextEditingController(text: widget.book?.isbn ?? '');
    _categoryController =
        TextEditingController(text: widget.book?.category ?? '');
    _descriptionController =
        TextEditingController(text: widget.book?.description ?? '');
    _coverImageUrlController =
        TextEditingController(text: widget.book?.coverImageUrl ?? '');
    _availableCopiesController = TextEditingController(
        text: widget.book?.availableCopies.toString() ?? '');
    _totalCopiesController =
        TextEditingController(text: widget.book?.totalCopies.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _isbnController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _coverImageUrlController.dispose();
    _availableCopiesController.dispose();
    _totalCopiesController.dispose();
    super.dispose();
  }

//SALE ERROR POR QUE NO HAY MARGENES
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         children: [
//           TextFormField(
//             controller: _titleController,
//             decoration: InputDecoration(labelText: 'Título'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Por favor, ingrese un título';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _authorController,
//             decoration: InputDecoration(labelText: 'Autor'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Por favor, ingrese un autor';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _isbnController,
//             decoration: InputDecoration(labelText: 'ISBN'),
//           ),
//           TextFormField(
//             controller: _categoryController,
//             decoration: InputDecoration(labelText: 'Categoría'),
//           ),
//           TextFormField(
//             controller: _descriptionController,
//             decoration: InputDecoration(labelText: 'Descripción'),
//             maxLines: 3,
//           ),
//           TextFormField(
//             controller: _coverImageUrlController,
//             decoration:
//                 InputDecoration(labelText: 'URL de la imagen de portada'),
//           ),
//           TextFormField(
//             controller: _availableCopiesController,
//             decoration: InputDecoration(labelText: 'Copias disponibles'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Por favor, ingrese el número de copias disponibles';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _totalCopiesController,
//             decoration: InputDecoration(labelText: 'Copias totales'),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Porfavor, ingrese el número de copias totales';
//               }
//               return null;
//             },
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 widget.onSave(
//                   _titleController.text,
//                   _authorController.text,
//                   _isbnController.text,
//                   _categoryController.text,
//                   _descriptionController.text,
//                   _coverImageUrlController.text,
//                   int.parse(_availableCopiesController.text),
//                   int.parse(_totalCopiesController.text),
//                 );
// // Aquí puedes guardar los cambios en Firestore utilizando el BookProvider
//                 // Luego de guardar, puedes volver a la pantalla anterior

//                 Navigator.pop(context);
//               }
//             },
//             child: Text('Guardar'),
//           ),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Todos tus TextFormField y el botón
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un autor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _coverImageUrlController,
                decoration:
                    InputDecoration(labelText: 'URL de la imagen de portada'),
              ),
              TextFormField(
                controller: _availableCopiesController,
                decoration: InputDecoration(labelText: 'Copias disponibles'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el número de copias disponibles';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _totalCopiesController,
                decoration: InputDecoration(labelText: 'Copias totales'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, ingrese el número de copias totales';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSave(
                      _titleController.text,
                      _authorController.text,
                      _isbnController.text,
                      _categoryController.text,
                      _descriptionController.text,
                      _coverImageUrlController.text,
                      int.parse(_availableCopiesController.text),
                      int.parse(_totalCopiesController.text),
                    );
// Aquí puedes guardar los cambios en Firestore utilizando el BookProvider
                    // Luego de guardar, puedes volver a la pantalla anterior

                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
