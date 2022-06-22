import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/Pages/subpages_cat/edit_cat.dart';
import 'package:tlr/Pages/subpages_pro/detail_pro.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';

class deatail_cat extends StatefulWidget {
  deatail_cat({Key? key, required this.i}) : super(key: key);
  final CategoryP i;
  @override
  State<deatail_cat> createState() => _deatail_catState();
}

class _deatail_catState extends State<deatail_cat> {
  List<Product> Filter_pro = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshDB_TLR();
    pro.forEach((element) {
      if (element.cat_id == widget.i.id) {
        Filter_pro.add(element);
      }
    });
  }

  Future refreshDB_TLR() async {
    setState(() => isloading = true);

    try {
      pro = await DatabaseTLR.inst.readallProducts();
      setState(() => ProData = true);
    } catch (e) {
      setState(() => ProData = false);
    }
    setState(() => isloading = false);

    print(pro.length);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text(
            "${widget.i.Category_name}",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => edit_cat(
                            c: widget.i,
                          )));
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Filter_pro.length > 0
            ? ListView.builder(
                itemCount: Filter_pro.length * 2,
                itemBuilder: (BuildContext context, int i) {
                  if (i.isOdd) return Divider();
                  int index = i ~/ 2;
                  return buildcat(Filter_pro[index], context, index);
                })
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("No Product")]),
              ));
  }

  Widget buildcat(Product pro, context, int i) {
    return ListTile(
      leading: Icon(Icons.dashboard),
      title: Text(pro.Product_name),
      trailing: Text("${pro.price} DA"),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => detail_pro(
                  d: pro,
                )));
      },
      subtitle: Text("Exp:${pro.Expiredtime}|Quantity:${pro.qte}"),
    );
  }
}
