final String tableBarcodeclass = 'Barcodeclass';

class BarcodeclassFields {
  static final List<String> values = [
    id,
    codeBar,
    ProductName,
  ];
  static final String id = '_id';
  static final String codeBar = 'codeBar';
  static final String ProductName = 'ProductName';
}

class Barcodeclass {
  final int? id;
  final int codeBar;
  final String ProductName;

  Barcodeclass({
    this.id,
    required this.codeBar,
    required this.ProductName,
  });
  static Barcodeclass fromJson(Map<String, Object?> json) => Barcodeclass(
        id: json[BarcodeclassFields.id] as int?,
        codeBar: json[BarcodeclassFields.codeBar] as int,
        ProductName: json[BarcodeclassFields.ProductName] as String,
      );
  Map<String, Object?> toJson() => {
        BarcodeclassFields.id: id,
        BarcodeclassFields.codeBar: codeBar,
        BarcodeclassFields.ProductName: ProductName,
      };

  Barcodeclass copy({
    int? id,
    int? codeBar,
    String? ProductName,
  }) =>
      Barcodeclass(
        id: id ?? this.id,
        codeBar: codeBar ?? this.codeBar,
        ProductName: ProductName ?? this.ProductName,
      );
}
