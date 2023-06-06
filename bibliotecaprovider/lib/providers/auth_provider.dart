import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Agrega esta función
  Stream<Usuario?> get authStateChanges =>
      _auth.authStateChanges().map(_firebaseUserToUser);

  Usuario? _firebaseUserToUser(User? user) {
    return user != null ? Usuario(uid: user.uid) : null;
  }

  // Registro de usuarios
  Future<void> signUp(
      String email, String password, String name, String userType) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Añadir información adicional al usuario en Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'userType': userType,
        'enabled': true,
      });

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Manejar errores
      throw e;
    }
  }

  // Inicio de sesión de usuarios
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      // Manejar errores
      throw e;
    }
  }

  // Cerrar sesión de usuarios
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  // Obtener el estado actual del usuario
  User get currentUser => _auth.currentUser!;

//Para acceder al usuario actual
  Future<Usuario?> get currenttUser async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(firebaseUser.uid).get();
    return Usuario.fromFirestore(userDoc.data() as Map<String, dynamic>);
  }
}
