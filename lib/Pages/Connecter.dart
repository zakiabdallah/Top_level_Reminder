import 'package:flutter/material.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/Register.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class authscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      child: Image.asset('images/Fakarni!!.png'),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Lang extends StatefulWidget {
  const Lang({Key? key}) : super(key: key);

  @override
  State<Lang> createState() => _LangState();
}

class _LangState extends State<Lang> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: dropdownValue,
        hint:  Text("Category"),
        decoration: const InputDecoration(
          icon: Icon(Icons.category_outlined),
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
            dropdownValue == null ? "Category is required" : null,
        items: <String>['English', 'Franch', 'Arabe']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Center(
                widthFactor: 1,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(value,
                        style: const TextStyle(color: Colors.black))),
              ));
        }).toList());
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyLogin = GlobalKey<FormState>();
  final UserController = TextEditingController();
  final passController = TextEditingController();
  bool passwordVisible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    UserController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration:  InputDecoration(
                    label: Text(AppLocalizations.of(context)!.username),
                    icon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  keyboardType: TextInputType.name,
                  controller: UserController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.usernameerr;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    label:  Text(AppLocalizations.of(context)!.password),
                    icon: const Icon(Icons.security, color: Colors.blueAccent),
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
                  controller: passController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.passwordnotcorrect;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async {
                    try {
                      auth = await DatabaseTLR.inst
                          .readuser(UserController.text, passController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:  Text(
                                AppLocalizations.of(context)!.userandpassworderr,
                                style: TextStyle(color: Colors.blue),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child:  Text(AppLocalizations.of(context)!.ok)),
                              ],
                            );
                          });
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'log in'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          String? roleC;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Choose Type of your account:\n-Simple client : it's for small business\n-.....:.......\n-Organization:it's for producer ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  content: SingleChildScrollView(
                                      child: Form(
                                    key: _formKey,
                                    child: DropdownButtonFormField<String>(
                                        value: roleC,
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.accessibility_new),
                                          hintText: 'Account Type',
                                        ),
                                        icon: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                        elevation: 16,
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            roleC = newValue!;
                                          });
                                        },
                                        validator: (value) => value == null
                                            ? " Account Type is required"
                                            : null,
                                        items: [
                                          "Simple client",
                                          "....",
                                          "Organization"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Center(
                                                widthFactor: 1,
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12),
                                                    child: Text(value,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black))),
                                              ));
                                        }).toList()),
                                  )),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Register(
                                                                role: roleC!)));
                                          }
                                        },
                                        child: const Text("Confarmation")),
                                  ],
                                );
                              });
                          /* Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Register()));*/
                        },
                      ),
                      TextButton(
                        child:  Text(
                          AppLocalizations.of(context)!.forgetpassword,
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {},
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
