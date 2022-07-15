import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/subpages_cat/add_cat.dart';
import 'package:tlr/Pages/subpages_pro/Alert.dart';
import 'package:tlr/Pages/subpages_pro/add_pro.dart';
import 'package:tlr/Pages/subpages_pro/detail_pro.dart';
import 'package:tlr/Pages/subpages_pro/expired.dart';
import 'package:tlr/db/Vargloba.dart';

class ProductSFW extends StatefulWidget {
  List<Product> pro;
  ProductSFW({Key? key, required this.pro}) : super(key: key);

  @override
  State<ProductSFW> createState() => _ProductSFWState();
}

class _ProductSFWState extends State<ProductSFW> {
  List<Product> profiltered = pro;
  Widget? DisplayProduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DisplayProduct = ListView.builder(
        itemCount: profiltered.length * 2,
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) return Divider();
          int index = i ~/ 2;
          return buildcat(profiltered[index], context, index);
        });
  }

  @override
  Widget build(BuildContext context) {
    var k = MediaQuery.of(context).size.width / 6;
    var Searchsec = k * 3;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code_scanner,
                color: Colors.blueAccent,
              )),
          title: Container(
            color: Colors.white,
            width: Searchsec,
            child: TextFormField(
              onChanged: (value) {
                if (value.isEmpty || value == null) {
                  setState(() {
                    profiltered = pro;
                    DisplayProduct = ListView.builder(
                        itemCount: profiltered.length * 2,
                        itemBuilder: (BuildContext context, int i) {
                          if (i.isOdd) return Divider();
                          int index = i ~/ 2;
                          return buildcat(profiltered[index], context, index);
                        });
                  });
                } else {
                  setState(() {
                    List<Product> p = profiltered.where((element) {
                      bool t2 =
                          value.matchAsPrefix(element.Product_name) == null
                              ? false
                              : true;
                      bool t1 = element.Product_name.toUpperCase() ==
                          value.toUpperCase();
                      print("t1 : $t1\n t2 : $t2");
                      return t1 || t2;
                    }).toList();
                    DisplayProduct = ListView.builder(
                        itemCount: p.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            leading: Icon(Icons.dashboard),
                            title: Text(p[i].Product_name),
                            trailing: Text("${p[i].price} DA"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => detail_pro(d: p[i])));
                            },
                            subtitle: Text(
                                "Exp:${p[i].Expiredtime}|Quantity:${p[i].qte}"),
                          );
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
                hintText: 'Search ',
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
                    MaterialPageRoute(builder: (context) => add_pro()));
              },
              icon: Icon(Icons.add_box_outlined),
              color: Colors.blueAccent,
            )
          ],
        ),
        body: pro.length > 0
            ? DisplayProduct
            : Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cat.length > 0
                          ? TextButton.icon(
                              label: Text("Create Product"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => add_pro()));
                              },
                              icon: Icon(Icons.add),
                            )
                          : TextButton.icon(
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

  Widget buildcat(Product pro, context, int i) {
    print("id:");
    print(pro.id);

    var k = MediaQuery.of(context).size.width / 6;
    var Searchsec = k * 3;
    return i == 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Colors.amber.shade300,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: SizedBox(
                      height: 80.0,
                      width: (MediaQuery.of(context).size.width / 3) * 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.warning),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Alt_pro()));
                                },
                                child: Text(
                                  'Alert product',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.red.shade300,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    child: SizedBox(
                      height: 80.0,
                      width: (MediaQuery.of(context).size.width / 3) * 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.dangerous),
                          Container(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Exp_pro()));
                                },
                                child: Text(
                                  'Expired product',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text(pro.Product_name),
                trailing: Text("${pro.price} DA"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => detail_pro(d: pro)));
                },
                subtitle: Text("Exp:${pro.Expiredtime}|Quantity:${pro.qte}"),
              )
            ],
          )
        : ListTile(
            leading: Icon(Icons.dashboard),
            title: Text(pro.Product_name),
            trailing: Text("${pro.price} DA"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => detail_pro(d: pro)));
            },
            subtitle: Text("Exp:${pro.Expiredtime}|Quantity:${pro.qte}"),
          );
  }
}
