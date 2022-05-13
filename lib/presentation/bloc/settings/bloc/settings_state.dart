import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final String? name;
  const SettingState({this.name});

  SettingState copyWith({String? name}) =>
      SettingState(name: name ?? this.name);

  @override
  List<Object?> get props => [name ?? ''];
}
