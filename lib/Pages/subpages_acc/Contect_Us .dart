import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contect_us extends StatefulWidget {
  Contect_us({Key? key}) : super(key: key);

  @override
  State<Contect_us> createState() => _Contect_usState();
}

class _Contect_usState extends State<Contect_us> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contect_us'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Text(
                          "E-mail : Trl@gmail.com",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Text(
                          "-Phone Number : 0555669436",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
