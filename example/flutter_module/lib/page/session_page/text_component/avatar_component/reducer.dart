import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AvatarState> buildReducer() {
  return asReducer(
    <Object, Reducer<AvatarState>>{
      AvatarAction.action: _onAction,
    },
  );
}

AvatarState _onAction(AvatarState state, Action action) {
  final AvatarState newState = state.clone();
  return newState;
}
