import 'package:advanced_to_do_app/db/db_healper.dart';
import 'package:advanced_to_do_app/screens/home_view.dart';
import 'package:advanced_to_do_app/services/theme_service.dart';
import 'package:advanced_to_do_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHealper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: HomeView(),
    );
  }
}
