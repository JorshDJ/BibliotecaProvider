// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/users_provider.dart';
// import '../../models/usuario.dart';

// import 'user_edit_screen.dart';

// class UserManagementScreen extends StatefulWidget {
//   @override
//   _UserManagementScreenState createState() => _UserManagementScreenState();
// }

// class _UserManagementScreenState extends State<UserManagementScreen> {
//   TextEditingController _searchController = TextEditingController();
//   Future<List<Usuario>>? _usersFuture;

//   @override
//   void initState() {
//     super.initState();
//     _usersFuture =
//         Provider.of<UsersProvider>(context, listen: false).getUsers();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gestión de usuarios'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Buscar usuario',
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _usersFuture =
//                       Provider.of<UsersProvider>(context, listen: false)
//                           .searchUsers(value);
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<Usuario>>(
//               future: _usersFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else {
//                   final users = snapshot.data;
//                   return ListView.builder(
//                     itemCount: users!.length,
//                     itemBuilder: (context, index) {
//                       final user = users[index];
//                       return ListTile(
//                         title: Text(user.name!),
//                         subtitle: Text(user.email!),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 // Editar usuario
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         UserEditScreen(usuario: user)));
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 // Eliminar usuario
//                               },
//                             ),
//                           ],
//                         ),
//                         leading: CircleAvatar(
//                             // child: Text(user.userType[0]),
//                             ),
//                         isThreeLine: true,
//                         dense: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         onTap: () {
//                           // Ver detalles del usuario
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//EJEMPLO DE COMO ESTÁ EN BOOK
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../providers/users_provider.dart';
// import '../../models/usuario.dart';
// import '../../widgets/user_list_item.dart';
// import 'user_edit_screen.dart';

// class UserManagementScreen extends StatefulWidget {
//   @override
//   _UserManagementScreenState createState() => _UserManagementScreenState();
// }

// class _UserManagementScreenState extends State<UserManagementScreen> {
//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gestión de usuarios'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Navegar a la pantalla de creación de usuarios
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => UserEditScreen(usuario: null,),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchQuery = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Buscar usuario',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<Usuario>>(
//               stream: Provider.of<UsersProvider>(context).getUsersStream(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final users = snapshot.data!
//                     .where((user) => user.name
//                         .toLowerCase()
//                         .contains(_searchQuery.toLowerCase()))
//                     .toList();

//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (context, index) {
//                     return UserListItem(
//                       usuario: users[index],
//                       onTap: () {
//                         // Navegar a la pantalla de edición de usuarios
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 UserEditScreen(usuario: users[index]),
//                           ),
//                         );
//                       },
//                       onDelete: () async {
//                         final confirmed = await showDialog<bool>(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Confirmar eliminación'),
//                             content: Text(
//                                 '¿Estás seguro de que deseas eliminar este usuario?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.of(context).pop(true),
//                                 child: Text('Sí'),
//                               ),
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.of(context).pop(false),
//                                 child: Text('No'),
//                               ),
//                             ],
//                           ),
//                         );
//                         if (confirmed == true) {
//                           Provider.of<UsersProvider>(context, listen: false)
//                               .deleteUser(users[index].userId);
//                         }
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
//
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../providers/users_provider.dart';
// import '../../models/usuario.dart';
// import 'user_edit_screen.dart';

import 'package:bibliotecaprovider/providers/users_provider.dart';
import 'package:bibliotecaprovider/models/usuario.dart';
import 'user_edit_screen.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de usuarios'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar usuario',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Usuario>>(
              stream: _searchController.text.isNotEmpty
                  ? Provider.of<UsersProvider>(context)
                      .searchUsers(_searchController.text)
                      .asStream()
                  : Provider.of<UsersProvider>(context).getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No se encontraron usuarios.'));
                } else {
                  final users = snapshot.data;
                  return ListView.builder(
                    itemCount: users!.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.name!),
                        subtitle: Text(user.email!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Editar usuario
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        UserEditScreen(usuario: user)));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Eliminar usuario
                              },
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                            // child: Text(user.userType[0]),
                            ),
                        isThreeLine: true,
                        dense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        onTap: () {
                          // Ver detalles del usuario
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
