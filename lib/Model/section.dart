final String tablesection = 'section';

class sectionFields {
  static final List<String> values = [
    id,
    section_name,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String section_name = 'section_name';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class section {
  final int? id;
  final String section_name;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const section({
    this.id,
    required this.section_name,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static section fromJson(Map<String, Object?> json) => section(
      id: json[sectionFields.id] as int?,
      section_name: json[sectionFields.section_name] as String,
      Data_createdTime:
          DateTime.parse(json[sectionFields.Data_createdTime] as String),
      Data_LastModification:
          DateTime.parse(json[sectionFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        sectionFields.id: id,
        sectionFields.section_name: section_name,
        sectionFields.Data_createdTime: Data_createdTime.toIso8601String(),
        sectionFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  section copy({
    int? id,
    String? section_name,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      section(
          id: id ?? this.id,
          section_name: section_name ?? this.section_name,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
