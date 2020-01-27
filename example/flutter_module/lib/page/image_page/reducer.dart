import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ImageState> buildReducer() {
  return asReducer(
    <Object, Reducer<ImageState>>{
      ImageAction.action: _onAction,
    },
  );
}

ImageState _onAction(ImageState state, Action action) {
  final ImageState newState = state.clone();
  return newState;
}
