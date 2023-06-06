// lib/widgets/user_search.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../providers/users_provider.dart';
// import '../models/usuario.dart';

import 'package:bibliotecaprovider/providers/users_provider.dart';
import 'package:bibliotecaprovider/models/usuario.dart';

typedef OnUserSelected = void Function(String userId);

class UserSearch extends StatefulWidget {
  final OnUserSelected onUserSelected;

  UserSearch({required this.onUserSelected});

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  String _searchQuery = '';
  // String? _searchQuery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Buscar usuario',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Usuario>>(
            stream: Provider.of<UsersProvider>(context).getUsersStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // final users = snapshot.data!
              final users = (snapshot.data ?? [])
                  .where((user) => user.name!
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()))
                  // .contains((_searchQuery ?? '').toLowerCase()))
                  .toList();

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index].name ?? ''),
                    subtitle: Text(users[index].email ?? ''),
                    onTap: () {
                      if (users[index].uid != null) {
                        widget.onUserSelected(users[index].uid!);
                      } else {
                        // Puedes mostrar un mensaje de error aquí si el uid es nulo.
                        print("acá esta el error");
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}




//Expanded antiguo 
// Expanded(
//           child: StreamBuilder<List<Usuario>>(
//             stream: Provider.of<UsersProvider>(context).getUsersStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               final users = snapshot.data!
//                   .where((user) => user.name!
//                       .toLowerCase()
//                       .contains(_searchQuery.toLowerCase()))
//                   // .contains((_searchQuery ?? '').toLowerCase()))
//                   .toList();

//               return ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(users[index].name ?? ''),
//                     subtitle: Text(users[index].email ?? ''),
//                     onTap: () {
//                       if (users[index].uid != null) {
//                         widget.onUserSelected(users[index].uid!);
//                       } else {
//                         // Puedes mostrar un mensaje de error aquí si el uid es nulo.
//                         print("acá esta el error");
//                       }
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//         ),