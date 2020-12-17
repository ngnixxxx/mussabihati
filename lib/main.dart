import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mussabihati/pages/splash.dart';
import 'package:mussabihati/theme/app_theme.dart';
import 'package:mussabihati/theme/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'data/my_athkar_model.dart';
import 'data/my_tassabih_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  final appDocumetnDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumetnDirectory.path);
  Hive.registerAdapter(MyAthkarModelAdapter());
  Hive.registerAdapter(MyTassabihModelAdapter());

  AppTheme appTheme = ThemeService();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => appTheme),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();


}


class _MyAppState extends State<MyApp> {



//  Future onSelectNotification(String payload) async {
//    //convert payload json to notification model object
//    try{
//
//      await Navigator.push(
//          context,// it`s null!
//          MaterialPageRoute(
//              builder: (context) => RemindOption()));}
//    catch(e){print(e.toString());}
//  }





  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, AppTheme appTheme, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme.getLightTheme(),
        darkTheme: appTheme.getDarkTheme(),
        home: Directionality(
            textDirection: TextDirection.rtl, child: SplashScreen()),
      );
    });
  }
}
