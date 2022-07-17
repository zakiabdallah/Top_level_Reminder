import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/db/Vargloba.dart';
import 'package:tlr/db/database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isSwitched1 = false;
  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
      });
      print('Switch Button is OFF');
    }
  }

  bool isSwitched2 = false;
  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
  }

  String dropdownValue1 = 'Sound1';
  String dropdownValue2 = 'arial';
  String dropdownValue3 = '3 Days';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notification),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await DatabaseTLR.inst.updateStyle(your_style!);
                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(
                          AppLocalizations.of(context)!.messageerr,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w200),
                        ));
                      });
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "\t ${AppLocalizations.of(context)!.notificationAlart}",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              DropdownButton<String>(
                  value: your_style!.NotificationAlert.toString() +
                      " ${AppLocalizations.of(context)!.days}",
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      your_style!.NotificationAlert = int.parse(newValue![0]);
                    });
                  },
                  items: <String>[
                    '3 ${AppLocalizations.of(context)!.days}',
                    '4 ${AppLocalizations.of(context)!.days}',
                    '5 ${AppLocalizations.of(context)!.days}',
                    '6 ${AppLocalizations.of(context)!.days}',
                    '7 ${AppLocalizations.of(context)!.days}'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
          Row(
            children: [
              Text(
                "\t ${AppLocalizations.of(context)!.notificationsound} ",
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              DropdownButton<String>(
                  value: your_style!.NotificationSound,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      your_style!.NotificationSound = newValue!;
                    });
                  },
                  items: <String>['sound1', 'sound2', 'sound3']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList())
            ],
          ),
        ],
      ),
    );
  }
}
