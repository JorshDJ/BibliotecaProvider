import 'package:bibliotecaprovider/screens/students_screens/books_students_screen.dart';
import 'package:bibliotecaprovider/widgets/student_drawer.dart';
import 'package:flutter/material.dart';

//import '../../widgets/app_drawer.dart';

class StudentHomeScreen extends StatelessWidget {
  static const routeName = '/student-home';

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiante - Panel de control'),
      ),
      drawer: StudentDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            ElevatedButton(onPressed: (() {}), child: Text('Hola')),
            // ElevatedButton(
            //   onPressed: () =>
            //       _navigateTo(context, BooksStudentsScreen().routeName),
            //   child: Text('Reservas'),
            // ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BooksStudentsScreen(),
                  ),
                );
              },
              child: Text('Gestión de Prestamos'),
            ),
            // ElevatedButton(
            //   onPressed: () => _navigateTo(context, BooksScreen.routeName),
            //   child: Text('Ver libros'),
            // ),
          ],
        ),
      ),
    );
  }
}
