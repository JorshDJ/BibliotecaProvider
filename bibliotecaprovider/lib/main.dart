// import 'package:bibliotecaprovider/providers/reservation_provider.dart';
import 'package:bibliotecaprovider/screens/students_screens/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// import './providers/auth_provider.dart';
// import './providers/books_provider.dart';
// import './providers/loans_provider.dart';
// import './providers/reservations_provider.dart';
// import './screens/auth_screen.dart';
// import './screens/librarian_screens/librarian_home_screen.dart';

import 'package:bibliotecaprovider/providers/auth_provider.dart';
import 'package:bibliotecaprovider/providers/books_provider.dart';
import 'package:bibliotecaprovider/providers/loans_provider.dart';
import 'package:bibliotecaprovider/providers/reservations_provider.dart';
import 'package:bibliotecaprovider/screens/auth_screen.dart';
import 'package:bibliotecaprovider/screens/librarian_screens/librarian_home_screen.dart';

import 'package:bibliotecaprovider/models/usuario.dart';

//import 'models/usuario.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'providers/users_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => BooksProvider()),
        ChangeNotifierProvider(create: (context) => LoansProvider()),
        ChangeNotifierProvider(create: (context) => ReservationProvider()),
        //
        // ChangeNotifierProvider(create: (ctx) => AuthProvider()),

        // ...
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),

        // ChangeNotifierProvider(create: (ctx) => LoansProvider()),
        // ChangeNotifierProvider(create: (ctx) => ReservationsProvider()),
        // ChangeNotifierProvider(create: (ctx) => InventoryMovementsProvider()),
      ],
      child: MaterialApp(
        title: 'Biblioteca Escolar',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: AuthScreen(),
        home: _buildAuthStream(),
        routes: {
          //acá van las rutas
          // StudentHomeScreen.routeName: (ctx) => StudentHomeScreen(),
          // TeacherHomeScreen.routeName: (ctx) => TeacherHomeScreen(),
          // LibrarianHomeScreen.routeName: (ctx) => LibrarianHomeScreen(),
        },
      ),
    );
  }

  // Agrega este método
  Widget _buildAuthStream() {
    return StreamBuilder<Usuario?>(
      stream: AuthProvider().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          String? uid = snapshot.data?.uid;
          if (uid == null) {
            return AuthScreen();
          }
          return FutureBuilder(
            future: _getUserType(uid),
            builder: (context, userTypeSnapshot) {
              if (userTypeSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                final String? userType = userTypeSnapshot.data;
                if (userType == 'Bibliotecario') {
                  //Estudiante
                  //   return StudentHomeScreen();
                  // } else if (userType == 'Profesor') {
                  //   return TeacherHomeScreen();
                  // } else if (userType == 'Bibliotecario') {
                  return LibrarianHomeScreen();
                } else if (userType == 'Estudiante') {
                  return StudentHomeScreen();
                } else {
                  return AuthScreen();
                }
              }
            },
          );
        } else {
          return AuthScreen();
        }
      },
    );
  }

  // Agrega esta función
  Future<String> _getUserType(String uid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    return userData?['userType'] ?? '';
  }
}
