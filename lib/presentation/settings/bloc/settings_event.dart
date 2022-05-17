import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
  @override
  List<Object?> get props => [];
}

class LoadNameEvent extends SettingEvent {}

class SaveNameEvent extends SettingEvent {
  final String name;
  const SaveNameEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

class ClearNameEvent extends SettingEvent {}

class UpdateLocaleEvent extends SettingEvent {
  final bool value;
  const UpdateLocaleEvent({required this.value});

  @override
  List<Object?> get props => [value];
}

class LoadLocaleEvent extends SettingEvent {}
