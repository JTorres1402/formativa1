import 'package:flutter/material.dart';

class ListEstudiante  extends StatefulWidget {
  const ListEstudiante ({super.key});

  @override
  State<ListEstudiante> createState() => _ListEstudianteState();
}

class _ListEstudianteState extends State<ListEstudiante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
      ),
      body: Center()
    );
  }
}