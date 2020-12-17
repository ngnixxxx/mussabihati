import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

class NotificationPlugin {
  //
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotification>
      didReceivedLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  var initializationSettings;
  NotificationPlugin._() {
    init();
  }
  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotification receivedNotification = ReceivedNotification(
            id: id, title: title, body: body, payload: payload);
        didReceivedLocalNotificationSubject.add(receivedNotification);
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      await onNotificationClick(payload);
    });
  }

  Future<void> showDailyAtTime(int hour, int minute, int seconds) async {
    var time = Time(hour, minute, seconds);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      9,
      'تذكير بقراءة الأذكار',
      null, //null
      time,
      platformChannelSpecifics,
      payload:
          '${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute, time.second).millisecondsSinceEpoch}',
    );
  }

  Future<void> showWeeklyAtDayTime(int day, int hour, int minute, int seconds) async {
    var time = Time(hour, minute, seconds);
    Day daySelected;
    if (day == 1) {
      daySelected = Day.monday;
    } else if (day == 2) {
      daySelected = Day.tuesday;
    } else if (day == 3) {
      daySelected = Day.wednesday;
    } else if (day == 4) {
      daySelected = Day.thursday;
    } else if (day == 5) {
      daySelected = Day.friday;
    } else if (day == 6) {
      daySelected = Day.saturday;
    } else {
      daySelected = Day.sunday;
    }
    DateTime now = DateTime.now();

    while (now.weekday != day) {
      now = now.add(new Duration(days: 1));
    }
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 4',
      'CHANNEL_NAME 4',
      "CHANNEL_DESCRIPTION 4",
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      day,
      'تذكير بقراءة الأذكار',
      null, //null
      daySelected,
      time,
      platformChannelSpecifics,
      payload:
          '${DateTime(DateTime.now().year, DateTime.now().month, now.day, time.hour, time.minute, time.second).millisecondsSinceEpoch}',
    ).then((value) => print(now.day));
  }

  Future<void> scheduleNotification(dateTime) async {
    DateTime time = dateTime;
    var androidChannelSpecifics = AndroidNotificationDetails(
      'Notification',
      'Notification',
      "Only once reminder",
      //This is where you add the custom notification sound the sound file should be in the android/res/drawable
      /*sound: RawResourceAndroidNotificationSound('my_sound'),*/
      enableLights: true,
      ledColor: Colors.orange,
      ledOnMs: 1000,
      ledOffMs: 500,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
        //This is where you add the custom notification sound the sound in ios
        //      sound: 'my_sound.aiff',
        );
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      8,
      'تذكير بقراءة الأذكار',
      null,
      time,
      platformChannelSpecifics,
      payload: '${time.millisecondsSinceEpoch}',
    );
  }

  Future<void> delayNotification(duration) async {
    var scheduleNotificationDateTime = DateTime.now().add(duration);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'Delayed Notifications',
      'Delayed Notifications',
      "Notifications for delayed reminder",
      //This is where you add the custom notification sound the sound file should be in the android/res/drawable
      /*sound: RawResourceAndroidNotificationSound('my_sound'),*/
      enableLights: true,
      ledColor: Colors.orange,
      ledOnMs: 1000,
      ledOffMs: 500,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
        //This is where you add the custom notification sound the sound in ios
        //      sound: 'my_sound.aiff',
        );
    var platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
      iOS: iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'تذكير بقراءة الأذكار',
      null,
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: '${scheduleNotificationDateTime.millisecondsSinceEpoch}',
    );
  }

  Future<List<int>> getPendingNotificationCount() async {
      List<PendingNotificationRequest> p =
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();
          List<int> dataListAsInt = p.map((data) => int.parse(data.payload)).toList();
      return dataListAsInt;
    
  }
  Future<List<int>> getPendingNotificationId() async {
    try {
      List<int> ids = [];
      List<PendingNotificationRequest> p =
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();
          for (var item in p)
          ids.add(item.id);
      return ids;
    } catch (e) {
      return null;
    }
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
