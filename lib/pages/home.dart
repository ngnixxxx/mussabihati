
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mussabihati/pages/remind_option.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/utils/notifications_helper.dart';
import 'package:provider/provider.dart';
import 'package:mussabihati/theme/theme_types.dart';
import 'package:share/share.dart';

import 'home_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();

    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);

    notificationPlugin.setOnNotificationClick(onNotificationClick);
    WidgetsBinding.instance.addObserver(this);

  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {

  }
  onNotificationClick(String payload) async {
    if(payload != null) {
      print('PAAAAAYYYKOIIAADDDD: $payload');

    }
    else {
      print('PAAAAAYYY: $payload');

    }
    await Navigator.push(context, MaterialPageRoute(builder: (coontext) {
      return RemindOption(payload: payload);
    }));

    print('payload : $payload');
  }

  didAppLifeCycleChange(AppLifecycleState appLifecycleState){
    switch (appLifecycleState) {
      case AppLifecycleState.resumed:
        print('resumed');
        notificationPlugin.setOnNotificationClick(onNotificationClick);        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('paused');
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;

    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, AppTheme appTheme, child) {
      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appTheme.themeType == ThemeType.CAFFEINE
                      ? [
                          Color.fromARGB(255, 19, 98, 155),
                          Color.fromARGB(255, 0, 52, 89),
                          Color.fromARGB(255, 19, 98, 155)
                        ]
                      : [
                          Color.fromARGB(255, 2, 30, 50),
                          Color.fromARGB(255, 10, 63, 100),
                          Color.fromARGB(255, 2, 30, 50),
                        ],
                  transform: GradientRotation(4),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Text(
                        'مسبحتي',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: Text(
                            'مشاركة التطبيق',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(color: Colors.orange),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.orange,
                            ),
                            onPressed: () async {
                              //Here goes both ou play and app store urls
                              String androidUrl = '';
                              String iosUrl = '';
                              if(Platform.isAndroid || androidUrl != null || androidUrl != '')await Share.share(androidUrl,subject: 'Mussabihati Download Url');
                              else if(Platform.isIOS || iosUrl != null || iosUrl != '') await Share.share(iosUrl,subject: 'Mussabihati Download Url');
                              else await Share.share('Error Sharing Url', subject:'Mussabihati Download Url');
                            })
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Text(
                        'شارك بالأجر بالمساهمة في نشر التطبيق لأصدقائك و من تتوسم فيه الخير',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          homeOption(
                              'الأذكار',
                              'إدارة الأذكار الخاصة بك',
                              Image.asset('assets/athkar.png',
                                  width: 24, height: 24),
                              0),
                          homeOption(
                              'العداد',
                              'المسبحة و فيها الأذكار',
                              Image.asset('assets/3addad.png',
                                  width: 24, height: 24),
                              1),
                          homeOption(
                              'التذكير',
                              'تشغيل/إيقاف التذكير',
                              Image.asset('assets/tathkeer.png',
                                  width: 24, height: 24),
                              2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  homeOption(String title, String desc, Image icon, int pageNum) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => HomeScreen(pageNum: pageNum))),
      child: Container(
        width: MediaQuery.of(context).size.width /1.5,
        height: MediaQuery.of(context).size.width /3,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headline5),
                Text(desc,
                    style: Theme.of(context).textTheme.bodyText1.apply(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.6))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
