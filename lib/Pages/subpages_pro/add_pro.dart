import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Model/Product.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/db/Vargloba.dart';
import 'dart:io';

import 'package:tlr/db/database.dart';

class add_pro extends StatefulWidget {
  const add_pro({Key? key}) : super(key: key);

  @override
  State<add_pro> createState() => _add_pro();
}

class _add_pro extends State<add_pro> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  DateTime d1 = DateTime(2022, 1, 1, 0, 0, 0, 0, 0);
  DateTime d2 = DateTime.now();
  File? image1;
  String? dropdownValue;
  double progressValue = 0;
  List<String> k = [];

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
    refreshcat();

    cat.forEach((element) {
      k.add(element.Category_name);
    });

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
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();

    super.dispose();
  }

  Future refreshcat() async {
    setState(() => isloading = true);
    cat = await DatabaseTLR.inst.readallCategory();
    setState(() => isloading = false);
  }

  Future pimg(ImageSource type) async {
    try {
      final image = await ImagePicker().pickImage(source: type);
      if (image == null) return;
      final imagetp = File(image.path);
      setState(() {
        this.image1 = imagetp;
      });
    } on PlatformException catch (e) {
      print("Failed to  pick image : $e");
    }
  }

  int id = 0;
  final _formKey = GlobalKey<FormState>();
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      pimg(ImageSource.gallery);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      pimg(ImageSource.camera);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add Product'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  DateTime newdate = DateTime(
                      d2.year, d2.month, d2.day, d2.hour, d2.minute, d2.second);

                  if (_formKey.currentState!.validate() && image1 != null) {
                    await DatabaseTLR.inst.createProducts(Product(
                        Product_name: myController1.text,
                        cat_id: k.indexOf(dropdownValue!) + 1,
                        Expiredtime: newdate,
                        qte: double.parse(myController2.text),
                        price: double.parse(myController3.text),
                        alert: newdate.difference(DateTime.now()).inDays > 3
                            ? false
                            : true,
                        url_img: File(image1!.path).toString(),
                        Data_createdTime: DateTime.now(),
                        Data_LastModification: DateTime.now()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Done "),
                    ));
                  } else if (_formKey.currentState!.validate()) {
                    await DatabaseTLR.inst.createProducts(Product(
                        Product_name: myController1.text,
                        cat_id: k.indexOf(dropdownValue!) + 1,
                        Expiredtime: newdate,
                        qte: double.parse(myController2.text),
                        price: double.parse(myController3.text),
                        alert: newdate.difference(DateTime.now()).inDays > 3
                            ? false
                            : true,
                        url_img: "",
                        Data_createdTime: DateTime.now(),
                        Data_LastModification: DateTime.now()));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Done "),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Error: Try agine "),
                    ));
                  }
                },
                icon: Icon(Icons.save))
          ]),
      body: isloading == false
          ? SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          image1 == null
                              ? Container(
                                  padding: EdgeInsets.all(8), // Border width
                                  color: Colors.grey.shade400,
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(24), // Image radius
                                      child: IconButton(
                                          onPressed: () {
                                            _showChoiceDialog(context);
                                          },
                                          icon: Icon(Icons.add_a_photo)),
                                    ),
                                  ),
                                )
                              : Container(
                                  child: Image.file(
                                  image1!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )),
                        ],
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.label_important),
                          hintText: 'Enter Product name',
                        ),
                        controller: myController1,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Product name is required';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.shopping_bag_outlined),
                          hintText: 'Enter Quantity',
                        ),
                        controller: myController2,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.monetization_on_outlined),
                          hintText: 'Enter Price',
                        ),
                        controller: myController3,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                      ),
                      DateTimeFormField(
                        decoration: const InputDecoration(
                          hintText: "Expired date",
                          hintStyle: TextStyle(color: Colors.black45),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          icon: Icon(Icons.event_note),
                        ),
                        mode: DateTimeFieldPickerMode.dateAndTime,
                        firstDate: DateTime(DateTime.now().year - 20),
                        lastDate: DateTime(DateTime.now().year + 150),
                        validator: (e) {
                          if (e == null) {
                            return 'Expired date  is required ';
                          } else if ((e) == DateTime.now()) {
                            return 'This date is Expired ';
                          }
                          return null;
                        },
                        onDateSelected: (DateTime value) {
                          d2 = value;
                        },
                      ),
                      DropdownButtonFormField<String>(
                          value: dropdownValue,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.category_outlined),
                            hintText: 'Enter Quntity',
                          ),
                          icon: const Icon(Icons.arrow_drop_down_sharp),
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          validator: (value) =>
                              value == null ? "Category is required" : null,
                          items:
                              k.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  widthFactor: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(value,
                                          style:
                                              TextStyle(color: Colors.black))),
                                ));
                          }).toList()),
                    ]),
              ),
            )
          : Center(child: circleLoading()),
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
