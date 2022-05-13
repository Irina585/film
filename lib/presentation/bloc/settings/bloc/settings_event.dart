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
