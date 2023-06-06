import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../models/usuario.dart';
// import '../../widgets/user_edit_form.dart';
// import '../../providers/users_provider.dart';

import 'package:bibliotecaprovider/models/usuario.dart';
import 'package:bibliotecaprovider/widgets/user_edit_form.dart';
import 'package:bibliotecaprovider/providers/users_provider.dart';

// class UserEditScreen extends StatefulWidget {
//   final Usuario usuario;

//   UserEditScreen({required this.usuario});

//   @override
//   _UserEditScreenState createState() => _UserEditScreenState();
// }

// class _UserEditScreenState extends State<UserEditScreen> {
//   // Agrega aquí el código necesario para actualizar los datos del usuario

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Editar usuario'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: UserEditForm(
//             usuario: usuario,
//             onSave: (name, userType, enabled) {
//               // Aquí puedes utilizar el UsersProvider para actualizar los datos del usuario en Firestore

//               Navigator.of(context).pop();
//             },
//             // Agrega aquí los campos del formulario para editar los datos del usuario
//           ),
//         ),
//       ),
//     );
//   }
// }

class UserEditScreen extends StatelessWidget {
  final Usuario usuario;

  UserEditScreen({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar usuario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserEditForm(
            usuario: usuario,
            onSave: (name, userType, enabled) {
              Usuario updatedUser = Usuario(
                uid: usuario.uid,
                email: usuario.email,
                name: name,
                userType: userType,
                enabled: enabled,
              );
              // Aquí puedes utilizar el UsersProvider para actualizar los datos del usuario en Firestore

              Provider.of<UsersProvider>(context, listen: false)
                  .updateUser(updatedUser)
                  .then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuario actualizado con éxito.'),
                  ),
                );
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ocurrió un error al actualizar el usuario.'),
                  ),
                );
              });

              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
