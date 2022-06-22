final String tablechapitre = 'chapitre';

class chapitreFields {
  static final List<String> values = [
    id,
    s_id,
    chapitre_name,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String s_id = 's_id';
  static final String chapitre_name = 'chapitre_name';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class chapitre {
  final int? id;
  final int s_id;
  final String chapitre_name;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const chapitre({
    this.id,
    required this.s_id,
    required this.chapitre_name,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static chapitre fromJson(Map<String, Object?> json) => chapitre(
      id: json[chapitreFields.id] as int?,
      s_id: json[chapitreFields.s_id] as int,
      chapitre_name: json[chapitreFields.chapitre_name] as String,
      Data_createdTime:
          DateTime.parse(json[chapitreFields.Data_createdTime] as String),
      Data_LastModification:
          DateTime.parse(json[chapitreFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        chapitreFields.id: id,
        chapitreFields.s_id: s_id,
        chapitreFields.chapitre_name: chapitre_name,
        chapitreFields.Data_createdTime: Data_createdTime.toIso8601String(),
        chapitreFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  chapitre copy({
    int? id,
    int? s_id,
    String? chapitre_name,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      chapitre(
          id: id ?? this.id,
          s_id: s_id ?? this.s_id,
          chapitre_name: chapitre_name ?? this.chapitre_name,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
