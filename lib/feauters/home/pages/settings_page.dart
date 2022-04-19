import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsArguments {
  const SettingsArguments(this.name);
  final String name;
}

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsPage({Key? key, required this.arguments}) : super(key: key);

  final SettingsArguments arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('User: ${arguments.name}'),
          ElevatedButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[Icon(Icons.exit_to_app), Text('Exit')],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[Icon(Icons.arrow_back), Text('Back')],
            ),
          )
        ]),
      ),
    );
  }
}
