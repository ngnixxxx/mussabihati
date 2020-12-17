import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/theme/theme_types.dart';

import 'package:mussabihati/utils/notifications_helper.dart';
import 'package:provider/provider.dart';

class RemindOption extends StatefulWidget {
  final String payload;

  const RemindOption({Key key, this.payload}) : super(key: key);
  @override
  _RemindOptionState createState() => _RemindOptionState();
}

class _RemindOptionState extends State<RemindOption> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, AppTheme appTheme, child) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
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
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                    child: ListView(
                  children: [
                    Image.asset('assets/logo.png', height: 100, width: 100),
                    Text(
                      'مسبحتي',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .apply(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Divider(
                              color: Theme.of(context).accentColor,
                              thickness: 1.5,
                              endIndent: 8,
                              indent: 0,
                            )),
                        Text('إعادة التذكر',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(color: Theme.of(context).accentColor)),
                        Flexible(
                            flex: 1,
                            child: Divider(
                              color: Theme.of(context).accentColor,
                              thickness: 1.5,
                              endIndent: 0,
                              indent: 8,
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('بعد',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Theme.of(context).accentColor),
                        textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () async {
                              await notificationPlugin
                                  .delayNotification(Duration(minutes: 5))
                                  .then((value) async {
                                Navigator.pop(context);
                                Flushbar(
                                  animationDuration:
                                      Duration(milliseconds: 800),
                                  duration: Duration(milliseconds: 2000),
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(16),
                                  icon: Icon(
                                    Icons.alarm,
                                    color:
                                        Theme.of(context).accentIconTheme.color,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryIconTheme.color,
                                  messageText: Text(
                                    'تم ضبط التذكير ل 5 دقايق',
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .color),
                                  ),
                                ).show(context);
                              }); // This literally sched;
                            },
                            color: Theme.of(context).accentColor,
                            child: Text('5 دقائق',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColor))),
                        FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () async {
                              await notificationPlugin
                                  .delayNotification(Duration(hours: 1))
                                  .then((value) async {
                                Navigator.pop(context);
                                Flushbar(
                                  animationDuration:
                                      Duration(milliseconds: 800),
                                  duration: Duration(milliseconds: 2000),
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(16),
                                  icon: Icon(
                                    Icons.alarm,
                                    color:
                                        Theme.of(context).accentIconTheme.color,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryIconTheme.color,
                                  messageText: Text(
                                    'تم ضبط التذكير لمدة 1 ساعة',
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .color),
                                  ),
                                ).show(context);
                              }); // This literally
                            },
                            color: Theme.of(context).accentColor,
                            child: Text('1 ساعة',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColor))),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text('أو',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Theme.of(context).accentColor)),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () {
                              DateTime date;
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                      confirmText: 'اختيار',
                                      cancelText: 'إلغاء')
                                  .then((value) {
                                if (value != null) {
                                  date = value;
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          cancelText: 'إلغاء',
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          false),
                                              child: child,
                                            );
                                          },
                                          confirmText: 'اختيار')
                                      .then((value) async {
                                    if (value != null) {
                                      var chosenTime = DateTime(
                                          date.year,
                                          date.month,
                                          date.day,
                                          value.hour,
                                          value.minute);
                                      await notificationPlugin
                                          .scheduleNotification(chosenTime)
                                          .then((value) {
                                        Navigator.pop(context);
                                        Flushbar(
                                          animationDuration:
                                              Duration(milliseconds: 800),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          borderRadius: 10,
                                          margin: EdgeInsets.all(16),
                                          icon: Icon(
                                            Icons.alarm,
                                            color: Theme.of(context)
                                                .accentIconTheme
                                                .color,
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .primaryIconTheme
                                              .color,
                                          messageText: Text(
                                            ' تم ضبط التذكير على: ${date.year}/${date.month}/${date.day} ${chosenTime.hour}:${chosenTime.minute}',
                                            textDirection: TextDirection.rtl,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .apply(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color),
                                          ),
                                        ).show(context);
                                      });
                                    }
                                  });
                                }
                              });
                            },
                            color: Theme.of(context).accentColor,
                            child: Text('إلى...',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColor))),
                        FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () {
                              var chosenDurationType;
                              var chosenDurationCount;
                              var chosenDelay;
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    var items = ['دقائق', 'ساعات', 'أيام'];
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialog(
                                        title: Text(
                                          'اختر مدة التأخير',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                style: Theme.of(context).textTheme.headline6,
                                                onFieldSubmitted: (value) {
                                                  setState(() {
                                                    chosenDurationCount = value;
                                                  });
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    chosenDurationCount = value;
                                                  });
                                                  print(value);
                                                },
                                                decoration: InputDecoration(
                                                    isDense: true),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Flexible(
                                              child: DropDown<String>(
                                                initialValue: items.first,
                                                items: items,
                                                customWidgets: [
                                                  for (var item in items)
                                                    Text(
                                                      item,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .apply(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor),
                                                    ),
                                                ],
                                                onChanged: (chosenTassbih) {
                                                  setState(() {
                                                    chosenDurationType =
                                                        chosenTassbih;
                                                  });
                                                  print(chosenDurationType);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () async {
                                              chosenDelay = chosenDurationType ==
                                                          'دقائق' &&
                                                      chosenDurationCount <= 60
                                                  ? Duration(
                                                      minutes: int.parse(
                                                          chosenDurationCount))
                                                  : chosenDurationType ==
                                                              'ساعات' &&
                                                          chosenDurationCount <=
                                                              24
                                                      ? Duration(
                                                          hours: int.parse(
                                                              chosenDurationCount))
                                                      : chosenDurationType ==
                                                              'أيام'
                                                          ? Duration(
                                                              days: int.parse(
                                                                  chosenDurationCount))
                                                          : Duration(
                                                              minutes: int.parse(
                                                                  chosenDurationCount));

                                              await notificationPlugin
                                                  .delayNotification(
                                                      chosenDelay)
                                                  .then(
                                                    (value) => Flushbar(
                                                      animationDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  800),
                                                      duration: Duration(
                                                          milliseconds: 2000),
                                                      borderRadius: 10,
                                                      margin:
                                                          EdgeInsets.all(16),
                                                      icon: Icon(
                                                        Icons.alarm,
                                                        color: Theme.of(context)
                                                            .accentIconTheme
                                                            .color,
                                                      ),
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryIconTheme
                                                              .color,
                                                      messageText: Text(
                                                        ' تم ضبط التذكير على:${chosenDurationType == 'دقائق' && chosenDurationCount <= 60 ? chosenDurationCount + 'دقائق' : chosenDurationType == 'ساعات' && chosenDurationCount <= 24 ? chosenDurationCount + 'ساعات' : chosenDurationType == 'أيام' ? chosenDurationCount + 'أيام' : chosenDurationCount + 'دقائق'}',
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6
                                                            .apply(
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    .color),
                                                      ),
                                                    ).show(context),
                                                  );
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              print(chosenDelay);
                                            },
                                            child: Text(
                                              'اختيار',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .apply(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: () async {
                                              chosenDelay = chosenDurationType ==
                                                          'دقائق' &&
                                                      chosenDurationCount <= 60
                                                  ? Duration(
                                                      minutes: int.parse(
                                                          chosenDurationCount))
                                                  : chosenDurationType ==
                                                              'ساعات' &&
                                                          chosenDurationCount <=
                                                              24
                                                      ? Duration(
                                                          hours: int.parse(
                                                              chosenDurationCount))
                                                      : chosenDurationType ==
                                                              'أيام'
                                                          ? Duration(
                                                              days: int.parse(
                                                                  chosenDurationCount))
                                                          : Duration(
                                                              minutes: int.parse(
                                                                  chosenDurationCount));
                                            },
                                            child: Text(
                                              'إلغاء',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .apply(
                                                      color: Theme.of(context)
                                                          .accentColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            color: Theme.of(context).accentColor,
                            child: Text('لمدة...',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .apply(
                                        color:
                                            Theme.of(context).primaryColor))),
                      ],
                    ),
                    SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          onPressed: () => Navigator.pop(context),
                          color: Theme.of(context).accentColor,
                          child: Text('إخفاء',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(
                                      color: Theme.of(context).primaryColor))),
                    ),
                  ],
                )))),
      );
    });
  }
}
