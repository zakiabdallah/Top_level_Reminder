import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tlr/Model/Category.dart';
import 'package:tlr/Pages/category.dart';
import 'package:tlr/Pages/subpages_cat/detail_cat.dart';
import 'package:tlr/db/Vargloba.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tlr/db/database.dart';

class edit_cat extends StatefulWidget {
  edit_cat({Key? key, required this.c}) : super(key: key);
  CategoryP c;
  @override
  State<edit_cat> createState() => _edit_cat();
}

class _edit_cat extends State<edit_cat> {
  final myController = TextEditingController();
  String? dropdownValue;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  final _picker = ImagePicker();
  File? image1;
  Future pimg(ImageSource type) async {
    print(type);
    try {
      final image = await _picker.pickImage(source: type);
      if (image == null) return;
      final imagetp = File(image.path);
      setState(() {
        this.image1 = imagetp;
      });
    } on PlatformException catch (e) {
      print("Failed to  pick image : $e");
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.chooseoption,
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => deatail_cat(
                          i: widget.c,
                        )));
              },
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    print(dropdownValue.toString());
                    if (_formKey.currentState!.validate() && image1 != null) {
                      await DatabaseTLR.inst.updateCategory(CategoryP(
                          id: widget.c.id,
                          Category_name: myController.text,
                          type: dropdownValue.toString(),
                          url_img: image1.toString(),
                          Data_createdTime: DateTime.now(),
                          Data_LastModification: DateTime.now()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${widget.c.Category_name} was change to${myController.text}"),
                      ));
                    } else if (_formKey.currentState!.validate()) {
                      await DatabaseTLR.inst.updateCategory(CategoryP(
                          id: widget.c.id,
                          Category_name: myController.text,
                          type: dropdownValue.toString(),
                          url_img: "",
                          Data_createdTime: DateTime.now(),
                          Data_LastModification: DateTime.now()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${widget.c.Category_name} was change to${myController.text}"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${AppLocalizations.of(context)!.error}: ${AppLocalizations.of(context)!.tryagain} "),
                      ));
                    }
                  },
                  icon: Icon(Icons.save))
            ]),
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
                        icon: const Icon(Icons.label_important),
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
                        value: dropdownValue,
                        hint: Text(AppLocalizations.of(context)!.category),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.category_outlined),
                          hintText: AppLocalizations.of(context)!.category,
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
