import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> Notify(DateTime d, int i) async {
  print(i);
  String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  if (d.difference(DateTime.now()).inDays > 3) {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i,
          channelKey: 'basic_channel',
          title: 'Alert Product',
          body:
              'Your product will expired after ${d.difference(DateTime.now()).inDays} day(s)  ',
        ),
        schedule: NotificationCalendar(
            year: d.year,
            month: d.month,
            day: d.day - 4,
            hour: 4,
            minute: 42,
            preciseAlarm: true,
            timeZone: timezone));

    print(d.day - 4);
    print("Notification Created befor 3days");
  } else if (d.difference(DateTime.now()).inDays <= 3 &&
      d.difference(DateTime.now()).inDays > 0) {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: i,
        channelKey: 'basic_channel',
        title: 'Alert Product',
        body:
            'Your product will expired after ${d.difference(DateTime.now()).inDays} day(s) !',
      ),
    );
    print("Notification Created 5s");
  } else if (d.difference(DateTime.now()).inDays == 0) {
    if (d.difference(DateTime.now()).inHours > 0) {
      print(d.difference(DateTime.now()).inDays);
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: i,
          channelKey: 'basic_channel',
          title: 'Product Expired',
          body:
              'Your product will expired on few hours.\nDont forget to remove it  from your stock! ',
        ),
      );
      print("Notification Created 3s");
    }
  }
}
