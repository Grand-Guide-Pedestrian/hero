import 'package:flutter/material.dart';
import 'package:ggp_hero/Config.dart';

class HeroScreen extends StatelessWidget {
  final Config _config;

  const HeroScreen(this._config, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          children: [
            Text(_config.webSocketServerURL),
            Text(_config.gameID),
          ],
        ),
      ),
    );
  }
}
