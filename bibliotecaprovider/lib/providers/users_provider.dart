import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // se está probando
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario.dart';

class UsersProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<List<Usuario>> getUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs
        .map((doc) => Usuario.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Usuario>> searchUsers(String searchTerm) async {
    if (searchTerm.isEmpty) {
      return getUsers();
    }

    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .orderBy('name')
        .startAt([searchTerm]).endAt([searchTerm + '\uf8ff']).get();

    return querySnapshot.docs
        .map((doc) => Usuario.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateUser(Usuario user) async {
    await _usersCollection.doc(user.uid).update({
      'name': user.name,
      'userType': user.userType,
      'enabled': user.enabled,
    });
  }

  Stream<List<Usuario>> getUsersStream() {
    return _usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Usuario(
          uid: doc.id,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          userType: data['userType'] ??
              'Estudiante', // Valor predeterminado si userType no está presente
          enabled: data['enabled'] ??
              true, // Valor predeterminado si enabled no está presente
        );
      }).toList();
    });
  }

  // Agrega más métodos y lógica según tus necesidades.
}
