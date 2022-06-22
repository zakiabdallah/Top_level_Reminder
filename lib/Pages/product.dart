import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/subpages_cat/add_cat.dart';
import 'package:tlr/Pages/subpages_pro/Alert.dart';
import 'package:tlr/Pages/subpages_pro/add_pro.dart';
import 'package:tlr/Pages/subpages_pro/detail_pro.dart';
import 'package:tlr/Pages/subpages_pro/expired.dart';
import 'package:tlr/db/Vargloba.dart';

class product extends StatelessWidget {
  product(List<Product> pro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pro.length > 0
            ? ListView.builder(
                itemCount: pro.length * 2,
                itemBuilder: (BuildContext context, int i) {
                  if (i.isOdd) return Divider();
                  int index = i ~/ 2;
                  return buildcat(pro[index], context, index);
                })
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
    print(i);
    var k = MediaQuery.of(context).size.width / 6;
    var Searchsec = k * 3;
    return i == 0
        ? Padding(
            padding: EdgeInsets.fromLTRB(5, 30, 5, 5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: k,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.qr_code_scanner))),
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
                                        builder: (context) => add_pro()));
                              },
                              icon: Icon(Icons.add_box_outlined))),
                    ],
                  ),
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
                    subtitle:
                        Text("Exp:${pro.Expiredtime}|Quantity:${pro.qte}"),
                  )
                ]))
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
