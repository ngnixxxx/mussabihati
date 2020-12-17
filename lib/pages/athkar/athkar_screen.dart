import 'package:flutter/material.dart';

import 'categories.dart';
import 'my_athkar.dart';

class AthkarView extends StatefulWidget {
  @override
  _AthkarViewState createState() => _AthkarViewState();
}

class _AthkarViewState extends State<AthkarView> {
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
            tabs: [Text('مجموعات'), Text('أذكاري')],
          ),
          body: SizedBox(
            child: TabBarView(children: [
              Categories(),
              MyAthkar(),
            ]),
          ),
        ),
      ),
    );
  }
}
