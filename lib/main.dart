import 'package:contact_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/model.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  Hive.registerAdapter(ContactAdapter());

  // open a box
  var box = await Hive.openBox('mybox');

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
