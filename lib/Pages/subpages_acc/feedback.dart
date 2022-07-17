import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Feedback_page extends StatefulWidget {
  Feedback_page({Key? key}) : super(key: key);

  @override
  State<Feedback_page> createState() => _Feedback_pageState();
}

class _Feedback_pageState extends State<Feedback_page> {
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
          title: Text(AppLocalizations.of(context)!.feedBack),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed("/home");
                },
                icon: Icon(Icons.save))
          ],
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
                    Text("${AppLocalizations.of(context)!.feedbackm}:"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:
                            '${AppLocalizations.of(context)!.feedbackmessage}...',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      controller: myController,
                      keyboardType: TextInputType.name,
                      maxLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.feedbackerr;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
