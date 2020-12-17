import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mussabihati/data/my_tassabih_model.dart';
import 'package:vibration/vibration.dart';

class CounterMyTassabih extends StatefulWidget {
  @override
  _CounterMyTassabihState createState() => _CounterMyTassabihState();
}

class _CounterMyTassabihState extends State<CounterMyTassabih> {
  @override
  void dispose() {
    Hive.box('my_tassabih').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('my_tassabih'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (snapshot.hasData) Expanded(child: myTassabihList()),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Theme.of(context).accentColor,
                        onPressed: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return AddDialog();
                            }),
                        child: Text('إضافة تسابيح',
                            style: Theme.of(context).textTheme.bodyText2)),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
  }

  myTassabihList() {
    final myTassabihBox = Hive.box('my_tassabih');
    return WatchBoxBuilder(
        box: myTassabihBox,
        builder: (context, snapshot) {
          if (snapshot.isEmpty)
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text('لم تتم إضافة أي تسابيح',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .apply(color: Theme.of(context).accentColor)),
            ));
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: myTassabihBox.length,
            itemBuilder: (context, index) {
              final tassbih = myTassabihBox.getAt(index) as MyTassabihModel;
              return WatchBoxBuilder(
                box: myTassabihBox,
                builder: (context, snapshot) {
                  return Dismissible(
                    key: Key(index.toString()),
                    onDismissed: (DismissDirection direction)  async {
                      assert(direction != null);
                         setState(() {
                         });

                    },
                    confirmDismiss: (direction) async {
                         await snapshot.deleteAt(index);
                         return true;

                    },

                    background: Container(
                        decoration:
                            BoxDecoration(color: Theme.of(context).accentColor),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete_forever,
                            color: Theme.of(context).primaryColor)),

                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      child: ListTile(
                        onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => TassbihView(
                                tassbih: tassbih, index: index, myTassabih: true)),
                        title: Text(tassbih!= null ? tassbih?.tassbih ?? snapshot.length.toString() : 'There was an error delete the tassbih',
                            style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.fade,),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ملاحظاتي',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: Theme.of(context).accentColor)),
                            InkWell(
                              child: Image.asset('assets/notes.png',
                                  width: 24, height: 24),
                              onTap: () => showDialog(
                                  context: context, builder:(context) {return noteDialog(tassbih);}),
                            ),
                          ],
                        ),
                        leading: Icon(Icons.arrow_forward_ios,
                            size: 20, color: Theme.of(context).accentColor),
                      ),
                    ),
                  );
                }
              );
            },
          );
        });
  }

  noteDialog(MyTassabihModel tassbih) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('ملاحظاتي',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .apply(color: Theme.of(context).accentColor)),
          Image.asset('assets/notes.png', width: 24, height: 24)
        ]),
        content: Text(
            tassbih == null && tassbih.note == null || tassbih.note == ''
                ? 'لا يوجد أي ملاحظة'
                : tassbih.note ?? 'لا يوجد أي ملاحظة',
            style: Theme.of(context).textTheme.bodyText1.apply(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.5))),
        actions: [
          Container(
            height: 36,
            width: 72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 19, 98,155),
                  Color.fromARGB(255, 0, 52,89),
                  Color.fromARGB(255, 19, 98,155)
                  ],
                  transform: GradientRotation(0.6),
                )),
            child: FlatButton(
              onPressed: () => Navigator.pop(context),
              
              child: Text('تم',
                            style: Theme.of(context).textTheme.headline6.apply(color:Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

class TassbihView extends StatefulWidget {
  final MyTassabihModel tassbih;
  final int index;
  final bool myTassabih;

  const TassbihView({Key key, this.tassbih, this.index, this.myTassabih})
      : super(key: key);
  @override
  _TassbihViewState createState() => _TassbihViewState();
}

class _TassbihViewState extends State<TassbihView> {

  bool shakeActive = true;
  int index;
  TextEditingController textEditingController;


  void resetCount(snapshot) {
    final tassbih = snapshot.getAt(index) as MyTassabihModel;
    textEditingController.clear();
    snapshot.putAt(
        index, MyTassabihModel(tassbih.tassbih, tassbih.note, 0, 0));
    Flushbar(
      animationDuration: Duration(milliseconds: 800),
      duration: Duration(milliseconds: 2000),
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      backgroundColor: Theme.of(context).primaryIconTheme.color,
      messageText: Text(
        'تم تصفير العد',
        textDirection: TextDirection.rtl,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ).show(context);
  }

  void resetFinishCount(snapshot) {
    final tassbih = snapshot.getAt(index) as MyTassabihModel;
    snapshot.putAt(
        index, MyTassabihModel(tassbih.tassbih, tassbih.note, 0, tassbih.requiredCount));
    Flushbar(
      animationDuration: Duration(milliseconds: 800),
      duration: Duration(milliseconds: 2000),
      borderRadius: 10,
      margin: EdgeInsets.all(16),
      backgroundColor: Theme.of(context).primaryIconTheme.color,
      messageText: Text(
        'تم تصفير العد',
        textDirection: TextDirection.rtl,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ).show(context);
  }



  void addCount(snapshot) {
    final tassbih = snapshot.getAt(index) as MyTassabihModel;

    if (tassbih.count >= tassbih.requiredCount &&
        tassbih.count > 0 &&
        tassbih.requiredCount > 0) {
      if(shakeActive) Vibration.vibrate();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('لقد وصلت إلى العدد المطلوب',
                  style: Theme.of(context).textTheme.headline6),
              actions: [
                Container(
            height: 36,
            width: 72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 19, 98,155),
                  Color.fromARGB(255, 0, 52,89),
                  Color.fromARGB(255, 19, 98,155)
                  ],
                  transform: GradientRotation(0.6),
                )),
                  child: FlatButton(
                      
                      onPressed: () {
                        resetFinishCount(snapshot);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      
                      child: Text('تم',
                          style: Theme.of(context).textTheme.headline6.apply(color:Colors.white))),
                ),
              ],
            );
          });
    } else {
      snapshot.putAt(
          index,
          MyTassabihModel(tassbih.tassbih, tassbih.note, tassbih.count + 1,
              tassbih.requiredCount));
      if(shakeActive) Vibration.vibrate(duration: 80,amplitude: 30);
      print('THIS IS THE COUNT ${widget.tassbih.count}');
    }
  }

  void setRequiredCount(snapshot, int count) {
    final tassbih = snapshot.getAt(index) as MyTassabihModel;

    snapshot.putAt(index,
        MyTassabihModel(tassbih.tassbih, tassbih.note, tassbih.count, count));
    print('THIS IS THE COUNT ${widget.tassbih.requiredCount}');
  }
  @override
  void initState() {
    index = widget.index;
    textEditingController = TextEditingController();
    widget.tassbih.requiredCount != null ? textEditingController.text = widget.tassbih.requiredCount.toString() : '0';
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<Box>(
          future: widget.myTassabih
              ? Hive.openBox('my_tassabih')
              : Hive.openBox('admin_tassabih'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<MyTassabihModel> tassabihList = snapshot.data.values.toList().cast<MyTassabihModel>();

              return Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                    DropDown<int>(
                      initialValue: index,
                      items: [ for(var item=0; item< tassabihList.length; item++) item],
                      customWidgets: [
                        for(var item in tassabihList)
                        Text(item.tassbih.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(color: Theme.of(context).accentColor)),
                      ],
                      onChanged: (chosenTassbih) {
                        setState(() {
                          index = chosenTassbih;
                        });
                      },
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('أدخل العدد المطلوب',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(color: Theme.of(context).accentColor)),
                          SizedBox(width: 16),
                          Flexible(
                              child: SizedBox(
                                  height: 40,
                                  width: 90,
                                  child: WatchBoxBuilder(
                                    box: snapshot.data,
                                    builder: (context, snapshot) {
                                      var tassbihRequiredCount = snapshot
                                          .getAt(index) as MyTassabihModel;
                                      return TextFormField(
                                        controller: textEditingController,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .apply(fontSizeFactor: 1.1),

                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        validator: (input) => input.isEmpty
                                            ? 'أدخل رقما'
                                            : RegExp(r'^[0-9]').hasMatch(input)
                                                ? null
                                                : 'أدخل رقما مناسبا',
                                        onFieldSubmitted: (value) => setRequiredCount(
                                            snapshot, int.parse(value)),
                                        onChanged: (value) => setRequiredCount(
                                            snapshot, int.parse(value)),
                                      );
                                    }
                                  )))
                        ],
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      resetCount(snapshot.data);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .primaryIconTheme
                                                .color
                                                .withOpacity(0.2),
                                            shape: BoxShape.circle),
                                        width: 32,
                                        height: 32,
                                        child: Icon(
                                          Icons.repeat,
                                          color: Theme.of(context)
                                              .primaryIconTheme
                                              .color,
                                          size: 22,
                                        ))),
                                SizedBox(width: 10),

                              ],
                            ),
                            Row(
                              children: [
                                Text('هزاز',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .apply(
                                            color:
                                                Theme.of(context).accentColor)),
                                Checkbox(value: shakeActive, onChanged: (changed) {

                                  setState(() {
                                    shakeActive = changed;
                                  });
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context)
                                    .primaryIconTheme
                                    .color
                                    .withOpacity(0.1))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                addCount(snapshot.data);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                        
                                                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryIconTheme
                                        .color
                                        .withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(32),
                                  margin: EdgeInsets.all(12),
                                  child: Icon(Icons.touch_app,
                                      size: 180,
                                      color:
                                          Theme.of(context).primaryIconTheme.color),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryIconTheme
                                    .color
                                    .withOpacity(0.1),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('مجموع التسبيحات :',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .apply(fontSizeFactor: 1.1)),
                                  WatchBoxBuilder(
                                      box: snapshot.data,
                                      builder: (context, snapshot) {
                                        var tassbihCount = snapshot
                                            .getAt(index) as MyTassabihModel;
                                        return Text(
                                            tassbihCount.count != null
                                                ? '${tassbihCount.count}'
                                                : '${0}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .apply(
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeightDelta: 2));
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
    );
  }
}

class AddDialog extends StatefulWidget {
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _formKey = GlobalKey<FormState>();
  String _tassbih;
  String _note;

  void addTassbih(MyTassabihModel myTassbih) {
    Hive.box('my_tassabih').add(myTassbih);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(16),
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'إضافة تسابيح',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .apply(fontWeightDelta: 2),
              ),
              SizedBox(height: 16),
              SizedBox(
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  onSaved: (value) {
                    setState(() {
                      _tassbih = value;
                    });
                  },
                  onChanged: (value) {
                  setState(() {
                    _tassbih = value;
                  });
                },
                  decoration: InputDecoration(
                      hintText: 'التسبيح',
                      isDense: true,
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                onSaved: (value) {
                  setState(() {
                    _note = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _note = value;
                  });
                },
                decoration: InputDecoration(
                    isDense: true,
                    hintText: 'ملاحظاتي',
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never),
              ),
              SizedBox(height: 16),
              FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    _formKey.currentState.save();
                    final newThekr = MyTassabihModel(_tassbih, _note?? null, 0, 0);
                    addTassbih(newThekr);
                  },
                  child: Text('إضافة',
                      style: Theme.of(context).textTheme.bodyText2))
            ],
          ),
        ),
      ),
    );
  }
}
