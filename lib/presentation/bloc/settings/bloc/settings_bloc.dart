import 'package:bloc/bloc.dart';
import 'package:film/presentation/bloc/settings/bloc/settings_event.dart';
import 'package:film/presentation/bloc/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String keyName = 'name';

  SettingBloc() : super(const SettingState()) {
    on<LoadNameEvent>(_onLoadName);
    on<SaveNameEvent>(_onSaveName);
    on<ClearNameEvent>(_onClearName);
  }

  void _onLoadName(LoadNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString(keyName);
    emit(state.copyWith(name: name));
  }

  void _onSaveName(SaveNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onClearName(ClearNameEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyName);
    emit(state.copyWith(name: ''));
  }
}
