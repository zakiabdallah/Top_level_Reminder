import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlr/Pages/Home.dart';
import 'package:tlr/Pages/account.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/Pages/product.dart';
import 'package:tlr/Pages/statstique.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 2;

  final _pageOptions = [
    category(cat),
    product(pro),
    Home(),
    statstique(),
    account()
  ];

  double progressValue = 0;
  double _size = 150;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        if (progressValue == 100) {
          progressValue = 0;
        } else {
          progressValue++;
        }
      });
    }
    refreshDB_TLR();

    AwesomeNotifications().isNotificationAllowed().then((value) {
      if (!value) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Allow Notidication'),
                  content:
                      Text('our app  would  like to send  you  notfication'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Dont allow")),
                    TextButton(
                        onPressed: () {
                          AwesomeNotifications()
                              .requestPermissionToSendNotifications()
                              .then((_) => Navigator.pop(context));
                        },
                        child: Text("Allow")),
                  ],
                ));
      }
    });
  }

  @override
  void dispose() {
    DatabaseTLR.inst.close();
    super.dispose();
  }

  Future refreshDB_TLR() async {
    setState(() => isloading = true);
    print("1");
    try {
      pro = await DatabaseTLR.inst.readallProducts();
      setState(() => ProData = true);
    } catch (e) {
      setState(() => ProData = false);
    }
    print("2");
    try {
      cat = await DatabaseTLR.inst.readallCategory();
      setState(() => CatData = true);
    } catch (e) {
      setState(() => CatData = false);
    }
    setState(() => isloading = false);
    print("3");
    print(cat.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == false
          ? _pageOptions[selectedPage]
          : Center(child: circleLoading()),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.category, title: "Categories"),
          TabItem(icon: Icons.dashboard, title: "Product"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.bar_chart, title: "Statistique"),
          TabItem(icon: Icons.person, title: "Account"),
        ],
        initialActiveIndex: 2,
        onTap: (int i) {
          print('click index=$i');
          setState(() {
            selectedPage = i;
          });
        },
      ),
    );
  }

  Widget circleLoading() {
    return SizedBox(
        height: 150,
        width: 150,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.2,
                color: Color.fromARGB(30, 0, 169, 181),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    value: progressValue,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 75,
                    animationType: AnimationType.linear,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFa4edeb), Color(0xFF00a9b5)],
                        stops: <double>[0.25, 0.75])),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(positionFactor: 0.1, widget: Text('Loading...'))
              ]),
        ]));
  }
}
