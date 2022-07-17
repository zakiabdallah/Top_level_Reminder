import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tlr/Pages/subpages_acc/Account.dart';
import 'package:tlr/Pages/subpages_acc/Contect_Us%20.dart';
import 'package:tlr/Pages/subpages_acc/Interface.dart';
import 'package:tlr/Pages/subpages_acc/Notification.dart';
import 'package:tlr/Pages/subpages_acc/feedback.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 30, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/person.png',
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 120.0,
                  ),
                ),
                Text(' Zakaria Salim')
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Divider(
                  color: Colors.black54,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                      leading: Icon(Icons.assignment_ind_outlined),
                      title: Text(AppLocalizations.of(context)!.account),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Account_edit())),
                    ),
                    ListTile(
                      leading: Icon(Icons.app_shortcut_outlined),
                      title: Text(AppLocalizations.of(context)!.interface),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Interface())),
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications_outlined),
                      title: Text(AppLocalizations.of(context)!.notification),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NotificationPage())),
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_support_outlined),
                      title: Text(AppLocalizations.of(context)!.contectus),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Contect_us())),
                    ),
                    ListTile(
                      leading: Icon(Icons.announcement_outlined),
                      title: Text(AppLocalizations.of(context)!.feedBack),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Feedback_page())),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
