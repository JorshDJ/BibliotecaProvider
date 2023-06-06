import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  final Function(String email, String password, String name, String userType)
      onSignUp;

  SignUpWidget({required this.onSignUp});

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _email;
  String? _password;
  String? _name;
  String? _userType;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    onSignUp(_email!, _password!, _name!, _userType!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Correo electrónico'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Correo electrónico no válido';
              }
              return null;
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
            onSaved: (value) {
              _password = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Nombre no válido';
              }
              return null;
            },
            onSaved: (value) {
              _name = value;
            },
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(labelText: 'Tipo de usuario'),
            items: [
              DropdownMenuItem(child: Text('Estudiante'), value: 'Estudiante'),
              DropdownMenuItem(child: Text('Profesor'), value: 'Profesor'),
            ],
            onChanged: (value) {
              _userType = value;
            },
            validator: (value) {
              if (value == null) {
                return 'Selecciona un tipo de usuario';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Registrarse'),
          ),
        ],
      ),
    );
  }
}
