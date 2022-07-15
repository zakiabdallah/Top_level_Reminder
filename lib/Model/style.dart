final String tableStyleInterApp = 'StyleInterApp';

class StyleInterAppFields {
  static final List<String> values = [
    id,
    FontSize,
    Languge,
    FontFamily,
    NotificationAlert,
    NotificationSound,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String FontSize = 'FontSize';
  static final String Languge = 'Languge';
  static final String FontFamily = 'FontFamily';
  static final String NotificationAlert = 'NotificationAlert';
  static final String NotificationSound = 'NotificationSound';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class StyleInterApp {
  final int? id;
  int FontSize;
  String Languge;
  String FontFamily;
  int NotificationAlert;
  String NotificationSound;

  final DateTime Data_createdTime;
  DateTime Data_LastModification;
  StyleInterApp({
    this.id,
    required this.FontSize,
    required this.Languge,
    required this.FontFamily,
    required this.NotificationAlert,
    required this.NotificationSound,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static StyleInterApp fromJson(Map<String, Object?> json) => StyleInterApp(
      id: json[StyleInterAppFields.id] as int?,
      FontSize: json[StyleInterAppFields.FontSize] as int,
      Languge: json[StyleInterAppFields.Languge] as String,
      FontFamily: json[StyleInterAppFields.FontFamily] as String,
      NotificationAlert: json[StyleInterAppFields.NotificationAlert] as int,
      NotificationSound: json[StyleInterAppFields.NotificationSound] as String,
      Data_createdTime:
          DateTime.parse(json[StyleInterAppFields.Data_createdTime] as String),
      Data_LastModification: DateTime.parse(
          json[StyleInterAppFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        StyleInterAppFields.id: id,
        StyleInterAppFields.FontSize: FontSize,
        StyleInterAppFields.Languge: Languge,
        StyleInterAppFields.FontFamily: FontFamily,
        StyleInterAppFields.NotificationAlert: NotificationAlert,
        StyleInterAppFields.NotificationSound: NotificationSound,
        StyleInterAppFields.Data_createdTime:
            Data_createdTime.toIso8601String(),
        StyleInterAppFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  StyleInterApp copy({
    int? id,
    int? FontSize,
    String? Languge,
    String? FontFamily,
    int? NotificationAlert,
    String? NotificationSound,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      StyleInterApp(
          id: id ?? this.id,
          FontSize: FontSize ?? this.FontSize,
          Languge: Languge ?? this.Languge,
          FontFamily: FontFamily ?? this.FontFamily,
          NotificationAlert: NotificationAlert ?? this.NotificationAlert,
          NotificationSound: NotificationSound ?? this.NotificationSound,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
