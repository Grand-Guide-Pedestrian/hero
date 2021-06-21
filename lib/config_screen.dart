import 'package:flutter/material.dart';
import 'package:ggp_hero/Config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final _webSocketServerURLController = TextEditingController();
  final _gameIDController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 300,
            child: Form(
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    controller: _webSocketServerURLController,
                    decoration: InputDecoration(
                      labelText: 'WebSocket Server URL',
                    ),
                    validator: _requiredFormFieldValidator,
                  ),
                  TextFormField(
                    controller: _gameIDController,
                    decoration: InputDecoration(
                      labelText: 'Game ID',
                    ),
                    validator: _requiredFormFieldValidator,
                  ),
                ],
              ),
              key: _formKey,
              onChanged: () {
                setState(() {});
              },
            ),
          ),
        ),
      ),
      floatingActionButton: _fab(),
    );
  }

  void _loadConfig() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final webSocketServerURL = sharedPreferences.getString(Config.webSocketServerURLKey);
    final gameID = sharedPreferences.getString(Config.gameIDKey);

    setState(() {
      if (webSocketServerURL != null) {
        _webSocketServerURLController.text = webSocketServerURL;
      }
      if (gameID != null) {
        _gameIDController.text = gameID;
      }
    });
  }

  Widget? _fab() {
    if ((_formKey.currentState == null) || (_formKey.currentState!.validate() != true)) {
      return null;
    } else {
      return FloatingActionButton(
        onPressed: () async {
          final sharedPreferences = await SharedPreferences.getInstance();

          sharedPreferences.setString(Config.webSocketServerURLKey, _webSocketServerURLController.text);
          sharedPreferences.setString(Config.gameIDKey, _gameIDController.text);
        },
        child: const Icon(
          Icons.arrow_right_alt,
        ),
      );
    }
  }

  String? _requiredFormFieldValidator(String? value) {
    if ((value == null) || (value.isEmpty)) {
      return 'Required';
    } else {
      return null;
    }
  }
}
