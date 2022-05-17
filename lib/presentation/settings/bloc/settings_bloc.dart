import 'package:bloc/bloc.dart';
import 'package:film/app/components/locals/locals.dart';
import 'package:film/app/locale_bloc/locale_bloc.dart';
import 'package:film/app/locale_bloc/locale_event.dart';
import 'package:film/presentation/settings/bloc/settings_event.dart';
import 'package:film/presentation/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String keyName = 'name';
  static const String keyIsEnLocale = 'isEnLocale';
  final LocaleBloc _localeBloc;

  SettingBloc(LocaleBloc localeBloc)
      : _localeBloc = localeBloc,
        super(const SettingState(isEnLocale: false)) {
    on<LoadNameEvent>(_onLoadName);
    on<SaveNameEvent>(_onSaveName);
    on<ClearNameEvent>(_onClearName);
    on<UpdateLocaleEvent>(_onUpdateLocale);
    on<LoadLocaleEvent>(_onLoadLocale);
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

  void _onUpdateLocale(
      UpdateLocaleEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsEnLocale, event.value);
    emit(state.copyWith(isEnLocale: event.value));
    _localeBloc.add(ChangeLocaleEvent(!event.value
        ? availableLocales[ruLocale]!
        : availableLocales[enLocale]!));
  }

  void init() {
    add(LoadLocaleEvent());
  }

  void _onLoadLocale(LoadLocaleEvent event, Emitter<SettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var isEnLocale = prefs.getBool(keyIsEnLocale) ?? false;
    emit(state.copyWith(isEnLocale: isEnLocale));
    _localeBloc.add(ChangeLocaleEvent(!isEnLocale
        ? availableLocales[ruLocale]!
        : availableLocales[enLocale]!));
  }
}
