import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

enum SessionPageAction {
  queryMessageListExAction, updateStateAction, sendButtonClickAction,
  triggerEmojiPanelAction, chooseEmojiAction, sendTextChangeAction, moreButtonClickAction,
  moreItemClickAction, popMenuSelectedAction,
}

class SessionPageActionCreator {
  static Action onUpdateStateAction(SessionPageState state) {
    return Action(SessionPageAction.updateStateAction, payload: state);
  }
  static Action onQueryMessageListExAction() {
    return const Action(SessionPageAction.queryMessageListExAction);
  }
  static Action onSendButtonClickAction(String text) {
    return Action(SessionPageAction.sendButtonClickAction, payload: text);
  }
  static Action onTriggerEmojiPanelAction() {
    return const Action(SessionPageAction.triggerEmojiPanelAction);
  }
  static Action onMoreButtonClickAction() {
    return const Action(SessionPageAction.moreButtonClickAction);
  }
  static Action onChooseEmojiAction(String emoji) {
    return Action(SessionPageAction.chooseEmojiAction, payload: emoji);
  }
  static Action onSendTextChangeAction() {
    return const Action(SessionPageAction.sendTextChangeAction);
  }
  static Action onMoreItemClickAction(functionItem) {
    return Action(SessionPageAction.moreItemClickAction, payload: functionItem);
  }
  static Action onPopMenuSelectedAction(selectedValue) {
    return Action(SessionPageAction.popMenuSelectedAction, payload: selectedValue);
  }
}
