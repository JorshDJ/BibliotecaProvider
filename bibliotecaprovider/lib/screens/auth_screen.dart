import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

import '../widgets/login_widget.dart';
import '../widgets/sign_up_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Iniciar sesión' : 'Registrarse'),
        actions: [
          IconButton(
            icon: Icon(_isLogin ? Icons.person_add : Icons.login),
            onPressed: _toggleAuthMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Mover SingleChildScrollView aquí
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://zagazine.mx/wp-content/uploads/2023/02/WhatsApp-Image-2023-02-09-at-15.27.20-2.jpeg"),
                    radius: 70,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mi Biblioteca",
                    style: TextStyle(fontSize: 40.0),
                  ),
                  if (_isLogin)
                    LoginWidget(
                      onLogin: (email, password) =>
                          authProvider.signIn(email, password),
                      onToggleAuthMode: _toggleAuthMode,
                    )
                  else
                    SignUpWidget(
                      onSignUp: (email, password, name, userType) =>
                          authProvider.signUp(email, password, name, userType),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
