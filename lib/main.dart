// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_task_management/db/dbHelper.dart';
import 'package:flutter_task_management/screen/homescreen.dart';
import 'package:flutter_task_management/screen/services/theme_services.dart';
import 'package:flutter_task_management/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,

      home: HomeScreen(),
    );
  }
}
