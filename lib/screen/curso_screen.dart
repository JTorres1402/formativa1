import 'package:flutter/material.dart';
import 'package:formativa1/model/curso.dart';

import '../db/db.dart';

class ListCurso extends StatefulWidget {
  const ListCurso ({super.key});

  @override
  State<ListCurso> createState() => _ListCursoState();
}

class _ListCursoState extends State<ListCurso> {
   List<Curso> _cursos = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchCursos();
  }

  Future<void> _fetchCursos() async {
    List<Map<String, dynamic>> rows =
        await DatabaseProvider.instance.mostrarEstudiantesCursos();
    List<Curso> cursos = rows.map((row) => Curso.fromMap(row)).toList();
    setState(() {
      _cursos = cursos;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body:ListView.builder(
        itemCount: _cursos.length,
        itemBuilder: (context, index) {
          final cursos = _cursos[index];
          return ListTile(
              title: Text(cursos.nombre!),
              subtitle: Text(cursos.descripcion!),
              onTap: () => _showCountryDialog(cursos),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => _showAlertDialog(cursos.id!),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showCountryDialog(null),
      ),
    );
  }

  Future _showAlertDialog(int id) async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Está seguro de que desea eliminar este país?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                //await DatabaseProvider.instance.delete(id);
                _fetchCursos();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(false);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCountryDialog(Curso? curso) async {
    final isEditing = curso != null;
    final nombreController =
        TextEditingController(text: isEditing ? curso.nombre : '');
    final descripController =
        TextEditingController(text: isEditing ? curso.descripcion : '');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Editar país' : 'Agregar país'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce el nombre';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: descripController,
                decoration: const InputDecoration(
                  labelText: 'Moneda',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce la descripcion';
                  }
                  return null;
                },
              ),       
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (isEditing) {
                if (_formKey.currentState!.validate()) {
                  final updatedCurso = curso.copyWith(
                    nombre: nombreController.text,
                    descripcion: descripController.text,
                  );
                  //await DatabaseProvider.instance.updatePais(updatedCurso);
                }
              } else {
                if (_formKey.currentState!.validate()) {
                  final newCurso = Curso(
                    nombre: nombreController.text,
                    descripcion: descripController.text,
                  );
                  await DatabaseProvider.instance.insertCurso(newCurso);
                }
              }
              if (_formKey.currentState!.validate()) {
                _fetchCursos();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? 'Guardar cambios' : 'Agregar país'),
          ),
        ],
      ),
    );
  }
}


