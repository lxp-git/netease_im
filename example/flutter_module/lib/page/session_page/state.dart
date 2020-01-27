import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/model/attachment/CustomAttachment.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';
import 'package:netease_im/models/NimUserInfo.dart';
import 'package:netease_im/models/index.dart';

enum ShowedPanel {
  MORE, EMOJI, NONE
}

class SessionPageState extends MutableSource
    implements Cloneable<SessionPageState> {
  String sessionId;
  NimUserInfo nimUserInfo;
  List<IMMessageState> iMMessageStateList;

  TextEditingController sendTextEditingController;
  ShowedPanel showedPanel = ShowedPanel.NONE;

  List<String> popMenus = [
    "云消息记录", "搜索本地消息记录", "清空本地消息记录", "清空点对点历史消息", "更多..."
  ];

  SessionPageState({this.sessionId, this.nimUserInfo, this.iMMessageStateList,
    this.sendTextEditingController, this.showedPanel});

  @override
  SessionPageState clone() {
    return SessionPageState()
      ..nimUserInfo = nimUserInfo
      ..iMMessageStateList = iMMessageStateList
      ..sessionId = sessionId
    ..sendTextEditingController = sendTextEditingController
    ..showedPanel = showedPanel;
  }

  @override
  Object getItemData(int index) {
    return iMMessageStateList[index];
  }

  @override
  String getItemType(int index) {
    MsgTypeEnum msgTypeEnum = iMMessageStateList[index].msgType;
    if (msgTypeEnum == MsgTypeEnum.custom) {
      CustomAttachment customAttachment = iMMessageStateList[index].attachment;
      if (customAttachment != null) {
        return 'MsgTypeEnum.custom${customAttachment.type}';
      }
      return "MsgTypeEnum.text";
    } else {
      return msgTypeEnum.toString();
    }
  }

  @override
  int get itemCount => iMMessageStateList?.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    iMMessageStateList[index] = data;
  }
}

SessionPageState initState(Map<String, dynamic> args) {
  return SessionPageState(sessionId: args['sessionId'], iMMessageStateList: [], sendTextEditingController: TextEditingController(), showedPanel: ShowedPanel.NONE);
}
