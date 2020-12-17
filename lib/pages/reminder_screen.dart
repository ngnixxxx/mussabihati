import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'dart:math';

import 'package:mussabihati/utils/notifications_helper.dart';

class ReminderView extends StatefulWidget {
  @override
  _ReminderViewState createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  int hour;
  int minute;

  DateTime dateTime;

  int second;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('ذكرني بقراءة الأذكار عند: ',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(color: Colors.white)),
          SizedBox(height: 20),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('د',
                              style: Theme.of(context).textTheme.headline4),
                          SizedBox(width: 48),
                          Text('س',
                              style: Theme.of(context).textTheme.headline4),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: TimePickerSpinner(
                              alignment: Alignment.centerLeft,
                              normalTextStyle:
                                  Theme.of(context).textTheme.headline4,
                              itemWidth: 50,
                              is24HourMode: false,
                              highlightedTextStyle: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .apply(color: Theme.of(context).accentColor),
                              onTimeChange: (time) {
                                setState(() {
                                  hour = time.hour;
                                  minute = time.minute;
                                  second = time.second;
                                  dateTime = time;
                                });
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FutureBuilder<List<int>>(
                              future:
                                  notificationPlugin.getPendingNotificationCount(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.play_circle_filled,
                                            color: (!snapshot.hasData ||
                                                    snapshot.data == null || snapshot.data.length ==0 || snapshot.data.isEmpty)
                                                ? Theme.of(context).primaryIconTheme.color
                                                : Theme.of(context)
                                                    .accentColor
                                                    ),
                                        onPressed: () async {
                                          setState(() {});
                                          await notificationPlugin
                                              .scheduleNotification(dateTime)
                                              .then((value) async {
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
                                                ' تم ضبط التذكير على:$hour:$minute',
                                                textDirection:
                                                    TextDirection.rtl,
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
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.stop,
                                            color: Theme.of(context)
                                                .primaryIconTheme
                                                .color),
                                        onPressed: () async {
                                          setState(() {});
                                          await notificationPlugin
                                              .cancelAllNotification()
                                              .then((value) async {
                                            Flushbar(
                                              animationDuration:
                                                  Duration(milliseconds: 800),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              borderRadius: 10,
                                              margin: EdgeInsets.all(16),
                                              icon: Icon(
                                                Icons.alarm_off,
                                                color: Theme.of(context)
                                                    .accentIconTheme
                                                    .color,
                                              ),
                                              backgroundColor: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color,
                                              messageText: Text(
                                                'تم إلغاء التذكير',
                                                textDirection:
                                                    TextDirection.rtl,
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
                                          });
                                        }),
                                    FutureBuilder(
                                        future: notificationPlugin
                                            .getPendingNotificationId(),
                                        builder: (context, snapshot) {
                                          List snap = snapshot.data;
                                          print(snap);
                                          if (snapshot.hasData) {
                                            return IconButton(
                                                icon: Icon(Icons.repeat,
                                                    color: snap.contains(1) ||
                                                            snap.contains(2) ||
                                                            snap.contains(3) ||
                                                            snap.contains(4) ||
                                                            snap.contains(5) ||
                                                            snap.contains(6) ||
                                                            snap.contains(7)
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Theme.of(context)
                                                            .primaryIconTheme
                                                            .color),
                                                onPressed: () async {
                                                  repeatButton();
                                                });
                                          }
                                          return IconButton(
                                              icon: Icon(Icons.repeat,
                                                  color: Theme.of(context)
                                                      .primaryIconTheme
                                                      .color
                                                      .withOpacity(0.6)),
                                              onPressed: () async {
                                                repeatButton();
                                              });
                                        }),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' الوقت المتبقي  ',
                                style: Theme.of(context).textTheme.headline6),
                            Flexible(
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: FutureBuilder<List<int>>(
                                    future: notificationPlugin
                                        .getPendingNotificationCount(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data == null ||
                                          !snapshot.hasData || snapshot.data.length ==0||
                                          snapshot.hasError) {
                                        return Container(width: 0, height: 0);}
                                      if (snapshot.hasData) {
                                        var items = snapshot.data;
                                        if (items.reduce(min) <
                                            DateTime.now()
                                                .millisecondsSinceEpoch)
                                          items.removeWhere((element) =>
                                              element == items.reduce(min));
                                        return CountdownTimer(
                                            endTime: items.reduce(min),
                                            emptyWidget:
                                                Container(width: 0, height: 0),
                                            onEnd: () {
                                              setState(() {});
                                            },
                                            widgetBuilder: (context,
                                                CurrentRemainingTime time) {
                                              if (time != null)
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    if (time.days != null)
                                                      Text('${time.days}:',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline6
                                                              .apply(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor)),
                                                    time.hours != null
                                                        ? Text(
                                                            '${time.hours}:',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor),
                                                          )
                                                        : Text('00:',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor)),
                                                    time.min != null
                                                        ? Text('${time.min}:',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor))
                                                        : Text('00:',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor)),
                                                    time.sec != null
                                                        ? Text('${time.sec}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor))
                                                        : Text('0',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6
                                                                .apply(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor)),
                                                  ],
                                                );
                                              else
                                                return Container(
                                                    height: 0, width: 0);
                                            });
                                      }
                                      return Container(width: 0, height: 0);
                                    }),
                              ),
                            ),
                          ],
                        ),
                        color: Theme.of(context)
                            .primaryIconTheme
                            .color
                            .withOpacity(0.05))
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  repeatButton() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          List<int> values = [];
          String period =
              TimeOfDay.fromDateTime(dateTime).period == DayPeriod.pm
                  ? 'م'
                  : 'ًص';

          var weekDaySelectorWidget = WeekDaySelectorWidget(values: values);

          return Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('إختيار أيام الأسبوع للتذكير',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$hour : $minute $period',
                        style: Theme.of(context).textTheme.headline5),
                    Text('  :في الوقت ',
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                SizedBox(height: 16),
                weekDaySelectorWidget,
                SizedBox(height: 16),
                FlatButton(
                    onPressed: () async {
                      Flushbar(
                        animationDuration: Duration(milliseconds: 800),
                        duration: Duration(milliseconds: 2000),
                        borderRadius: 10,
                        margin: EdgeInsets.all(16),
                        icon: Icon(
                          Icons.alarm,
                          color: Theme.of(context).accentIconTheme.color,
                        ),
                        backgroundColor:
                            Theme.of(context).primaryIconTheme.color,
                        messageText: Text(
                          ' تم ضبط التذكير على:$hour:$minute',
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context).textTheme.headline6.apply(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color),
                        ),
                      ).show(context);
                      for (var day in weekDaySelectorWidget.values) {
                        await notificationPlugin.showWeeklyAtDayTime(
                            day, hour, minute, second);
                      }
                      setState(() {});
                    },
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Text('تأكيد',
                        style: Theme.of(context).textTheme.headline5.apply(
                            color:
                                Theme.of(context).textTheme.bodyText2.color)))
              ],
            ),
          );
        });
  }
}

class WeekDaySelectorWidget extends StatefulWidget {
  const WeekDaySelectorWidget({
    Key key,
    @required this.values,
  }) : super(key: key);

  final List<int> values;

  @override
  _WeekDaySelectorWidgetState createState() => _WeekDaySelectorWidgetState();
}

class _WeekDaySelectorWidgetState extends State<WeekDaySelectorWidget> {
  final weekdayValues = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder<List<int>>(
          future: notificationPlugin.getPendingNotificationId(),
          builder: (context, snapshot) {
            print('DATA' + snapshot.data.toString());
            if (snapshot.hasData) {
              if (snapshot.data.contains(1)) {
                if (!widget.values.contains(1)) widget.values.add(1);
                weekdayValues[1] = true;
              }
              if (snapshot.data.contains(2)) {
                if (!widget.values.contains(2)) widget.values.add(2);
                weekdayValues[2] = true;
              }
              if (snapshot.data.contains(3)) {
                if (!widget.values.contains(3)) widget.values.add(3);
                weekdayValues[3] = true;
              }
              if (snapshot.data.contains(4)) {
                if (!widget.values.contains(4)) widget.values.add(4);
                weekdayValues[4] = true;
              }
              if (snapshot.data.contains(5)) {
                if (!widget.values.contains(5)) widget.values.add(5);
                weekdayValues[5] = true;
              }
              if (snapshot.data.contains(6)) {
                if (!widget.values.contains(6)) widget.values.add(6);
                weekdayValues[6] = true;
              }
              if (snapshot.data.contains(7)) {
                if (!widget.values.contains(7)) widget.values.add(7);
                weekdayValues[0] = true;
              }
              widget.values.sort();
            }

            return WeekdaySelector(
              values: weekdayValues,
              onChanged: (day) {
                setState(() {
                  final index = day % 7;

                  weekdayValues[index] = !weekdayValues[index];
                  widget.values.contains(day)
                      ? widget.values.remove(day)
                      : widget.values.add(day);
                  widget.values.sort();
                  print(widget.values);
                });
              },
              shortWeekdays: ['أ', 'إ', 'ث', 'أ', 'خ', 'ج', 'س'],
              enableFeedback: true,
              textDirection: TextDirection.rtl,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .apply(fontSizeFactor: 1.4),
              selectedTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .apply(fontSizeFactor: 1.4),
              selectedColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryIconTheme.color,
              selectedFillColor: Theme.of(context).accentColor,
              fillColor:
                  Theme.of(context).primaryIconTheme.color.withOpacity(0.08),
              elevation: 0,
              selectedElevation: 0,
            );
          }),
    );
  }
}
