import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mussabihati/data/my_tassabih_model.dart';

import 'counter_my_tassabih.dart';

class CounterTassabih extends StatefulWidget {
  @override
  _CounterTassabihState createState() => _CounterTassabihState();
}

class _CounterTassabihState extends State<CounterTassabih> {
  List tassabih = [
    'سبحان الله',
    ' الحمد لله',
    'الله أكبر',
    'لا حول و لا قوة إلا بالله',
    ' أستغفر الله'
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('admin_tassabih'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (snapshot.hasData) Expanded(child: myTassabihList()),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
  }

  myTassabihList()  {
    final myTassabihBox = Hive.box('admin_tassabih');
    if(myTassabihBox.isEmpty || myTassabihBox.values == null|| myTassabihBox.length < 4){
      for(var item =0; item< tassabih.length; item++ ) {
      myTassabihBox.add(MyTassabihModel(tassabih[item], null, 0, 0));
    }}

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

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: ListTile(
                  onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          TassbihView(tassbih: tassbih, index: index, myTassabih: false)),
                  title: Row(
                    children: [
                      Text(tassbih.tassbih,
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(width: 10),
                       tassbih.requiredCount != null && tassbih.requiredCount> 0 ? Text(tassbih.count.toString()+'/'+ tassbih.requiredCount.toString(),
                          style: Theme.of(context).textTheme.bodyText1): Container(),
                    ],
                  ),

                  leading: Icon(Icons.arrow_forward_ios,
                      size: 20, color: Theme.of(context).accentColor),
                ),
              );
            },
          );
        });
  }


}
