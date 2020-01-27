import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_module/page/session_page/action.dart';
import 'package:flutter_module/page/session_page/message_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SessionPage extends Page<SessionPageState, Map<String, dynamic>> {
  SessionPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SessionPageState>(
              adapter: NoneConn<SessionPageState>() + IMMessageListAdapter(),
              slots: <String, Dependent<SessionPageState>>{}),
          middleware: <Middleware<SessionPageState>>[
            keyboardActionMiddleware(),
          ],
        );
}

Middleware<T> keyboardActionMiddleware<T>({
  String tag = 'redux',
  String Function(T) monitor,
}) {
  return ({Dispatch dispatch, Get<T> getState}) {
    return (Dispatch next) {
      return (Action action) {
        final T prevState = getState();
        next(action);
        final T nextState = getState();
        if (prevState is SessionPageState && nextState is SessionPageState) {
          if (prevState.showedPanel != ShowedPanel.NONE && nextState.showedPanel == ShowedPanel.NONE) {
            SystemChannels.textInput.invokeMethod('TextInput.show');
          }
          if (prevState.showedPanel == ShowedPanel.NONE && nextState.showedPanel != ShowedPanel.NONE) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
//            dispatch(SessionPageActionCreator.onUpdateStateAction(nextState.clone()));
          }
        }
      };
    };
  };
}

