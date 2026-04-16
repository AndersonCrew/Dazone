import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template cubit_mixin}
/// A mixin to extend functionality for Cubit
/// {@endtemplate}
mixin CubitMixin<State> on Cubit<State> {
  /// Safely emits a new state if the Cubit is not closed.
  void safeEmit(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
