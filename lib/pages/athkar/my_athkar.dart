import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mussabihati/data/my_athkar_model.dart';

class MyAthkar extends StatefulWidget {
  @override
  _MyAthkarState createState() => _MyAthkarState();
}

class _MyAthkarState extends State<MyAthkar> {
  @override
  void dispose() {
    Hive.box('my_athkar').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('my_athkar'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (snapshot.hasData) Expanded(child: myAthkarList()),
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
                        child: Text('إضافة أذكار',
                            style: Theme.of(context).textTheme.bodyText2)),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
  }

  myAthkarList() {
    return WatchBoxBuilder(
      box: Hive.box('my_athkar'),
      builder: (context, snapshot) {

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16),
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            if (snapshot != null || snapshot.length == 0)
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('لم تتم إضافة أي أذكار',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(color: Theme.of(context).accentColor)),
                  ));
            final thekr = snapshot.getAt(index) as MyAthkarModel;
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
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete_forever,
                      color: Theme.of(context).primaryColor)),
              secondaryBackground: Container(
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.delete_forever,
                      color: Theme.of(context).primaryColor)),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: ListTile(
                  title: Text(thekr?.thekr ?? '//',
                      style: Theme.of(context).textTheme.bodyText1),
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
                              context: context, child: noteDialog(thekr))),
                    ],
                  ),
                  leading: Icon(Icons.arrow_forward_ios,
                      size: 20, color: Theme.of(context).accentColor),
                ),
              ),
            );
          },
        );
      }
    );
  }

  noteDialog(MyAthkarModel thekr) {
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
            thekr.note == null || thekr.note == ''
                ? 'لا يوجد أي ملاحظة'
                : thekr.note,
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .apply(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}

class AddDialog extends StatefulWidget {
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final _formKey = GlobalKey<FormState>();
  String _thekr;
  String _note;

  void addThekr(MyAthkarModel myAthkar) async {
    await Hive.openBox('my_athkar').then((value) => value.add(myAthkar));
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
                'إضافة أذكار',
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
                  onSaved: (value) => _thekr = value,
                  decoration: InputDecoration(
                      hintText: 'الذكر',
                      isDense: true,
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                onSaved: (value) => _note = value,
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
                    final newThekr = MyAthkarModel(_thekr, _note);
                    addThekr(newThekr);
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
