import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../../providers/loans_provider.dart';
// import '../../models/loan.dart';
// import '../../widgets/loan_list_item.dart';

import 'package:bibliotecaprovider/providers/loans_provider.dart';
import 'package:bibliotecaprovider/models/loan.dart';
import 'package:bibliotecaprovider/widgets/loan_list_item.dart';

class LoansStudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Préstamos'),
      ),
      body: StreamBuilder<List<Loan>>(
        stream: Provider.of<LoansProvider>(context).getLoansStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final loans =
              snapshot.data?.where((loan) => loan.userId == userId).toList();

          if (loans == null || loans.isEmpty) {
            return Center(child: Text('No se encontraron préstamos.'));
          }

          loans.sort((a, b) => a.startDate.compareTo(b.startDate));

          return ListView.builder(
            itemCount: loans.length,
            itemBuilder: (context, index) {
              return LoanListItem(
                loan: loans[index],
                onTap: () {
                  // Implementa la acción al hacer clic en un préstamo
                },
              );
            },
          );
        },
      ),
    );
  }
}
