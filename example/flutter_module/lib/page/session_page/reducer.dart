import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';

import 'action.dart';
import 'state.dart';

Reducer<SessionPageState> buildReducer() {
  return asReducer(
    <Object, Reducer<SessionPageState>>{
      SessionPageAction.updateStateAction: _onUpdateStateAction,
      SessionPageAction.moreButtonClickAction: _onMoreButtonClickAction,
      SessionPageAction.sendTextChangeAction: _onSendTextChangeAction
    },
  );
}

SessionPageState _onUpdateStateAction(SessionPageState state, Action action) {
  return action.payload as SessionPageState;
}

SessionPageState _onMoreButtonClickAction(SessionPageState state, Action action) {
  if (state.showedPanel == ShowedPanel.MORE) {
    return state.clone()..showedPanel = ShowedPanel.NONE;
  }
  return state.clone()..showedPanel = ShowedPanel.MORE;
}

SessionPageState _onSendTextChangeAction(SessionPageState state, Action action) {
  return state.clone()..sendTextEditingController = TextEditingController.fromValue(state.sendTextEditingController.value);
}