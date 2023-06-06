import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../providers/loans_provider.dart';
// import '../../models/loan.dart';
// import '../../widgets/loan_list_item.dart'; //falta
// import 'loan_edit_screen.dart'; //fañta

import 'package:bibliotecaprovider/providers/loans_provider.dart';
import 'package:bibliotecaprovider/models/loan.dart';
import 'package:bibliotecaprovider/widgets/loan_list_item.dart';
import 'loan_edit_screen.dart'; //

// class LoanManagementScreen extends StatefulWidget {
//   @override
//   _LoanManagementScreenState createState() => _LoanManagementScreenState();
// }

// class _LoanManagementScreenState extends State<LoanManagementScreen> {
//   String _searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gestión de préstamos'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               // Navegar a la pantalla de creación de préstamos
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => LoanEditScreen(),
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
//                 labelText: 'Buscar préstamo',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<List<Loan>>(
//               stream: Provider.of<LoansProvider>(context).getLoansStream(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final loans = snapshot.data!
//                     .where((loan) => loan.loanId!
//                         .toLowerCase()
//                         .contains(_searchQuery.toLowerCase()))
//                     .toList();

//                 return ListView.builder(
//                   itemCount: loans.length,
//                   itemBuilder: (context, index) {
//                     return LoanListItem(
//                       loan: loans[index],
//                       onTap: () {
//                         // Navegar a la pantalla de edición de préstamos
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 LoanEditScreen(loan: loans[index]),
//                           ),
//                         );
//                       },
//                       onDelete: () {
//                         // Eliminar el préstamo
//                         showDialog(
//                           context: context,
//                           builder: (ctx) => AlertDialog(
//                             title: Text('Eliminar préstamo'),
//                             content: Text(
//                                 '¿Está seguro de que desea eliminar este préstamo?'),
//                             actions: <Widget>[
//                               ElevatedButton(
//                                 child: Text('No'),
//                                 onPressed: () {
//                                   Navigator.of(ctx).pop();
//                                 },
//                               ),
//                               ElevatedButton(
//                                 child: Text('Sí'),
//                                 onPressed: () {
//                                   Provider.of<LoansProvider>(context,
//                                           listen: false)
//                                       .deleteLoan(loans[index].loanId!);
//                                   Navigator.of(ctx).pop();
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
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
class LoanManagementScreen extends StatefulWidget {
  @override
  _LoanManagementScreenState createState() => _LoanManagementScreenState();
}

class _LoanManagementScreenState extends State<LoanManagementScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de préstamos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla de creación de préstamos
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoanEditScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
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
                labelText: 'Buscar préstamo',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Loan>>(
              stream: Provider.of<LoansProvider>(context).getLoansStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final loans = snapshot.data!
                    .where((loan) =>
                        loan.loanId!
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()) ||
                        loan.userId
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()) ||
                        loan.bookId
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: loans.length,
                  itemBuilder: (context, index) {
                    return LoanListItem(
                      loan: loans[index],
                      onTap: () {
                        // Navegar a la pantalla de edición de préstamos
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                LoanEditScreen(loan: loans[index]),
                          ),
                        );
                      },
                      onDelete: () {
                        // Eliminar el préstamo
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Eliminar préstamo'),
                            content: Text(
                                '¿Está seguro de que desea eliminar este préstamo?'),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text('Sí'),
                                onPressed: () {
                                  Provider.of<LoansProvider>(context,
                                          listen: false)
                                      .deleteLoan(loans[index].loanId!);
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
