import 'package:film/components/dialogs/error_dialog.dart';
import 'package:film/presentation/bloc/error_bloc/error_event.dart';
import 'package:film/presentation/bloc/error_bloc/error_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(const ErrorState()) {
    on<ShowDialogEvent>(_onShowDialog);
  }

  void _onShowDialog(ShowDialogEvent event, Emitter<ErrorState> emit) {
    showErrorDialog(error: '${event.title} ${event.message}');
  }
}
