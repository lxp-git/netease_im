import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<NotFoundState> buildEffect() {
  return combineEffects(<Object, Effect<NotFoundState>>{
    NotFoundAction.action: _onAction,
  });
}

void _onAction(Action action, Context<NotFoundState> ctx) {
}
