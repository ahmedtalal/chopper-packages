import 'package:chopper_networking/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

main(List<String> args) {
  runApp(Chopper());
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    print('${event.level.name} ${event.message}');
  });
}

class Chopper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}