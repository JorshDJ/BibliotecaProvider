import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final Function(String email, String password) onLogin;
  final VoidCallback? onToggleAuthMode;

  LoginWidget({required this.onLogin, @required this.onToggleAuthMode});

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _email;
  String? _password;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    onLogin(_email!, _password!);
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
              _email = value!;
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
              _password = value!;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Iniciar sesión'),
          ),
          TextButton(
            onPressed: onToggleAuthMode,
            child: Text('¿No tienes cuenta? Regístrate'),
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
