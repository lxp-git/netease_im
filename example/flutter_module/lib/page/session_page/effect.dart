import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_module/model/CustomAttachParser.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';
import 'package:netease_im/MessageBuilder.dart';
import 'package:netease_im/models/NimUserInfo.dart';
import 'package:netease_im/netease_im.dart';
import 'package:netease_im/models/index.dart';
import 'action.dart';
import 'state.dart';

Effect<SessionPageState> buildEffect() {
  return combineEffects(<Object, Effect<SessionPageState>>{
    SessionPageAction.queryMessageListExAction: _onQueryMessageListExAction,
    Lifecycle.initState: _init,
    SessionPageAction.sendButtonClickAction: _onSendButtonClickAction,
    SessionPageAction.chooseEmojiAction: _onChooseEmojiAction,
    SessionPageAction.triggerEmojiPanelAction: _onTriggerEmojiPanelAction,
    SessionPageAction.popMenuSelectedAction: _onPopMenuSelectedAction,
  });
}

void _onQueryMessageListExAction(Action action, Context<SessionPageState> ctx) async {
  int remainder = ctx.state.iMMessageStateList.length % 20;
  bool _hasMoreData = remainder == 0;
  if (_hasMoreData) {
    final historyIMMessages = ctx.state.iMMessageStateList;
    List<IMMessage> iMMessages = await NeteaseIM().queryMessageListEx(ctx.state.sessionId,
        historyIMMessages.length > 0 ? historyIMMessages[historyIMMessages.length - 1].uuid : null,
        QueryDirectionEnum.QUERY_OLD, 20, true);
    ctx.state.iMMessageStateList.addAll(iMMessageToIMMessageState(iMMessages));
    ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(ctx.state.clone()));
  }
}

List<IMMessageState> iMMessageToIMMessageState(List<IMMessage> iMMessages) {
  return iMMessages.map((iMMessage) =>
  IMMessageState()..uuid = iMMessage.uuid
    ..sessionId = iMMessage.sessionId
    ..sessionType = iMMessage.sessionType
    ..fromNick = iMMessage.fromNick
    ..msgType = iMMessage.msgType
    ..status = iMMessage.status
    ..direct = iMMessage.direct
    ..content = iMMessage.content
    ..time = iMMessage.time
    ..fromAccount = iMMessage.fromAccount
    ..attachment = iMMessage.attachment
    ..attachStr = iMMessage.attachStr
    ..attachStatus = iMMessage.attachStatus
  ).toList();
}

void _init(Action action, Context<SessionPageState> ctx) async {
//  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: Colors.transparent,
//      ///这是设置状态栏的图标和字体的颜色
//      ///Brightness.light  一般都是显示为白色
//      ///Brightness.dark 一般都是显示为黑色
//      statusBarIconBrightness: Brightness.dark
//  ));
  NeteaseIM().registerCustomAttachmentParser(CustomAttachParser());
  ctx.dispatch(SessionPageActionCreator.onQueryMessageListExAction());
  NeteaseIM().localMessageStream.listen((List<IMMessage> iMMessages){
    ctx.state.iMMessageStateList.addAll(iMMessageToIMMessageState(iMMessages));
    ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(ctx.state.clone()));
  });
  List<NimUserInfo> nimUserInfoList = await NeteaseIM().fetchUserInfo(ctx.state.sessionId);
  ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(ctx.state.clone()..nimUserInfo = nimUserInfoList[0]));
}

void _onSendButtonClickAction(Action action, Context<SessionPageState> ctx) async {
  IMMessage iMMessage = await MessageBuilder.createTextMessage(ctx.state.sessionId, SessionTypeEnum.P2P, ctx.state.sendTextEditingController.text);
  final sendResult = await NeteaseIM().sendMessage(iMMessage, false);
  ctx.state.sendTextEditingController.clear();
}

void _onChooseEmojiAction(Action action, Context<SessionPageState> ctx) async {
  String emoji = action.payload as String;
  final oldSendTextEditingController = ctx.state.sendTextEditingController;
  int cursorIndex = oldSendTextEditingController.selection.base.offset;
  String startString = oldSendTextEditingController.text.substring(0, cursorIndex);
  String endString = oldSendTextEditingController.text.substring(cursorIndex);
  final newText = startString + emoji + endString;
  final sendTextEditingController = TextEditingController.fromValue(
    ///用来设置初始化时显示
    TextEditingValue(
      ///用来设置文本 controller.text = "0000"
      text: newText,
      ///设置光标的位置
      selection: TextSelection.fromPosition(
        ///用来设置文本的位置
        TextPosition(
            affinity: TextAffinity.downstream,
            /// 光标向后移动的长度
            offset: (startString + emoji).length),),),
  );
  ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(
      ctx.state.clone()..sendTextEditingController = sendTextEditingController)
  );
}

void _onTriggerEmojiPanelAction(Action action, Context<SessionPageState> ctx) async {
  if (ctx.state.showedPanel == ShowedPanel.EMOJI) {
//    SystemChannels.textInput.invokeMethod('TextInput.show');
//    TextInputConnection().close();
  /// 因为设置panel不为none时，键盘还没关闭，
    ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(ctx.state.clone()..showedPanel = ShowedPanel.NONE));
  } else {
//    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    await Future.delayed(Duration(milliseconds: 60));
    ctx.dispatch(SessionPageActionCreator.onUpdateStateAction(ctx.state.clone()..showedPanel = ShowedPanel.EMOJI));
  }
}

void _onPopMenuSelectedAction(Action action, Context<SessionPageState> ctx) async {
  if (action.payload == ctx.state.popMenus[0]) {
//    MessageHistoryActivity.start(item.getContext(), item.getSessionId(),
//        item.getSessionTypeEnum()); // 漫游消息查询
  } else if (action.payload == ctx.state.popMenus[1]) {
//    SearchMessageActivity.start(item.getContext(), item.getSessionId(), item.getSessionTypeEnum());
  } else if (action.payload == ctx.state.popMenus[2]) {
//    EasyAlertDialogHelper.createOkCancelDiolag(item.getContext(), null, "确定要清空吗？", true,
//        new EasyAlertDialogHelper.OnDialogActionListener() {
//
//        @Override
//        public void doCancelAction() {
//        }
//
//        @Override
//        public void doOkAction() {
//        NIMClient.getService(MsgService.class)
//            .clearChattingHistory(
//        item.getSessionId(),
//        item.getSessionTypeEnum());
//        MessageListPanelHelper.getInstance()
//            .notifyClearMessages(
//        item.getSessionId());
//        }
//        }).show();
  } else if (action.payload == ctx.state.popMenus[3]) {
//    String title = item.getContext().getString(R.string.message_p2p_clear_tips);
//    CustomAlertDialog alertDialog = new CustomAlertDialog(item.getContext());
//    alertDialog.setTitle(title);
//    alertDialog.addItem("确定", new CustomAlertDialog.onSeparateItemClickListener() {
//
//    @Override
//    public void onClick() {
//    NIMClient.getService(MsgService.class).clearServerHistory(item.getSessionId(),
//    item.getSessionTypeEnum());
//    MessageListPanelHelper.getInstance().notifyClearMessages(item.getSessionId());
//    }
//    });
//    String itemText = item.getContext().getString(R.string.sure_keep_roam);
//    alertDialog.addItem(itemText, new CustomAlertDialog.onSeparateItemClickListener() {
//
//    @Override
//    public void onClick() {
//    NIMClient.getService(MsgService.class).clearServerHistory(item.getSessionId(),
//    item.getSessionTypeEnum(), false);
//    MessageListPanelHelper.getInstance().notifyClearMessages(item.getSessionId());
//    }
//    });
//    alertDialog.addItem("取消", new CustomAlertDialog.onSeparateItemClickListener() {
//
//    @Override
//    public void onClick() {
//    }
//    });
//    alertDialog.show();
  } else if (action.payload == ctx.state.popMenus[4]) {
//  MessageInfoActivity.startActivity(context, sessionId);
  }
}