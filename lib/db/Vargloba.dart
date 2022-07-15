import 'package:tlr/Model/Category.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Model/barcode.dart';
import 'package:tlr/Model/style.dart';
import 'package:tlr/Model/user.dart';

List<Product> pro = [];
usersauth? auth;

List<CategoryP> cat = [];
bool isloading = false;
bool CatData = false;
bool ProData = false;
List<String> all_catgories = [
  "Vêtements",
  "Santé",
  "Produits d' Entretien",
  "Nettoyage",
  "Plomberie",
  "Chauffage",
  "Ventilation",
  "Climatisation",
  "Boisson",
  "Tabac",
  "Nourriture",
  "Meubles Domestiques",
  "De Bureau",
  "Ameublement",
  "Matériels Electriques",
  "Informatique",
  "Equipements Sportifs",
  "Equipement de la Maison",
  "Beauté",
  "Soin Personnel",
  "Hygiène",
  "Accessoires Corporels",
];
StyleInterApp? your_style;
List<Barcodeclass> codes = [
  Barcodeclass(id: 0, codeBar: 6130234001161, ProductName: "Lalla Khedidja"),
  Barcodeclass(id: 1, codeBar: 6130433000385, ProductName: "condia"),
  Barcodeclass(id: 2, codeBar: 6130760006067, ProductName: "yago"),
  Barcodeclass(
      id: 3,
      codeBar: 6132504574498,
      ProductName:
          "aqua fine extra boisson gazeuse a base d'eau de source Saveur de Cerise"),
  Barcodeclass(id: 4, codeBar: 6132004000015, ProductName: "labelle"),
  Barcodeclass(id: 5, codeBar: 6130234001666, ProductName: "Medina"),
];
