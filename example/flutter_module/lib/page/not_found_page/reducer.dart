import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<NotFoundState> buildReducer() {
  return asReducer(
    <Object, Reducer<NotFoundState>>{
      NotFoundAction.action: _onAction,
    },
  );
}

NotFoundState _onAction(NotFoundState state, Action action) {
  final NotFoundState newState = state.clone();
  return newState;
}
