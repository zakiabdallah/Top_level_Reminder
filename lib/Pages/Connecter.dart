import 'package:flutter/material.dart';
import 'package:tlr/Pages/Dashbord.dart';
import 'package:tlr/Pages/Register.dart';
import 'package:tlr/db/database.dart';

class authscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          SingleChildScrollView(
            child: Container(
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
                    child: AuthCard(),
                    flex: deviceSize.width > 600 ? 2 : 1,
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
  Lang({Key? key}) : super(key: key);

  @override
  State<Lang> createState() => _LangState();
}

class _LangState extends State<Lang> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        value: dropdownValue,
        hint: Text("Category"),
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
                    child: Text(value, style: TextStyle(color: Colors.black))),
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Username'),
                    icon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  keyboardType: TextInputType.name,
                  controller: UserController,
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
                    icon: Icon(Icons.security, color: Colors.blueAccent),
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
                      return 'Password not correct';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text(
                    'log in'.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      await DatabaseTLR.inst
                          .readuser(UserController.text, passController.text);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                "Username or password is not  correct ",
                                style: TextStyle(color: Colors.blue),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Ok")),
                              ],
                            );
                          });
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  color: Theme.of(context).primaryColor,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          String? role_C;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Choose Type of your account:\n-Simple client : it's for small business\n-.....:.......\n-Organization:it's for producer ",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  content: SingleChildScrollView(
                                      child: Form(
                                    key: _formKey,
                                    child: DropdownButtonFormField<String>(
                                        value: role_C,
                                        decoration: const InputDecoration(
                                          icon: const Icon(
                                              Icons.category_outlined),
                                          hintText: 'Account Type',
                                        ),
                                        icon: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                        elevation: 16,
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            role_C = newValue!;
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
                                                        style: TextStyle(
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
                                                                role:
                                                                    role_C!)));
                                          }
                                        },
                                        child: Text("Confarmation")),
                                  ],
                                );
                              });
                          /* Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Register()));*/
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Forget Password?",
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
