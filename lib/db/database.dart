import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Model/chapitre.dart';
import 'package:tlr/Model/notification_screen.dart';
import 'package:tlr/Model/section.dart';
import 'package:tlr/Model/style.dart';
import 'package:tlr/Model/tier.dart';
import 'package:tlr/Model/user.dart';

class DatabaseTLR {
  static final DatabaseTLR inst = DatabaseTLR._init();
  static Database? _db;

  DatabaseTLR._init();

  Future<Database> get Dbase async {
    if (_db != null) return _db!;
    _db = await _initDB('Trl.db');
    return _db!;
  }

  Future<Database> _initDB(String s) async {
    final dbpath = await getDatabasesPath();
    final path = dbpath + s;
    print(path);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int vers) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final typebool = 'BOOLEAN NOT NULL';
    final typeint = 'INTEGER NOT NULL';
    final typeText = 'TEXT NOT NULL';
    final typeREAL = 'REAL NOT NULL';
//product

//user
    await db.execute('''
CREATE TABLE $Tableusersauth(
${usersauthFields.id} $idType,
${usersauthFields.First_name} $typeText,
${usersauthFields.Last_name} $typeText,
${usersauthFields.Username} $typeText,
${usersauthFields.Email} $typeText,
${usersauthFields.adress} $typeText,
${usersauthFields.phone} $typeText,
${usersauthFields.Organization} $typeText,
${usersauthFields.Role} $typeText,
${usersauthFields.Password} $typeText,
${usersauthFields.url_img} $typeText,
${usersauthFields.Data_createdTime} $typeText,
${usersauthFields.Data_LastModification} $typeText
)

''');

//category
    await db.execute('''
CREATE TABLE $tablecategory(
${CategoryFields.id} $idType,
${CategoryFields.Category_name} $typeText,
${CategoryFields.type} $typeText,
${CategoryFields.url_img} $typeText,
${CategoryFields.Data_createdTime} $typeText,
${CategoryFields.Data_LastModification} $typeText
)

''');
    print("created${CategoryFields.type}");
    await db.execute('''
CREATE TABLE $tableProduct(
${ProductFields.id} $idType,
${ProductFields.cat_id} $typeint,
${ProductFields.Product_name} $typeText,
${ProductFields.Expiredtime} $typeText,
${ProductFields.qte} $typeREAL,
${ProductFields.price} $typeREAL,
${ProductFields.alert} $typebool,
${ProductFields.url_img} $typeText,
${ProductFields.Data_createdTime} $typeText,
${ProductFields.Data_LastModification} $typeText,
FOREIGN KEY (${ProductFields.cat_id}) REFERENCES ${tablecategory}(${CategoryFields.id})
)

''');
    print("created${CategoryFields.type}");
    await db.execute('''
CREATE TABLE $tableStyleInterApp(
${StyleInterAppFields.id} $typeint,
${StyleInterAppFields.FontSize} $typeint,
${StyleInterAppFields.Languge} $typeText,
${StyleInterAppFields.FontFamily} $typeText,
${StyleInterAppFields.NotificationAlert} $typeint,
${StyleInterAppFields.NotificationSound} $typeText,
${StyleInterAppFields.Data_createdTime} $typeText,
${StyleInterAppFields.Data_LastModification} $typeText,
FOREIGN KEY (${StyleInterAppFields.id}) REFERENCES ${Tableusersauth}(${usersauthFields.id})
)

''');
  }

//style
  Future<StyleInterApp> createStyle(StyleInterApp style, int id_user) async {
    final db_s = await inst.Dbase;
    final id_s = await db_s.insert(tableStyleInterApp, style.toJson());
    return style.copy(id: id_s);
  }

  Future<StyleInterApp> readStyle(int id_user) async {
    final db = await inst.Dbase;
    final maps = await db.query(
      tableStyleInterApp,
      columns: StyleInterAppFields.values,
      where: '${StyleInterAppFields.id}=?  ',
      whereArgs: [id_user],
    );
    if (maps.isNotEmpty) {
      return StyleInterApp.fromJson(maps.first);
    } else {
      throw Exception('This Username  do not  exist');
    }
  }

  Future<int> updateStyle(StyleInterApp style) async {
    final db = await inst.Dbase;
    return db.update(
      tableStyleInterApp,
      style.toJson(),
      where: '${StyleInterAppFields.id}=?',
      whereArgs: [style.id],
    );
  }

//users
  Future<usersauth> createUser(usersauth user) async {
    final db = await inst.Dbase;

    final id = await db.insert(Tableusersauth, user.toJson());

    var styleInterApp = StyleInterApp(
        id: id,
        FontSize: 16,
        Languge: "English",
        FontFamily: "Arial",
        NotificationAlert: 3,
        NotificationSound: "sound1",
        Data_createdTime: DateTime.now(),
        Data_LastModification: DateTime.now());
    await createStyle(styleInterApp, id);
    return user.copy(id: id);
  }

  Future<usersauth> readuser(String username, String password) async {
    final db = await inst.Dbase;
    final maps = await db.query(
      Tableusersauth,
      columns: usersauthFields.values,
      where:
          '${usersauthFields.Username}=? and  ${usersauthFields.Password}=? ',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) {
      return usersauth.fromJson(maps.first);
    } else {
      throw Exception('This Username  do not  exist');
    }
  }

  Future<int> updateuser(usersauth user) async {
    final db = await inst.Dbase;
    return db.update(
      Tableusersauth,
      user.toJson(),
      where: '${usersauthFields.id}=?',
      whereArgs: [user.id],
    );
  }

//Products
  Future<Product> createProducts(Product Products) async {
    final db = await inst.Dbase;
    final id = await db.insert(tableProduct, Products.toJson());
    await Notify(Products.Expiredtime, id);
    return Products.copy(id: id);
  }

  Future<Product> readProducts(int id) async {
    final db = await inst.Dbase;
    final maps = await db.query(
      tableProduct,
      columns: ProductFields.values,
      where: '${ProductFields.id}=?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<Product>> readallProducts() async {
    final db = await inst.Dbase;
    final orderBy = '${ProductFields.Expiredtime}';
    final result = await db.query(tableProduct, orderBy: orderBy);
    if (result.isNotEmpty) {
      return result.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('No Data');
    }
  }

  Future<int> updateProducts(Product Products) async {
    final db = await inst.Dbase;
    return db.update(
      tableProduct,
      Products.toJson(),
      where: '${ProductFields.id}=?',
      whereArgs: [Products.id],
    );
  }

  Future<int> DeleteProducts(Product Products) async {
    final db = await inst.Dbase;
    return db.delete(
      tableProduct,
      where: '${ProductFields.id}=?',
      whereArgs: [Products.id],
    );
  }

//CategoryP
  Future<CategoryP> createCategory(CategoryP CategoryP) async {
    final db = await inst.Dbase;
    final id = await db.insert(tablecategory, CategoryP.toJson());
    return CategoryP.copy(id: id);
  }

  Future<CategoryP> readCategory(int id) async {
    final db = await inst.Dbase;
    final maps = await db.query(
      tablecategory,
      columns: CategoryFields.values,
      where: '${CategoryFields.id}=?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CategoryP.fromJson(maps.first);
    } else {
      throw Exception('Id $id not found');
    }
  }

  Future<List<CategoryP>> readallCategory() async {
    final db = await inst.Dbase;
    final orderBy = '${CategoryFields.id}';
    final result = await db.query(tablecategory, orderBy: orderBy);
    if (result.isNotEmpty) {
      return result.map((e) => CategoryP.fromJson(e)).toList();
    } else {
      throw Exception('No Data');
    }
  }

  Future<int> updateCategory(CategoryP CategoryP) async {
    final db = await inst.Dbase;
    return db.update(
      tablecategory,
      CategoryP.toJson(),
      where: '${CategoryFields.id}=?',
      whereArgs: [CategoryP.id],
    );
  }

  Future<int> DeleteCategory(CategoryP CategoryP) async {
    final db = await inst.Dbase;
    return db.delete(
      tablecategory,
      where: '${CategoryFields.id}=?',
      whereArgs: [CategoryP.id],
    );
  }

  Future close() async {
    final db = await inst.Dbase;
    _db = null;
    return db.close();
  }
}
