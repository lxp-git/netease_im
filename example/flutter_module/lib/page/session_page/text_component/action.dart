import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IMMessageAction { action }

class IMMessageActionCreator {
  static Action onAction() {
    return const Action(IMMessageAction.action);
  }
}
