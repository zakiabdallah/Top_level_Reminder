import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Alt_pro extends StatefulWidget {
  Alt_pro({
    Key? key,
  }) : super(key: key);

  @override
  State<Alt_pro> createState() => _Alt_proState();
}

class _Alt_proState extends State<Alt_pro> {
  List<Product> Filter_pro = [];
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    print(to);
    print(from);
    return to.difference(from).inDays;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshDB_TLR();
    pro.forEach((element) {
      if (element.Expiredtime.difference(DateTime.now()).inDays > 0 &&
          element.Expiredtime.difference(DateTime.now()).inDays <= 3) {
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
            backgroundColor: Colors.amber,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.alertproduct,
              style: TextStyle(fontSize: 18),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                })),
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
                    children: [Text(AppLocalizations.of(context)!.noproduct)]),
              ));
  }

  Widget buildcat(Product pro, context, int i) {
    return ListTile(
      leading: Icon(Icons.category_outlined),
      title: Text(pro.Product_name),
      trailing: Text("${pro.price} DA"),
      onTap: () {},
      subtitle: Text(
          "${AppLocalizations.of(context)!.exp}:${pro.Expiredtime}|${AppLocalizations.of(context)!.quantity}:${pro.qte}"),
    );
  }
}
