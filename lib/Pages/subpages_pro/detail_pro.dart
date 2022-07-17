import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/subpages_pro/edit_pro.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class detail_pro extends StatefulWidget {
  detail_pro({Key? key, required this.d}) : super(key: key);
  Product d;
  @override
  State<detail_pro> createState() => _detail_proState();
}

class _detail_proState extends State<detail_pro> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Product"), actions: [
        IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => edit_pro(
                      p: widget.d,
                    )));
          },
        ),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "images/product.ico",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TabBar(
                controller: tabController,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      AppLocalizations.of(context)!.details,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      AppLocalizations.of(context)!.tips,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  height: 150.0,
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.name}:${widget.d.Product_name}"),
                          Text(
                              "${AppLocalizations.of(context)!.quantity}:${widget.d.qte}"),
                          Text(
                              "${AppLocalizations.of(context)!.price}:${widget.d.price}"),
                          Text(
                              "${AppLocalizations.of(context)!.expiredtime}:${widget.d.Expiredtime}")
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text("${AppLocalizations.of(context)!.ptips}:"),
                          Text("\t - ${AppLocalizations.of(context)!.tip}1"),
                          Text("\t - ${AppLocalizations.of(context)!.tip}2"),
                          Text("\t -${AppLocalizations.of(context)!.tip}3"),
                          Text("\t - ${AppLocalizations.of(context)!.tip}4")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
