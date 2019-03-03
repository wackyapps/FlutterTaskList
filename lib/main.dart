import 'package:flutter/material.dart';
import 'package:flutter_tasks_list/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dismissible Widget',
      theme: ThemeData(
        primaryColor: Color(0xffffc600),
      ),
      home: HomePage(),
    );
  }
}
