import 'package:film/app/components/buttons/base_button/scale_button.dart';
import 'package:film/app/components/buttons/base_button/type_button.dart';
import 'package:film/app/components/buttons/base_button/widget/button_base.dart';
import 'package:film/app/components/locals/locals.dart';
import 'package:film/presentation/settings/bloc/settings_bloc.dart';
import 'package:film/presentation/settings/bloc/settings_event.dart';
import 'package:film/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text(context.locale.settings),
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
            child: Text(context.locale.getName),
            onPressed: () {
              context.read<SettingBloc>().add(LoadNameEvent());
            },
          ),
          BaseButton(
            type: ButtonType.primary,
            scale: ButtonScale.medium,
            child: Text(context.locale.saveName),
            onPressed: () {
              context
                  .read<SettingBloc>()
                  .add(const SaveNameEvent(name: 'Ирина'));
            },
          ),
          BaseButton(
            type: ButtonType.primary,
            scale: ButtonScale.medium,
            child: Text(context.locale.clearName),
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
