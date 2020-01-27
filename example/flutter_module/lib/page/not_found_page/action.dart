import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum NotFoundAction { action }

class NotFoundActionCreator {
  static Action onAction() {
    return const Action(NotFoundAction.action);
  }
}
