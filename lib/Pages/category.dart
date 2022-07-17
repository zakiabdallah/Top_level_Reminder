import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Pages/subpages_cat/add_cat.dart';
import 'package:tlr/Pages/subpages_cat/detail_cat.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class category extends StatefulWidget {
  category(List<CategoryP> cat);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  bool CatData = false;
  List<CategoryP> prfCat = cat;
  Widget? DisplayCat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      DisplayCat = ListView.builder(
          itemCount: cat.length * 2,
          itemBuilder: (BuildContext context, int i) {
            if (i.isOdd) return Divider();
            int index = i ~/ 2;
            return buildcat(cat[index], context, index);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var k = MediaQuery.of(context).size.width / 4;
    var Searchsec = k * 3;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Container(
            color: Colors.white,
            width: Searchsec,
            child: TextFormField(
              onChanged: (value) {
                if (value.isEmpty || value == null) {
                  setState(() {
                    prfCat = cat;
                    DisplayCat = ListView.builder(
                        itemCount: prfCat.length * 2,
                        itemBuilder: (BuildContext context, int i) {
                          if (i.isOdd) return Divider();
                          int index = i ~/ 2;
                          return buildcat(prfCat[index], context, index);
                        });
                  });
                } else {
                  setState(() {
                    List<CategoryP> c = prfCat.where((element) {
                      bool t2 =
                          value.matchAsPrefix(element.Category_name) == null
                              ? false
                              : true;
                      bool t1 = element.Category_name.toUpperCase() ==
                          value.toUpperCase();
                      print("t1 : $t1\n t2 : $t2");
                      return t1 || t2;
                    }).toList();
                    DisplayCat = ListView.builder(
                        itemCount: c.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            leading: Icon(Icons.category_outlined),
                            title: Text(c[i].Category_name),
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => deatail_cat(
                                            i: c[i],
                                          )));
                            },
                            subtitle: Text(
                                "${AppLocalizations.of(context)!.type}:${c[i].type.replaceAll("/", "-")}"),
                          );
                          ;
                        });
                  });
                }
              },
              maxLines: 1,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(.4),
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                hintText: '${AppLocalizations.of(context)!.search} ',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => add_cat()));
              },
              icon: Icon(Icons.add_box_outlined),
              color: Colors.blueAccent,
            )
          ],
        ),
        body: cat.length > 0
            ? DisplayCat
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        label:
                            Text(AppLocalizations.of(context)!.createcategory),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => add_cat()));
                        },
                        icon: Icon(Icons.add),
                      ),
                    ]),
              ));
  }

  Widget buildcat(CategoryP cat, context, int i) {
    var k = MediaQuery.of(context).size.width / 6;
    var Searchsec = k * 3;
    return ListTile(
      leading: Icon(Icons.category_outlined),
      title: Text(cat.Category_name),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => deatail_cat(
                  i: cat,
                )));
      },
      subtitle: Text(
          "${AppLocalizations.of(context)!.type}:${cat.type.replaceAll("/", "-")}"),
    );
  }
}
