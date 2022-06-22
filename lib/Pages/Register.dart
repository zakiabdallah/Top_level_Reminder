import 'dart:developer';

import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tlr/Model/user.dart';
import 'package:tlr/Pages/Connecter.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';

class Register extends StatefulWidget {
  String role;
  Register({Key? key, required this.role}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  late TabController tabController;
  var nextpageicon;
  var previouspageicon;
  String nameimg = "";
  String pageinfo = '';
  Widget orgafield = Text("");
  String? dropdownValue;
  var d2;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final OrgController = TextEditingController();
  bool passwordVisible = false;
  bool REpasswordVisible = false;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
    nextpageicon = Icons.arrow_forward;
    previouspageicon = null;
    nameimg = 'images/Register1.jpg';
    pageinfo = 'Personal information';
    if (widget.role == "Simple client" || widget.role == "....") {
      orgafield = Text("");
    } else {
      orgafield = TextFormField(
        decoration: const InputDecoration(
          label: Text('Organization',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
          icon: Icon(Icons.location_city, color: Colors.blueAccent),
        ),
        keyboardType: TextInputType.name,
        controller: OrgController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Organization is required';
          }
          return null;
        },
      );
    }
  }

  final FirstnameController = TextEditingController();
  final LastNameController = TextEditingController();
  final PlaceOfBirthController = TextEditingController();
  final AddressController = TextEditingController();
  final PhoneController = TextEditingController();
  final CRNController = TextEditingController();
  final EmailController = TextEditingController();
  final UserNameController = TextEditingController();
  final PasswordController = TextEditingController();
  final coPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FirstnameController.dispose();
    LastNameController.dispose();
    PlaceOfBirthController.dispose();
    AddressController.dispose();
    PhoneController.dispose();
    CRNController.dispose();
    EmailController.dispose();
    UserNameController.dispose();
    PasswordController.dispose();
    coPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ScreenSize = MediaQuery.of(context).size;
    log(tabController.length.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned(
            child: Container(
              width: ScreenSize.width,
              height: 29 * (ScreenSize.height) / 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        nameimg,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: ScreenSize.height / 8,
              ),
              AnimatedContainer(
                padding: const EdgeInsets.only(left: 30),
                height: ScreenSize.height / 6,
                duration: const Duration(seconds: 1),
                child: Text("${pageinfo} ",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        letterSpacing: 5,
                        color: Color.fromARGB(255, 252, 83, 83))),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                height: 7 * (ScreenSize.height / 10),
                alignment: Alignment.center,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: <Widget>[
                    AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        child: Form(
                          key: _formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: ScreenSize.width / 3,
                                    child: TextFormField(
                                      cursorColor: Colors.blueAccent,
                                      decoration: const InputDecoration(
                                        label: Text('First Name',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      controller: FirstnameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'First Name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenSize.width / 3,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        label: Text('Last Name',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      controller: LastNameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Last Name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ScreenSize.height / 32,
                              ),
                              DateTimeFormField(
                                decoration: const InputDecoration(
                                  label: Text('Birthday',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w500)),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  icon: Icon(Icons.event_note,
                                      color: Colors.blueAccent),
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                firstDate: DateTime(DateTime.now().year - 150,
                                    DateTime.now().month, DateTime.now().day),
                                lastDate: DateTime(DateTime.now().year - 18,
                                    DateTime.now().month, DateTime.now().day),
                                validator: (e) {
                                  if (e == null) {
                                    return 'Expired date  is required ';
                                  } else if ((e) == DateTime.now()) {
                                    return 'This date is Expired ';
                                  }
                                  return null;
                                },
                                onDateSelected: (DateTime value) {
                                  print(
                                      DateTime.now().difference(value).inDays);
                                  /*if (DateTime.now().difference(value).inDays >=
                                  29200) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Are you sure about this date  ${DateFormat.yMMMd().format(DateTime(value.year, value.month, value.day))} is your Birthday?",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {

                                              },
                                              child: Text("Yes")),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("No")),
                                        ],
                                      );
                                    });
                              }*/
                                  d2 = value;
                                },
                              ),
                              SizedBox(
                                height: ScreenSize.height / 32,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  icon: const Icon(Icons.home_filled,
                                      color: Colors.blueAccent),
                                  label: Text('Place of birth',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w500)),
                                ),
                                keyboardType: TextInputType.name,
                                controller: PlaceOfBirthController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Place of birth is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: ScreenSize.height / 32,
                              ),
                            ],
                          ),
                        )),
                    Form(
                        key: _formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Address',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500)),
                                icon: Icon(Icons.location_on,
                                    color: Colors.blueAccent),
                              ),
                              keyboardType: TextInputType.name,
                              controller: AddressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Phone',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500)),
                                icon:
                                    Icon(Icons.phone, color: Colors.blueAccent),
                              ),
                              keyboardType: TextInputType.name,
                              controller: PhoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone is required';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('CRN',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500)),
                                icon: Icon(Icons.numbers,
                                    color: Colors.blueAccent),
                              ),
                              keyboardType: TextInputType.name,
                              controller: CRNController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'CRN is required';
                                }
                                return null;
                              },
                            ),
                            orgafield
                          ],
                        )),
                    Form(
                      key: _formKey3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Email'),
                              icon: Icon(Icons.email, color: Colors.blueAccent),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: EmailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Username'),
                              icon:
                                  Icon(Icons.person, color: Colors.blueAccent),
                            ),
                            keyboardType: TextInputType.name,
                            controller: UserNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              label: Text('Password'),
                              icon: Icon(Icons.security,
                                  color: Colors.blueAccent),
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
                            controller: PasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            obscureText: !REpasswordVisible,
                            decoration: InputDecoration(
                              label: Text('Co-Password'),
                              icon: Icon(Icons.security,
                                  color: Colors.blueAccent),
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
                            controller: coPasswordController,
                            validator: (value) {
                              print(PasswordController.text.toString());
                              print(value.toString());
                              if (value == null || value.isEmpty) {
                                return 'Co-Password is required';
                              } else if (value != PasswordController.text) {
                                return 'Co-Password  do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/bottomR.jpg',
                        ),
                        fit: BoxFit.fill)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (tabController.index == 0) {
                            return;
                          } else if (tabController.index == 1) {
                            tabController.index = tabController.index - 1;
                            setState(() {
                              previouspageicon = null;
                              nameimg = 'images/Register1.jpg';
                              pageinfo = 'Personal Information';
                            });
                          } else if (tabController.index == 2) {
                            tabController.index = tabController.index - 1;
                            setState(() {
                              nextpageicon = Icons.arrow_forward;
                              nameimg = 'images/Register2.jpg';

                              pageinfo = 'Store \nInformation';
                            });
                          }
                        },
                        child: Icon(previouspageicon)),
                    TabPageSelector(
                      controller: tabController,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (tabController.index == 0 &&
                              _formKey1.currentState!.validate()) {
                            tabController.index = tabController.index + 1;
                            setState(() {
                              previouspageicon = Icons.arrow_back;
                              nameimg = 'images/Register2.jpg';
                              pageinfo = 'Store\nInformation';
                              if (widget.role == "Simple client" ||
                                  widget.role == "....") {
                                orgafield = Text("");
                              }
                            });
                          } else if (tabController.index == 1 &&
                              _formKey2.currentState!.validate()) {
                            tabController.index = tabController.index + 1;
                            setState(() {
                              nextpageicon = Icons.done;
                              nameimg = 'images/Register3.jpg';
                              pageinfo = 'Account Information';
                            });
                          } else if (tabController.index == 2 &&
                              _formKey3.currentState!.validate()) {
                            print('Registe');
                            if (widget.role == "Simple client" ||
                                widget.role == "....") {
                              await DatabaseTLR.inst.createUser(usersauth(
                                  First_name: FirstnameController.text,
                                  Last_name: LastNameController.text,
                                  Username: UserNameController.text,
                                  Email: EmailController.text,
                                  adress: AddressController.text,
                                  phone: PhoneController.text,
                                  Organization: "",
                                  Role: widget.role,
                                  url_img: "",
                                  Password: PasswordController.text,
                                  Data_createdTime: DateTime.now(),
                                  Data_LastModification: DateTime.now()));
                            } else {
                              await DatabaseTLR.inst.createUser(usersauth(
                                  First_name: FirstnameController.text,
                                  Last_name: LastNameController.text,
                                  Username: UserNameController.text,
                                  Email: EmailController.text,
                                  adress: AddressController.text,
                                  phone: PhoneController.text,
                                  Organization: OrgController.text,
                                  Role: widget.role,
                                  url_img: "",
                                  Password: PasswordController.text,
                                  Data_createdTime: DateTime.now(),
                                  Data_LastModification: DateTime.now()));
                            }
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => authscreen()));
                          }
                        },
                        child: Icon(nextpageicon))
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
