class EstudianteCurso {
  int? id;
  int? idEstudiante;
  int? idCurso;

  EstudianteCurso({this.idEstudiante, this.idCurso, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_estudiante': idEstudiante,
      'id_curso': idCurso,
    };
  }

  factory EstudianteCurso.fromMap(Map<String, dynamic> map) {
    return EstudianteCurso(
      id: map['id'],
      idEstudiante: map['id_estudiante'],
      idCurso: map['id_curso'],
    );
  }

  EstudianteCurso copyWith({
    int? id,
    int? idEstudiante,
    int? idCurso,
  }) {
    return EstudianteCurso(
      id: id ?? this.id,
      idEstudiante: idEstudiante ?? this.idEstudiante,
      idCurso: idCurso ?? this.idCurso,
    );
  }
}
