import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ggp_hero/Config.dart';
import 'package:ggp_hero/config_screen.dart';
import 'package:ggp_hero/hero_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(GGPHeroApp());
}

class GGPHeroApp extends StatefulWidget {
  @override
  _GGPHeroAppState createState() => _GGPHeroAppState();
}

class _GGPHeroAppState extends State<GGPHeroApp> {
  Config? _config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grand Guide Pedestrian :: Hero App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Builder(
        builder: (BuildContext inner) {
          if (_config == null) {
            return ConfigScreen(_updateConfig);
          } else {
            return HeroScreen(_config!);
          }
        },
      ),
      // home: HeroScreen(),
    );
  }

  void _updateConfig(Config? config) {
    setState(() {
      this._config = config;
    });
  }
}
