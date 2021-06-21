import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggp_hero/config_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(GGPHeroApp());
}

class GGPHeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grand Guide Pedestrian :: Hero App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ConfigScreen(),
    );
  }
}
