import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AvatarState> buildEffect() {
  return combineEffects(<Object, Effect<AvatarState>>{
    AvatarAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AvatarState> ctx) {
}
