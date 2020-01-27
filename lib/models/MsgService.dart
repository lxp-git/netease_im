class MsgService {

  /// 目前没有与任何人对话，但能看到消息提醒（比如在消息列表界面），不需要在状态栏做消息通知
  ///
  /// @see #setChattingAccount(String, com.netease.nimlib.sdk.msg.constant.SessionTypeEnum)
  static const String MSG_CHATTING_ACCOUNT_ALL = "all";

  /// 目前没有与任何人对话，需要状态栏消息通知
  ///
  /// @see #setChattingAccount(String, com.netease.nimlib.sdk.msg.constant.SessionTypeEnum)
  static const String MSG_CHATTING_ACCOUNT_NONE = null;
}