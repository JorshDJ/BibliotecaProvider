import 'package:flutter/material.dart';

// import 'book_management_screen.dart';
import 'user_management_screen.dart';

import 'book_management_screen.dart';
import 'loan_management_screen.dart';
// import 'reservations_management_screen.dart';
// import 'inventory_movements_management_screen.dart';
//import '../../widgets/app_drawer.dart'; //para el drawer
import 'package:bibliotecaprovider/widgets/app_drawer.dart';

class LibrarianHomeScreen extends StatelessWidget {
  static const routeName = '/librarian-home';

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bibliotecario - Panel de control'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // ElevatedButton(
            //   onPressed: () =>
            //       _navigateTo(context, BookManagementScreen.routeName),
            //   child: Text('Gestión de libros'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserManagementScreen(),
                  ),
                );
              },
              child: Text('Gestión de usuarios'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookManagementScreen(),
                  ),
                );
              },
              child: Text('Gestión de Libros'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoanManagementScreen(),
                  ),
                );
              },
              child: Text('Gestión de Prestamos'),
            ),
            // ElevatedButton(
            //   onPressed: () =>
            //       _navigateTo(context, LoansManagementScreen.routeName),
            //   child: Text('Gestión de préstamos'),
            // ),
            // ElevatedButton(
            //   onPressed: () =>
            //       _navigateTo(context, ReservationsManagementScreen.routeName),
            //   child: Text('Gestión de reservas'),
            // ),
            // ElevatedButton(
            //   onPressed: () => _navigateTo(
            //       context, InventoryMovementsManagementScreen.routeName),
            //   child: Text('Gestión de movimientos de inventario'),
            // ),
          ],
        ),
      ),
    );
  }
}
