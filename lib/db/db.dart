import 'package:formativa1/model/curso.dart';
import 'package:formativa1/model/estudiante.dart';
import 'package:formativa1/model/estudiante_curso.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String tableEstudiante = 'estudiantes';
  static const String tableCurso = 'cursos';
  static const String tableEstudianteCurso = 'estudiantes_cursos';

  static const String columnId = 'id';
  static const String columnNombre = 'nombre';
  static const String columnApellido = 'apellido';
  static const String columnDocumento = 'documento';
  static const String columnDescripcion = 'descripcion';

  static const String columnIdCurso = 'id_curso';
  static const String columnIdEstudiante = 'id_estudiante';

  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'universidad.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableEstudiante (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNombre TEXT NOT NULL,
        $columnApellido TEXT NOT NULL,
        $columnDocumento INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableCurso (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNombre TEXT NOT NULL,
        $columnDescripcion TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableEstudianteCurso (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnIdEstudiante INTEGER NOT NULL,
        $columnIdCurso INTEGER NOT NULL,
        FOREIGN KEY ($columnIdEstudiante) REFERENCES $tableEstudiante ($columnId) ON DELETE CASCADE,
        FOREIGN KEY ($columnIdCurso) REFERENCES $tableCurso ($columnId) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertEstudiante(Estudiante estudiante) async {
    final db = await database;
    final values = {
      DatabaseProvider.columnNombre: estudiante.nombre,
      DatabaseProvider.columnApellido: estudiante.apellido,
      DatabaseProvider.columnDocumento: estudiante.documento,
    };
    return await db.insert(DatabaseProvider.tableEstudiante, values);
  }

  Future<int> insertCurso(Curso curso) async {
    final db = await database;
    final values = {
      DatabaseProvider.columnNombre: curso.nombre,
      DatabaseProvider.columnApellido: curso.descripcion,
    };
    return await db.insert(DatabaseProvider.tableCurso, values);
  }

  Future<int> insertEstudianteCurso(EstudianteCurso estudianteCurso) async {
    final db = await database;
    final values = {
      DatabaseProvider.columnIdEstudiante: estudianteCurso.idEstudiante,
      DatabaseProvider.columnIdCurso: estudianteCurso.idEstudiante,
    };
    return await db.insert(DatabaseProvider.tableEstudianteCurso, values);
  }

  Future<List<Estudiante>> mostrarEstudiantes() async {
    final db = await database;
    final List<Map<String, dynamic>> estudiantes =
        await db.query(tableEstudiante);
    return List.generate(estudiantes.length, (i) {
      return Estudiante(
        id: estudiantes[i][columnId],
        nombre: estudiantes[i][columnNombre],
        apellido: estudiantes[i][columnApellido],
        documento: estudiantes[i][columnDocumento],
      );
    });
  }

  Future<List<Curso>> mostrarCursos() async {
    final db = await database;
    final List<Map<String, dynamic>> cursos = await db.query(tableCurso);
    return List.generate(cursos.length, (i) {
      return Curso(
        id: cursos[i][columnId],
        nombre: cursos[i][columnNombre],
        descripcion: cursos[i][columnDescripcion],
      );
    });
  }

  Future<List<Map<String, dynamic>>> mostrarEstudiantesCursos() async {
    final db = await instance.database;
    return await db.query(tableEstudianteCurso);
  }
}
