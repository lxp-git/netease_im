import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';

enum IMMessageListAction { add }

class IMMessageListActionCreator {
  static Action add(IMMessageState state) {
    return Action(IMMessageListAction.add, payload: state);
  }
}
