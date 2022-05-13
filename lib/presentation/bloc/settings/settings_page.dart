import 'package:film/components/buttons/scale_button.dart';
import 'package:film/components/buttons/type_button.dart';
import 'package:film/components/buttons/widget/button_base.dart';
import 'package:film/presentation/bloc/settings/bloc/settings_bloc.dart';
import 'package:film/presentation/bloc/settings/bloc/settings_event.dart';
import 'package:film/presentation/bloc/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
class SettingsArguments {
  const SettingsArguments(this.name);
  final String name;
}

 */

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingBloc>(
        lazy: false,
        create: (_) => SettingBloc()..add(LoadNameEvent()),
        child: const SettingsPageContent());
  }
}

class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlocBuilder<SettingBloc, SettingState>(
              buildWhen: (oldState, newState) => oldState.name != newState.name,
              builder: (context, state) {
                return Text(state.name ?? '');
              }),
          BaseButton(
            type: ButtonType.primary,
            scale: ButtonScale.medium,
            child: const Text('Получить имя'),
            onPressed: () {
              context.read<SettingBloc>().add(LoadNameEvent());
            },
          ),
          BaseButton(
            type: ButtonType.primary,
            scale: ButtonScale.medium,
            child: const Text('Сохранить имя'),
            onPressed: () {
              context
                  .read<SettingBloc>()
                  .add(const SaveNameEvent(name: 'Ирина'));
            },
          ),
          BaseButton(
            type: ButtonType.primary,
            scale: ButtonScale.medium,
            child: const Text('Очистить имя'),
            onPressed: () {
              context.read<SettingBloc>().add(ClearNameEvent());
            },
          ),
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
