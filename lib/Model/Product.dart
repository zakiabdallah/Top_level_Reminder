final String tableProduct = 'Product';

class ProductFields {
  static final List<String> values = [
    id,
    cat_id,
    Product_name,
    Expiredtime,
    alert,
    qte,
    price,
    url_img,
    Data_createdTime,
    Data_LastModification
  ];
  static final String id = '_id';
  static final String cat_id = 'cat_id';
  static final String Product_name = 'Product_name';
  static final String Expiredtime = 'Expiredtime';
  static final String alert = 'alert';
  static final String qte = 'qte';
  static final String price = 'price';
  static final String url_img = 'url_img';
  static final String Data_createdTime = 'Data_createdTime';
  static final String Data_LastModification = 'Data_LastModification';
}

class Product {
  final int? id;
  final int cat_id;
  final String Product_name;
  final DateTime Expiredtime;
  final double? qte;
  final double? price;
  final bool alert;
  final String url_img;
  final DateTime Data_createdTime;
  final DateTime Data_LastModification;
  const Product({
    this.id,
    required this.Product_name,
    required this.cat_id,
    required this.Expiredtime,
    required this.qte,
    required this.price,
    required this.alert,
    required this.url_img,
    required this.Data_createdTime,
    required this.Data_LastModification,
  });
  static Product fromJson(Map<String, Object?> json) => Product(
      id: json[ProductFields.id] as int?,
      cat_id: json[ProductFields.cat_id] as int,
      Product_name: json[ProductFields.Product_name] as String,
      Expiredtime: DateTime.parse(json[ProductFields.Expiredtime] as String),
      qte: json[ProductFields.qte] as double,
      price: json[ProductFields.price] as double,
      alert: json[ProductFields.alert] == 1,
      url_img: json[ProductFields.url_img] as String,
      Data_createdTime:
          DateTime.parse(json[ProductFields.Data_createdTime] as String),
      Data_LastModification:
          DateTime.parse(json[ProductFields.Data_LastModification] as String));
  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.cat_id: cat_id,
        ProductFields.Product_name: Product_name,
        ProductFields.Expiredtime: Expiredtime.toIso8601String(),
        ProductFields.qte: qte,
        ProductFields.price: price,
        ProductFields.alert: alert ? 1 : 0,
        ProductFields.url_img: url_img,
        ProductFields.Data_createdTime: Data_createdTime.toIso8601String(),
        ProductFields.Data_LastModification:
            Data_LastModification.toIso8601String(),
      };

  Product copy({
    int? id,
    int? cat_id,
    String? Product_name,
    DateTime? Expiredtime,
    double? qte,
    double? price,
    bool? alert,
    String? url_img,
    DateTime? Data_createdTime,
    DateTime? Data_LastModification,
  }) =>
      Product(
          id: id ?? this.id,
          cat_id: cat_id ?? this.cat_id,
          Product_name: Product_name ?? this.Product_name,
          Expiredtime: Expiredtime ?? this.Expiredtime,
          qte: qte ?? this.qte,
          price: price ?? this.price,
          alert: alert ?? this.alert,
          url_img: url_img ?? this.url_img,
          Data_createdTime: Data_createdTime ?? this.Data_createdTime,
          Data_LastModification:
              Data_LastModification ?? this.Data_LastModification);
}
