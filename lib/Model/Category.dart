import 'package:tlr/Model/chapitre.dart';
import 'package:tlr/Model/section.dart';
import 'package:tlr/Model/tier.dart';

final String tablecategory = 'category';

class CategoryFields {
  static final List<String> values = [
    id,
    Category_name,
    type,
    url_img,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String Category_name = 'Category_name';
  static final String type = 'type';
  static final String url_img = 'url_img';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class CategoryP {
  final int? id;
  final String Category_name;
  final String type;
  final String url_img;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const CategoryP({
    this.id,
    required this.Category_name,
    required this.type,
    required this.url_img,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static CategoryP fromJson(Map<String, Object?> json) => CategoryP(
      id: json[CategoryFields.id] as int?,
      Category_name: json[CategoryFields.Category_name] as String,
      type: json[CategoryFields.type] as String,
      url_img: json[CategoryFields.url_img] as String,
      Data_createdTime:
          DateTime.parse(json[CategoryFields.Data_createdTime] as String),
      Data_LastModification:
          DateTime.parse(json[CategoryFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        CategoryFields.id: id,
        CategoryFields.Category_name: Category_name,
        CategoryFields.type: type,
        CategoryFields.url_img: url_img,
        CategoryFields.Data_createdTime: Data_createdTime.toIso8601String(),
        CategoryFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  CategoryP copy({
    int? id,
    String? Category_name,
    String? type,
    String? url_img,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      CategoryP(
          id: id ?? this.id,
          Category_name: Category_name ?? this.Category_name,
          type: type ?? this.type,
          url_img: url_img ?? this.url_img,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
