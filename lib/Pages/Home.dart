import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class searchitems {
  final String name;
  final String type;
  searchitems({required this.name, required this.type});
}

class _HomeState extends State<Home> {
  late List<PieData> _piedata = [
    PieData("Bimo", 32),
    PieData("condia", 23),
    PieData("Milka", 30),
    PieData("others", 15),
  ];
  List allproduct = [...pro, ...cat];
  List<searchitems> filter = [];
  Widget? DisplayHome;
  Widget? Displaysearch;
  bool issearch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        DisplayHome = SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 20),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.statistic,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_circle_right),
                                  )
                                ],
                              ),
                            ),
                            SfCircularChart(
                              title: ChartTitle(
                                text:
                                    AppLocalizations.of(context)!.yourbestsales,
                              ),
                              legend: Legend(isVisible: true),
                              series: <CircularSeries>[
                                PieSeries<PieData, String>(
                                    dataSource: _piedata,
                                    xValueMapper: (PieData data, _) =>
                                        data.text,
                                    yValueMapper: (PieData data, _) => data.pb,
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true)),
                              ],
                            ),
                            SfCartesianChart(
                              title: ChartTitle(
                                  text:
                                      AppLocalizations.of(context)!.yourstock),
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                                title: AxisTitle(
                                    text: AppLocalizations.of(context)!
                                        .categoriesonstock),
                              ),
                              primaryYAxis: NumericAxis(
                                  labelFormat: '{value}',
                                  title: AxisTitle(
                                      text: AppLocalizations.of(context)!
                                          .productonstock),
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                  majorTickLines:
                                      const MajorTickLines(size: 0)),
                              series: <ChartSeries<ChartSampleData, String>>[
                                ColumnSeries<ChartSampleData, String>(
                                  onCreateRenderer:
                                      (ChartSeries<ChartSampleData, String>
                                          series) {
                                    return _CustomColumnSeriesRenderer();
                                  },
                                  dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.middle),
                                  dataSource: <ChartSampleData>[
                                    ChartSampleData(
                                        x: 'oils',
                                        y: 1241,
                                        pointColor: const Color.fromARGB(
                                            53, 92, 125, 1)),
                                    ChartSampleData(
                                        x: 'Sugars',
                                        y: 1332,
                                        pointColor: const Color.fromARGB(
                                            192, 108, 132, 1)),
                                    ChartSampleData(
                                        x: 'Cocoa ',
                                        y: 918,
                                        pointColor: const Color.fromARGB(
                                            246, 114, 128, 1)),
                                    ChartSampleData(
                                        x: 'cereals',
                                        y: 456,
                                        pointColor: const Color.fromARGB(
                                            248, 177, 149, 1)),
                                    ChartSampleData(
                                        x: 'Beverages',
                                        y: 529,
                                        pointColor: const Color.fromARGB(
                                            116, 180, 155, 1)),
                                  ],
                                  width: 0.8,
                                  xValueMapper: (ChartSampleData sales, _) =>
                                      sales.x as String,
                                  yValueMapper: (ChartSampleData sales, _) =>
                                      sales.y,
                                  pointColorMapper:
                                      (ChartSampleData sales, _) =>
                                          sales.pointColor,
                                )
                              ],
                              tooltipBehavior: TooltipBehavior(
                                  enable: true,
                                  canShowMarker: false,
                                  header: ''),
                            ),
                          ]),
                    ])));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: TextFormField(
            onChanged: ((value) {
              if (value == null || value.isEmpty) {
                setState(() {
                  issearch = false;
                  DisplayHome = SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        color: Colors.white70,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            topLeft: Radius.circular(30.0),
                                            bottomLeft: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 150.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Categories',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: cat.length,
                                                    itemBuilder:
                                                        (BuildContext ctx,
                                                            index) {
                                                      if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Vêtements"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(Icons
                                                                .checkroom_outlined),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Santé"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(Icons
                                                                .monitor_heart),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Produits d' Entretien"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(Icons
                                                                .construction),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Nettoyage"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(Icons
                                                                .cleaning_services),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Plomberie"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.plumbing),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Chauffage"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.hvac),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Ventilation"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Climatisation"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Boisson"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Tabac"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Nourriture"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Meubles Domestiques"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "De Bureau"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Ameublement"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Matériels Electriques"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Informatique") {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Equipements Sportifs"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Equipement de la Maison"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Beauté"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Soin Personnel"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else if (cat[index]
                                                              .type
                                                              .toUpperCase() ==
                                                          "Hygiène"
                                                              .toUpperCase()) {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      } else {
                                                        return Chip(
                                                            avatar: Icon(
                                                                Icons.category),
                                                            label: Text(
                                                                "${cat[index].Category_name}"));
                                                      }
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .statistic,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.arrow_circle_right),
                                            )
                                          ],
                                        ),
                                      ),
                                      SfCircularChart(
                                        title: ChartTitle(
                                          text: AppLocalizations.of(context)!
                                              .yourbestsales,
                                        ),
                                        legend: Legend(isVisible: true),
                                        series: <CircularSeries>[
                                          PieSeries<PieData, String>(
                                              dataSource: _piedata,
                                              xValueMapper: (PieData data, _) =>
                                                  data.text,
                                              yValueMapper: (PieData data, _) =>
                                                  data.pb,
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true)),
                                        ],
                                      ),
                                      SfCartesianChart(
                                        title: ChartTitle(
                                            text: AppLocalizations.of(context)!
                                                .yourstock),
                                        primaryXAxis: CategoryAxis(
                                          majorGridLines:
                                              const MajorGridLines(width: 0),
                                          title: AxisTitle(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .categoriesonstock),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            labelFormat: '{value}',
                                            title: AxisTitle(
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .productonstock),
                                            majorGridLines:
                                                const MajorGridLines(width: 0),
                                            majorTickLines:
                                                const MajorTickLines(size: 0)),
                                        series: <
                                            ChartSeries<ChartSampleData,
                                                String>>[
                                          ColumnSeries<ChartSampleData, String>(
                                            onCreateRenderer: (ChartSeries<
                                                    ChartSampleData, String>
                                                series) {
                                              return _CustomColumnSeriesRenderer();
                                            },
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true,
                                                    labelAlignment:
                                                        ChartDataLabelAlignment
                                                            .middle),
                                            dataSource: <ChartSampleData>[
                                              ChartSampleData(
                                                  x: AppLocalizations.of(
                                                          context)!
                                                      .oils,
                                                  y: 1241,
                                                  pointColor:
                                                      const Color.fromARGB(
                                                          53, 92, 125, 1)),
                                              ChartSampleData(
                                                  x: AppLocalizations.of(
                                                          context)!
                                                      .sugars,
                                                  y: 1332,
                                                  pointColor:
                                                      const Color.fromARGB(
                                                          192, 108, 132, 1)),
                                              ChartSampleData(
                                                  x: AppLocalizations.of(
                                                          context)!
                                                      .cocoa,
                                                  y: 918,
                                                  pointColor:
                                                      const Color.fromARGB(
                                                          246, 114, 128, 1)),
                                              ChartSampleData(
                                                  x: AppLocalizations.of(
                                                          context)!
                                                      .cereals,
                                                  y: 456,
                                                  pointColor:
                                                      const Color.fromARGB(
                                                          248, 177, 149, 1)),
                                              ChartSampleData(
                                                  x: AppLocalizations.of(
                                                          context)!
                                                      .beverages,
                                                  y: 529,
                                                  pointColor:
                                                      const Color.fromARGB(
                                                          116, 180, 155, 1)),
                                            ],
                                            width: 0.8,
                                            xValueMapper:
                                                (ChartSampleData sales, _) =>
                                                    sales.x as String,
                                            yValueMapper:
                                                (ChartSampleData sales, _) =>
                                                    sales.y,
                                            pointColorMapper:
                                                (ChartSampleData sales, _) =>
                                                    sales.pointColor,
                                          )
                                        ],
                                        tooltipBehavior: TooltipBehavior(
                                            enable: true,
                                            canShowMarker: false,
                                            header: ''),
                                      ),
                                    ]),
                              ])));
                });
              } else {
                int contP = 0;
                int contC = 0;
                setState(() {
                  issearch = true;
                  filter.clear();
                  allproduct.forEach((element) {
                    if (element.runtimeType == Product) {
                      bool t2 =
                          value.matchAsPrefix(element.Product_name) == null
                              ? false
                              : true;
                      bool t1 = element.Product_name.toUpperCase() ==
                          value.toUpperCase();
                      if (t1 || t2) {
                        filter.add(searchitems(
                            name: element.Product_name, type: "Product"));
                        contP = contP + 1;
                      }
                    } else {
                      bool t2 =
                          value.matchAsPrefix(element.Category_name) == null
                              ? false
                              : true;
                      bool t1 = element.Category_name.toUpperCase() ==
                          value.toUpperCase();
                      if (t1 || t2) {
                        filter.add(searchitems(
                            name: element.Category_name, type: "Category"));
                        contC = contC + 1;
                      }
                    }
                  });

                  Displaysearch = Column(
                    children: [
                      Text(AppLocalizations.of(context)!.product),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filter
                              .where((element) => element.type == "Product")
                              .length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filter[index].name),
                            );
                          },
                        ),
                      ),
                      Divider(),
                      Text(AppLocalizations.of(context)!.category),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filter
                              .where((element) => element.type == "Category")
                              .length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filter[index].name),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                });
                log("hi");
              }
            }),
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(.4),
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
              hintText: AppLocalizations.of(context)!.search,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        body: issearch!
            ? Displaysearch
            : DisplayHome = SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.white70,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                      bottomLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 150.0,
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: cat.length,
                                              itemBuilder:
                                                  (BuildContext ctx, index) {
                                                if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Vêtements".toUpperCase()) {
                                                  return Chip(
                                                      avatar: Icon(Icons
                                                          .checkroom_outlined),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Santé".toUpperCase()) {
                                                  return Chip(
                                                      avatar: Icon(
                                                          Icons.monitor_heart),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Produits d' Entretien"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar: Icon(
                                                          Icons.construction),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Nettoyage".toUpperCase()) {
                                                  return Chip(
                                                      avatar: Icon(Icons
                                                          .cleaning_services),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Plomberie".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.plumbing),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Chauffage".toUpperCase()) {
                                                  return Chip(
                                                      avatar: Icon(Icons.hvac),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Ventilation"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Climatisation"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Boisson".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Tabac".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Nourriture"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Meubles Domestiques"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "De Bureau".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Ameublement"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Matériels Electriques"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Informatique") {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Equipements Sportifs"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Equipement de la Maison"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Beauté".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Soin Personnel"
                                                        .toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else if (cat[index]
                                                        .type
                                                        .toUpperCase() ==
                                                    "Hygiène".toUpperCase()) {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                } else {
                                                  return Chip(
                                                      avatar:
                                                          Icon(Icons.category),
                                                      label: Text(
                                                          "${cat[index].Category_name}"));
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.statistic,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.arrow_circle_right),
                                      )
                                    ],
                                  ),
                                ),
                                SfCircularChart(
                                  title: ChartTitle(
                                    text: AppLocalizations.of(context)!
                                        .yourbestsales,
                                  ),
                                  legend: Legend(isVisible: true),
                                  series: <CircularSeries>[
                                    PieSeries<PieData, String>(
                                        dataSource: _piedata,
                                        xValueMapper: (PieData data, _) =>
                                            data.text,
                                        yValueMapper: (PieData data, _) =>
                                            data.pb,
                                        dataLabelSettings:
                                            DataLabelSettings(isVisible: true)),
                                  ],
                                ),
                                SfCartesianChart(
                                  title: ChartTitle(
                                      text: AppLocalizations.of(context)!
                                          .yourstock),
                                  primaryXAxis: CategoryAxis(
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                    title: AxisTitle(
                                        text: AppLocalizations.of(context)!
                                            .categoriesonstock),
                                  ),
                                  primaryYAxis: NumericAxis(
                                      labelFormat: '{value}',
                                      title: AxisTitle(
                                          text: AppLocalizations.of(context)!
                                              .productonstock),
                                      majorGridLines:
                                          const MajorGridLines(width: 0),
                                      majorTickLines:
                                          const MajorTickLines(size: 0)),
                                  series: <
                                      ChartSeries<ChartSampleData, String>>[
                                    ColumnSeries<ChartSampleData, String>(
                                      onCreateRenderer:
                                          (ChartSeries<ChartSampleData, String>
                                              series) {
                                        return _CustomColumnSeriesRenderer();
                                      },
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true,
                                              labelAlignment:
                                                  ChartDataLabelAlignment
                                                      .middle),
                                      dataSource: <ChartSampleData>[
                                        ChartSampleData(
                                            x: AppLocalizations.of(context)!
                                                .oils,
                                            y: 1241,
                                            pointColor: const Color.fromARGB(
                                                53, 92, 125, 1)),
                                        ChartSampleData(
                                            x: AppLocalizations.of(context)!
                                                .sugars,
                                            y: 1332,
                                            pointColor: const Color.fromARGB(
                                                192, 108, 132, 1)),
                                        ChartSampleData(
                                            x: AppLocalizations.of(context)!
                                                .cocoa,
                                            y: 918,
                                            pointColor: const Color.fromARGB(
                                                246, 114, 128, 1)),
                                        ChartSampleData(
                                            x: AppLocalizations.of(context)!
                                                .cereals,
                                            y: 456,
                                            pointColor: const Color.fromARGB(
                                                248, 177, 149, 1)),
                                        ChartSampleData(
                                            x: AppLocalizations.of(context)!
                                                .beverages,
                                            y: 529,
                                            pointColor: const Color.fromARGB(
                                                116, 180, 155, 1)),
                                      ],
                                      width: 0.8,
                                      xValueMapper:
                                          (ChartSampleData sales, _) =>
                                              sales.x as String,
                                      yValueMapper:
                                          (ChartSampleData sales, _) => sales.y,
                                      pointColorMapper:
                                          (ChartSampleData sales, _) =>
                                              sales.pointColor,
                                    )
                                  ],
                                  tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                      canShowMarker: false,
                                      header: ''),
                                ),
                              ]),
                        ]))));
  }
}

/*
  
                */
class ChartSampleData {
  ChartSampleData({required this.x, required this.y, required this.pointColor});
  final String x;
  final double y;
  final Color pointColor;
}

class PieData {
  PieData(this.text, this.pb);
  final double pb;
  final String text;
}

class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  ChartSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends ColumnSegment {
  List<Color> colorList = <Color>[
    const Color.fromRGBO(53, 92, 125, 1),
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1)
  ];
  @override
  int get currentSegmentIndex => super.currentSegmentIndex!;

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.isAntiAlias = false;
    customerStrokePaint.color = Colors.transparent;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  @override
  void onPaint(Canvas canvas) {
    double x, y;
    x = segmentRect.center.dx;
    y = segmentRect.top;
    double width = 0;
    const double height = 20;
    width = segmentRect.width;
    final Paint paint = Paint();
    paint.color = getFillPaint().color;
    paint.style = PaintingStyle.fill;
    final Path path = Path();
    final double factor = segmentRect.height * (1 - animationFactor);
    path.moveTo(x - width / 2, y + factor + height);
    path.lineTo(x, (segmentRect.top + factor + height) - height);
    path.lineTo(x + width / 2, y + factor + height);
    path.lineTo(x + width / 2, segmentRect.bottom + factor);
    path.lineTo(x - width / 2, segmentRect.bottom + factor);
    path.close();
    canvas.drawPath(path, paint);
  }
}
