import 'package:flutter/material.dart';
import 'package:mussabihati/pages/counter/counter_my_tassabih.dart';
import 'package:mussabihati/pages/counter/counter_tassabih.dart';

class CounterView extends StatefulWidget {
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TabBar(
            unselectedLabelStyle: Theme.of(context).textTheme.headline6,
            labelStyle: Theme.of(context).textTheme.headline6,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Text('التسابيح'),
              Text('تسابيحي'),
            ],
          ),
          body: SizedBox(
            child: TabBarView(children: [
              CounterTassabih(),
              CounterMyTassabih(),
            ]),
          ),
        ),
      ),
    );
  }
}
