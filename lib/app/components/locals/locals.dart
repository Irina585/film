import 'dart:async' show Future;

import 'package:film/app/components/locals/ru.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart'
    show BuildContext, Locale, Localizations, LocalizationsDelegate;

import 'en.dart';
import 'locale_base.dart';

const String ruLocale = 'ru_RU';
const String enLocale = 'en_US';

/// Мапа объектов со строками к их сокращенному именованию
Map<String, LocaleBase> get initialLocals => <String, LocaleBase>{
      ruLocale: LocaleRu(),
      enLocale: LocaleEn(),
    };

/// Доступные локали
Map<String, Locale> get availableLocales => <String, Locale>{
      ruLocale: const Locale('ru', 'RU'),
      enLocale: const Locale('en', 'US'),
    };

/// Расширения на контекст для доступа к локализации
extension LocalContextExtension on BuildContext {
  /// Получить объект со строками из текущей локализации
  LocaleBase get locale => Localizations.of<Locals>(this, Locals)!.current;
}

/// Класс состояния текущей локализации
class Locals {
  Locals(this.locale, this.localizedValues) {
    /// При инициализации мы на основе сокращенного именования
    /// подставляем наш объект со строками
    current = localizedValues[locale.toString()] ?? initialLocals[ruLocale]!;
  }

  /// Текущая локализация
  final Locale locale;

  /// Мапа объектов со строками к их сокращенному именованию
  final Map<String, LocaleBase> localizedValues;

  /// Текущий объект со строками
  late LocaleBase current;
}

/// Делегат-обработчик для локализации
class MyLocalizationsDelegate extends LocalizationsDelegate<Locals> {
  /// Мапа объектов со строками к их сокращенному именованию
  Map<String, LocaleBase> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  /// Метод проверки поддерживаемости локализации
  @override
  bool isSupported(Locale locale) =>
      localizedValues.keys.toList().contains(locale.toString());

  /// Метод загрузки локализации
  @override
  Future<Locals> load(Locale locale) => SynchronousFuture<Locals>(
        Locals(
          isSupported(locale) ? locale : availableLocales[ruLocale]!,
          localizedValues,
        ),
      );

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
