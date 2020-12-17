import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mussabihati/pages/remind_option.dart';
import 'package:mussabihati/pages/reminder_screen.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/theme/theme_types.dart';
import 'package:mussabihati/utils/notifications_helper.dart';
import 'package:provider/provider.dart';

import 'athkar/athkar_screen.dart';
import 'counter/counter_screen.dart';

class HomeScreen extends StatefulWidget {

  final int pageNum;

  const HomeScreen({Key key, this.pageNum}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentIndex;
  PageController controller;
  @override

  @override
  void initState() {
    super.initState();
    currentIndex = widget.pageNum != null ? widget.pageNum : 0;
    controller = PageController(initialPage: widget.pageNum != null ? widget.pageNum : 0);

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
        notificationPlugin.setOnNotificationClick(onNotificationClick);
        break;
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:appTheme.themeType == ThemeType.CAFFEINE ?  [
                  Color.fromARGB(255, 19, 98,155),
                  Color.fromARGB(255, 0, 52,89),
                  Color.fromARGB(255, 19, 98,155)
                ]:[
                  Color.fromARGB(255, 2, 30,50),
                  Color.fromARGB(255, 10, 63,100),
                  Color.fromARGB(255, 2, 30,50),

                ],
                transform: GradientRotation(4),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              body: SafeArea(
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text('مسبحتي',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .apply(color: Colors.white, fontWeightDelta: 2)),
                      actions: [
                        InkWell(
                          onTap: () => appTheme.themeType == ThemeType.MELATONIN
                              ? appTheme.setThemeType(ThemeType.CAFFEINE)
                              : appTheme.setThemeType(ThemeType.MELATONIN),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              appTheme.themeType == ThemeType.CAFFEINE &&
                                      appTheme.useSystem == false
                                  ? Icons.brightness_6
                                  : Icons.brightness_3_rounded,
                              color: appTheme.themeType == ThemeType.CAFFEINE
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          AthkarView(),
                          CounterView(),
                          ReminderView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.ltr,
                child: BottomNavigationBar(
                    elevation: 0,
                    selectedItemColor: Theme.of(context).accentColor,
                    unselectedItemColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    currentIndex: currentIndex,
                    onTap: (page) => changePage(page),
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/athkar.png',
                              width: 24, height: 24),
                          label: 'الأذكار'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/3addad.png',
                              width: 24, height: 24),
                          label: 'العداد'),
                      BottomNavigationBarItem(
                          icon: Image.asset('assets/tathkeer.png',
                              width: 24, height: 24),
                          label: 'التذكير'),
                    ]),
              ),
            ),
          ));
    });
  }

  changePage(int page) {
    setState(() {
      currentIndex = page;
      controller.jumpToPage(page);
    });
  }
}
