class Estudiante {
  int? id;
  String? nombre;
  String? apellido;
  int? documento;

  Estudiante({this.id, this.nombre, this.apellido, this.documento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'documento': documento,
    };
  }

  static Estudiante fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id'],
      nombre: map['nombre'],
      apellido: map['apellido'],
      documento: map['documento'],
    );
  }

  Estudiante copyWith({
    int? id,
    String? nombre,
    String? apellido,
    int? documento,
  }) {
    return Estudiante(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      documento: documento ?? this.documento,
    );
  }
}
