import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ggp_hero/Config.dart';
import 'package:ggp_hero/keyboard_button.dart';

class HeroScreen extends StatefulWidget {
  final Config _config;

  const HeroScreen(this._config, {Key? key}) : super(key: key);

  @override
  _HeroScreenState createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  WebSocket? _webSocket;
  Map<String, bool> _keys = new Map();

  @override
  void initState() {
    super.initState();
    _connect();
  }

  @override
  Widget build(BuildContext context) {
    print(_keys);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: _connectionStatusColor(),
          child: Stack(
            children: [
              KeyboardButton(
                'A',
                bottom: 30,
                left: 30,
                pressed: _keys['A'] == true,
              ),
              KeyboardButton(
                'S',
                bottom: 30,
                left: 160,
                pressed: _keys['S'] == true,
              ),
              KeyboardButton(
                'D',
                bottom: 30,
                left: 290,
                pressed: _keys['D'] == true,
              ),
              KeyboardButton(
                'Q',
                bottom: 160,
                left: 30,
                pressed: _keys['Q'] == true,
              ),
              KeyboardButton(
                'W',
                bottom: 160,
                left: 160,
                pressed: _keys['W'] == true,
              ),
              KeyboardButton(
                'E',
                bottom: 160,
                left: 290,
                pressed: _keys['E'] == true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _webSocket?.close();
    super.dispose();
  }

  void _connect() async {
    var url = '${widget._config.webSocketServerURL}/game/${widget._config.gameID}/hero';

    print('Connecting to $url');

    try {
      _keys.clear();
      _webSocket?.close();
      _webSocket = await WebSocket.connect(url);
      _webSocket!.listen(
        (event) {
          switch (event.toString().trim()) {
            case 'A_DOWN':
              {
                _keys['A'] = true;
              }
              break;
            case 'S_DOWN':
              {
                _keys['S'] = true;
              }
              break;
            case 'D_DOWN':
              {
                _keys['D'] = true;
              }
              break;
            case 'Q_DOWN':
              {
                _keys['Q'] = true;
              }
              break;
            case 'W_DOWN':
              {
                _keys['W'] = true;
              }
              break;
            case 'E_DOWN':
              {
                _keys['E'] = true;
              }
              break;
            case 'A_UP':
              {
                _keys.remove('A');
              }
              break;
            case 'S_UP':
              {
                _keys.remove('S');
              }
              break;
            case 'D_UP':
              {
                _keys.remove('D');
              }
              break;
            case 'Q_UP':
              {
                _keys.remove('Q');
              }
              break;
            case 'W_UP':
              {
                _keys.remove('W');
              }
              break;
            case 'E_UP':
              {
                _keys.remove('E');
              }
              break;
            default:
          }
          setState(() {});
        },
        onDone: () {
          setState(() {});
          print('Done');
          Timer(Duration(milliseconds: 100), _connect);
        },
        onError: (error) {
          setState(() {});
          print('Error');
          Timer(Duration(milliseconds: 100), _connect);
        },
      );
      setState(() {});
    } catch (e) {
      print('Failed to connect!');
      print(e);
      Timer(Duration(milliseconds: 100), _connect);
    }
  }

  Color _connectionStatusColor() {
    if (_webSocket == null) {
      return Colors.red;
    } else if (_webSocket?.readyState == WebSocket.closed) {
      return Colors.orange;
    } else if (_webSocket?.readyState == WebSocket.closing) {
      return Colors.orange.withOpacity(.5);
    } else if (_webSocket?.readyState == WebSocket.connecting) {
      return Colors.green.withOpacity(.5);
    } else if (_webSocket?.readyState == WebSocket.open) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }
}
