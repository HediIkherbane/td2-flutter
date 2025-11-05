import 'package:flutter/material.dart';
import 'UI/mytheme.dart';
import 'ViewModel/home.dart';

void main() {
  runApp(MyTD2App());
}

class MyTD2App extends StatelessWidget {
  const MyTD2App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.dark();
    return MaterialApp(theme: theme, title: 'TD2', home: Home());
  }
}
