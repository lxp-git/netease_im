import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<IMMessageState> buildEffect() {
  return combineEffects(<Object, Effect<IMMessageState>>{
    IMMessageAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IMMessageState> ctx) {
}
