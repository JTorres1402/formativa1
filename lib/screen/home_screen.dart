import 'package:flutter/material.dart';
import 'package:formativa1/screen/curso_screen.dart';
import 'estudiante_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          ListTile(
            title: const Text(
              'Crear estudiante',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListEstudiante()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Crear curso',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListCurso()),
              );
            },
          ),
        ],
      )),
      body: const Center(child: Text('curso_estudiante')),
    );
  }
}
