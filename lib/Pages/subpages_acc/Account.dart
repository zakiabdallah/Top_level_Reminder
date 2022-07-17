import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Account_edit extends StatefulWidget {
  Account_edit({Key? key}) : super(key: key);

  @override
  State<Account_edit> createState() => _Account_editState();
}

class _Account_editState extends State<Account_edit> {
  final myController = TextEditingController();
  final myController1 = TextEditingController();

  final myController2 = TextEditingController();

  final myController3 = TextEditingController();
  final phoneController = TextEditingController();

  final myController4 = TextEditingController();
  final myController41 = TextEditingController();
  String? dropdownValue;
  bool passwordVisible = false;
  bool REpasswordVisible = false;

  @override
  void dispose() {
    myController.dispose();
    myController1.dispose();

    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController41.dispose();
    phoneController.dispose();
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
      print(image.path);
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
          title: Text(AppLocalizations.of(context)!.accountedit),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
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
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.firstName,
                              hintText: AppLocalizations.of(context)!.firstName,
                            ),
                            controller: myController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .firstNameisrequired;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.lastName,
                              hintText: AppLocalizations.of(context)!.lastName,
                            ),
                            controller: myController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .lastNameisrequired;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: AppLocalizations.of(context)!.email,
                      ),
                      controller: myController3,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.emailerr;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: AppLocalizations.of(context)!.phone,
                        hintText: AppLocalizations.of(context)!.phone,
                      ),
                      controller: myController3,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.phoneerr;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: AppLocalizations.of(context)!.username,
                        hintText: AppLocalizations.of(context)!.username,
                      ),
                      controller: myController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.usernameerr;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: myController4,
                      obscureText: !passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.passworderr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        hintText: AppLocalizations.of(context)!.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: myController41,
                      obscureText: !REpasswordVisible,
                      validator: (value) {
                        if (value != myController4) {
                          return AppLocalizations.of(context)!
                              .coopassworderrtwo;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.coopassword,
                        hintText: AppLocalizations.of(context)!.coopassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            REpasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              REpasswordVisible = !REpasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
