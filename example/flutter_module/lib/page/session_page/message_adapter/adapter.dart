import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_module/page/session_page/state.dart';
import 'package:flutter_module/page/session_page/sticker_component/component.dart';
import 'package:flutter_module/page/session_page/text_component/component.dart';

import 'reducer.dart';

class IMMessageListAdapter extends SourceFlowAdapter<SessionPageState> {
  IMMessageListAdapter()
      : super(
    pool: <String, Component<Object>>{
      'MsgTypeEnum.text': TextComponent(),
      'MsgTypeEnum.avchat': TextComponent(),
      'MsgTypeEnum.custom1': TextComponent(),
      'MsgTypeEnum.custom2': TextComponent(),
      'MsgTypeEnum.custom3': TextComponent(),
    },
    reducer: buildReducer(),
  );


}