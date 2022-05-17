import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final String? name;
  final bool isEnLocale;

  const SettingState({this.name, required this.isEnLocale});

  SettingState copyWith({String? name, bool? isEnLocale}) => SettingState(
        name: name ?? this.name,
        isEnLocale: isEnLocale ?? this.isEnLocale,
      );

  @override
  List<Object?> get props => [name ?? '', isEnLocale];
}
