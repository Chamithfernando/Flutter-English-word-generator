import 'package:flutter/material.dart';
import 'RandomWords.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: RandomWords(),
    );
  }
}

