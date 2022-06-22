final String tabletier = 'tier';

class tierFields {
  static final List<String> values = [
    id,
    c_id,
    tier_name,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String c_id = 'c_id';
  static final String tier_name = 'tier_name';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class tier {
  final int? id;
  final int c_id;
  final String tier_name;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const tier({
    this.id,
    required this.c_id,
    required this.tier_name,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });

  static tier fromJson(Map<String, Object?> json) => tier(
      id: json[tierFields.id] as int?,
      c_id: json[tierFields.c_id] as int,
      tier_name: json[tierFields.tier_name] as String,
      Data_createdTime:
          DateTime.parse(json[tierFields.Data_createdTime] as String),
      Data_LastModification:
          DateTime.parse(json[tierFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        tierFields.id: id,
        tierFields.c_id: c_id,
        tierFields.tier_name: tier_name,
        tierFields.Data_createdTime: Data_createdTime.toIso8601String(),
        tierFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  tier copy({
    int? id,
    int? c_id,
    String? tier_name,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      tier(
          id: id ?? this.id,
          c_id: c_id ?? this.c_id,
          tier_name: tier_name ?? this.tier_name,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
