import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';

import '../state.dart';
import 'action.dart';

Reducer<SessionPageState> buildReducer() {
  return asReducer(<Object, Reducer<SessionPageState>>{
    IMMessageListAction.add: _add,
  });
}

SessionPageState _add(SessionPageState state, Action action) {
  final IMMessageState iMMessageState = action.payload;
  return state.clone()..iMMessageStateList = (state.iMMessageStateList.toList()..add(iMMessageState));
}
