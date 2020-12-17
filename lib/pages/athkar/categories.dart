import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mussabihati/data/my_athkar_model.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map categories = {
    'أذكار الصباح': [
      'سبحان الله و بحمده سبحان الله العظيم',
      'سبحان الله و بحمده عدد خلقه و رضا نفسه و مداد كلماته',
      'رضيت بالله رباً و بالإسلام ديناً و بمحمد صلى الله عليه و سلم نبياً و رسولاً'
    ],
    'أذكار المساء': [
      ' أمسينا و أمسى الملك لله',
      'أمسينا على فطرة الإسلام و على كلمة الإخلاص و على دين نبينا محمد صلى الله عليه و سلم',
      'اللهم ما أمسى بي من نعمة أو بأحد من خلقك فمنك وحدك لا شريك لك',
    ]
  };

  @override
  Widget build(BuildContext context) {
    //Every thekr admin adds in the data json file must have three fields: thekr, notes, category exact name
    return FutureBuilder(
        future: Hive.openBox('categories_box'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: GroupListView(
                padding: EdgeInsets.only(top: 16),
                  sectionsCount: categories.keys.toList().length,
                  countOfItemInSection: (int section) {
                    return categories.values.toList()[section].length;
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(

                          color: Theme.of(context).primaryColor),
                      child: ListTile(
                        title: Text(
                          categories.keys.toList()[section],
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  },
//                  sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),

                  itemBuilder: (context, index) {
                    return WatchBoxBuilder(
                        box: snapshot.data,
                        builder: (context, snapshot) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(

                                color: Theme.of(context).primaryColor),
                            child: ListTile(
                              title: Text(
                                  categories.values.toList()[index.section]
                                      [index.index],
                                  style: Theme.of(context).textTheme.bodyText1),



                              leading: Icon(Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Theme.of(context).accentColor),
                            ),
                          );
                        });
                  }),
            );
          }
          return Center(child: CircularProgressIndicator(strokeWidth: 2));
        });
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
                    Colors.blueGrey[900],
                    Colors.blue[900],
                    Colors.blueGrey[900],
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
