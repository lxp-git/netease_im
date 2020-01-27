import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IMMessageState> buildReducer() {
  return asReducer(
    <Object, Reducer<IMMessageState>>{
      IMMessageAction.action: _onAction,
    },
  );
}

IMMessageState _onAction(IMMessageState state, Action action) {
  final IMMessageState newState = state.clone();
  return newState;
}
