import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ImageAction { action }

class ImageActionCreator {
  static Action onAction() {
    return const Action(ImageAction.action);
  }
}
