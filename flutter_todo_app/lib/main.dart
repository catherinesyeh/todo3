import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        // blend system status bar with top bar of app (i.e., make same color)
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      // hide debug banner
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: Home(), // show homepage on load
    );
  }
}
