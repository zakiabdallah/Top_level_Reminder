import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Pages/subpages_cat/add_cat.dart';
import 'package:tlr/Pages/subpages_cat/detail_cat.dart';
import 'package:tlr/db/Vargloba.dart';

class category extends StatelessWidget {
  bool CatData = false;
  category(List<CategoryP> cat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: cat.length > 0
            ? ListView.builder(
                itemCount: cat.length * 2,
                itemBuilder: (BuildContext context, int i) {
                  if (i.isOdd) return Divider();
                  int index = i ~/ 2;
                  return buildcat(cat[index], context, index);
                })
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        label: Text("Create Category"),
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
    print("id:");
    print(cat.id);
    print(i);
    var k = MediaQuery.of(context).size.width / 6;
    var Searchsec = k * 3;
    return i == 0
        ? Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: Searchsec,
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.4),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                            prefixIcon: Icon(Icons.search,
                                color: Colors.black.withOpacity(.6)),
                            hintText: 'Search ',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Container(
                          width: k,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => add_cat()));
                              },
                              icon: Icon(Icons.add_box_outlined))),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.category_outlined),
                    title: Text(cat.Category_name),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => deatail_cat(
                                i: cat,
                              )));
                    },
                    subtitle: Text("Type:${cat.type.replaceAll("/", "-")}"),
                  )
                ]))
        : ListTile(
            leading: Icon(Icons.category_outlined),
            title: Text(cat.Category_name),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => deatail_cat(
                        i: cat,
                      )));
            },
            subtitle: Text("Type:${cat.type.replaceAll("/", "-")}"),
          );
  }
}
