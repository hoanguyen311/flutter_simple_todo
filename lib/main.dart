import 'package:flutter/material.dart';
import './storage.dart';
import './screens/screens.dart' as screen;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: screen.Home(
        storage: TodoStorage(),
      ),
    );
  }
}
