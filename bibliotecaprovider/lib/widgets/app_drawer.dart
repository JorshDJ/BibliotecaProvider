import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import '../models/usuario.dart';
// import '../screens/librarian_screens/book_management_screen.dart';
// import '../screens/librarian_screens/loan_management_screen.dart';
// import '../screens/librarian_screens/reservation_management_screen.dart';
// import '../screens/librarian_screens/user_management_screen.dart';

import 'package:bibliotecaprovider/providers/auth_provider.dart';
import 'package:bibliotecaprovider/models/usuario.dart';
import 'package:bibliotecaprovider/screens/librarian_screens/book_management_screen.dart';
import 'package:bibliotecaprovider/screens/librarian_screens/loan_management_screen.dart';
import 'package:bibliotecaprovider/screens/librarian_screens/reservation_management_screen.dart';
import 'package:bibliotecaprovider/screens/librarian_screens/user_management_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder<Usuario?>(
              future: authProvider.currenttUser,
              builder:
                  (BuildContext context, AsyncSnapshot<Usuario?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Text(snapshot.data!.name ?? 'Usuario desconocido');
                } else {
                  return Text('Usuario desconocido');
                }
              },
            ),
            accountEmail: FutureBuilder<Usuario?>(
              future: authProvider.currenttUser,
              builder:
                  (BuildContext context, AsyncSnapshot<Usuario?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return Text(snapshot.data!.email ?? 'Usuario desconocido');
                } else {
                  return Text('Correo desconocido');
                }
              },
            ),
            currentAccountPicture: FutureBuilder<Usuario?>(
              future: authProvider.currenttUser,
              builder:
                  (BuildContext context, AsyncSnapshot<Usuario?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      snapshot.data!.name![0].toUpperCase(),
                      style: TextStyle(fontSize: 40.0),
                    ),
                  );
                } else {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '?',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  );
                }
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Gestión de usuarios'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_book_sharp),
            title: Text('Gestión de libros '),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.low_priority_sharp),
            title: Text('Gestión de préstamos'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoanManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_sharp),
            title: Text('Gestión de reservas'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReservationManagementScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              // authProvider.logout();
              authProvider.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
