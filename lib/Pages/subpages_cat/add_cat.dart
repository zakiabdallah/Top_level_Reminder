import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/db/Vargloba.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tlr/db/database.dart';

class add_cat extends StatefulWidget {
  const add_cat({Key? key}) : super(key: key);

  @override
  State<add_cat> createState() => _add_cat();
}

class _add_cat extends State<add_cat> {
  final myController = TextEditingController();
  String? dropdownValue;

  @override
  void dispose() {
    DatabaseTLR.inst.close();

    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshDB_TLR();
  }

  final _picker = ImagePicker();
  File? image1;
  Future pimg(ImageSource type) async {
    print(type);
    try {
      final image = await _picker.pickImage(source: type);

      if (image == null) return;

      final imagetp = File(image.path);
      print(image.path);
      setState(() {
        this.image1 = imagetp;
      });
    } on PlatformException catch (e) {
      print("Failed to  pick image : $e");
    }
  }
//Path: File: '/data/user/0/com.example.tlr/cache/039182de-9389-493d-b05e-bc9c240338906441946433645413570.jpg'

  Future refreshDB_TLR() async {
    setState(() => isloading = true);

    try {
      cat = await DatabaseTLR.inst.readallCategory();
      setState(() => CatData = true);
    } catch (e) {
      setState(() => CatData = false);
    }
    setState(() => isloading = false);

    print(cat.length);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "${AppLocalizations.of(context)!.chooseoption}",
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
                    title: Text(AppLocalizations.of(context)!.gallery),
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
                    title: Text(AppLocalizations.of(context)!.camera),
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addCategory),
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
                  print(dropdownValue.toString());
                  if (_formKey.currentState!.validate() && image1 != null) {
                    await DatabaseTLR.inst.createCategory(CategoryP(
                        Category_name: myController.text,
                        type: dropdownValue.toString(),
                        url_img: image1.toString(),
                        Data_createdTime: DateTime.now(),
                        Data_LastModification: DateTime.now()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${myController.text} was add to list "),
                    ));
                  } else if (_formKey.currentState!.validate()) {
                    await DatabaseTLR.inst.createCategory(CategoryP(
                        Category_name: myController.text,
                        type: dropdownValue.toString(),
                        url_img: "",
                        Data_createdTime: DateTime.now(),
                        Data_LastModification: DateTime.now()));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${myController.text} was created  "),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${AppLocalizations.of(context)!.error}: ${AppLocalizations.of(context)!.tryagain}"),
                    ));
                  }
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                                child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.file(
                                    image1!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 150,
                                    child: TextButton(
                                        onPressed: () {
                                          _showChoiceDialog(context);
                                        },
                                        child: Text("")),
                                  )
                                ],
                              )),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.label_important),
                        hintText: AppLocalizations.of(context)!.categoryname,
                      ),
                      controller: myController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.categorynameerr;
                        }
                        return null;
                      },
                    ),
                    //TODO:how let DropdownButton dont display  all text  flutter
                    DropdownButtonFormField<String>(
                        menuMaxHeight: 250.0,
                        alignment: Alignment.bottomLeft,
                        value: dropdownValue,
                        hint: Text(AppLocalizations.of(context)!.category),
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.category_outlined),
                        ),
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        elevation: 16,
                        style: const TextStyle(color: Colors.blue),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        validator: (value) => dropdownValue == null
                            ? AppLocalizations.of(context)!.categoryerr
                            : null,
                        items: all_catgories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                widthFactor: 1,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(value,
                                        style: TextStyle(color: Colors.black))),
                              ));
                        }).toList()),
                  ]),
            )));
  }
}
