import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:note_keeper_app/models_providers/theme_provider.dart';
import 'package:note_keeper_app/views/NoteList.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

import './utils/db_helper.dart' as DB;
//import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.DBHelper().database();

  final appDocDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocDirectory.path);

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  print(isLightTheme);

  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProvider(isLightTheme: isLightTheme),
      child: AppStart()));
}

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;

  const MyApp({Key key, @required this.themeProvider}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NoteKeeper App",
      debugShowCheckedModeBanner: false,
      theme: widget.themeProvider.themeData(),
      home: NoteList(),
    );
  }
}
