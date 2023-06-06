import 'package:flutter/material.dart';
//import '../models/usuario.dart';

import 'package:bibliotecaprovider/models/usuario.dart';

class UserEditForm extends StatefulWidget {
  final Usuario usuario;
  final Function(String, String, bool) onSave;

  UserEditForm({required this.usuario, required this.onSave});

  @override
  _UserEditFormState createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _userType = '';
  bool _enabled = false;

  void initState() {
    super.initState();
    _name = widget.usuario.name!;
    _userType = widget.usuario.userType!;
    _enabled = widget.usuario.enabled!;
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    widget.onSave(_name, _userType, _enabled);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: _name,
            decoration: InputDecoration(labelText: 'Nombre'),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un nombre.';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          DropdownButtonFormField(
            value: _userType,
            decoration: InputDecoration(labelText: 'Tipo de usuario'),
            items: [
              DropdownMenuItem(child: Text('Estudiante'), value: 'Estudiante'),
              DropdownMenuItem(child: Text('Profesor'), value: 'Profesor'),
              DropdownMenuItem(
                  child: Text('Bibliotecario'), value: 'Bibliotecario'),
            ],
            onChanged: (newValue) {
              setState(() {
                _userType = newValue as String;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Habilitado'),
            value: _enabled,
            onChanged: (bool value) {
              setState(() {
                _enabled = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: _saveForm,
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
