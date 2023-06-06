import 'package:bibliotecaprovider/screens/students_screens/books_students_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import '../models/usuario.dart';
// import '../screens/students_screens/loans_students_screen.dart';
// import '../screens/students_screens/reservations_student_screen.dart';
// import '../screens/student_screens/books_screen.dart';
// import '../screens/student_screens/reservations_screen.dart';
// import '../screens/student_screens/loans_screen.dart';

import 'package:bibliotecaprovider/providers/auth_provider.dart';
import 'package:bibliotecaprovider/models/usuario.dart';
import 'package:bibliotecaprovider/screens/students_screens/loans_students_screen.dart';
import 'package:bibliotecaprovider/screens/students_screens/reservations_student_screen.dart';

class StudentDrawer extends StatelessWidget {
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
            title: Text('Libros'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BooksStudentsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.recent_actors_sharp),
            title: Text('Reservas'),
            onTap: () {
              // Navigator.of(context).pushNamed(ReservationsScreen.routeName);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReservationsStudentScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.low_priority_sharp),
            title: Text('Préstamos'),
            onTap: () {
              // Navigator.of(context).pushNamed(LoansScreen.routeName);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoansStudentScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Cerrar sesión'),
            onTap: () {
              authProvider.signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
