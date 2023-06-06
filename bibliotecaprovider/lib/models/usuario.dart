class Usuario {
  final String? uid;
  final String? email;
  final String? name;
  final String? userType;
  final bool? enabled;

  Usuario({
    this.uid,
    this.email,
    this.name,
    this.userType,
    this.enabled,
  });

  // Método para crear un objeto User a partir de un documento de Firestore
  factory Usuario.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) {
      // throw Exception('Data is null');
      return Usuario();
    }

    String uid = data['uid'];
    String email = data['email'];
    String name = data['name'];
    String userType = data['userType'];
    bool enabled = data['enabled'];

    return Usuario(
      uid: uid,
      email: email,
      name: name,
      userType: userType,
      enabled: enabled,
    );
  }
}
