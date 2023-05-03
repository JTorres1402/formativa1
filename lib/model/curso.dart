class Curso {
  int? id;
  String? nombre;
  String? descripcion;

  Curso({this.id, this.nombre, this.descripcion});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory Curso.fromMap(Map<String, dynamic> map) {
    return Curso(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
    );
  }

  Curso copyWith({
    int? id,
    String? nombre,
    String? descripcion,
  }) {
    return Curso(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
    );
  }
}
