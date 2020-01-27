import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ImageState> buildEffect() {
  return combineEffects(<Object, Effect<ImageState>>{
    ImageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ImageState> ctx) {
}
