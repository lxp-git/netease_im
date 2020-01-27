/// 消息已读回执
class MessageReceipt {
  /// 会话ID（聊天对方账号）
  ///
  /// @return P2P聊天对方的account
  String sessionId;
  /// 该会话最后一条已读消息的时间，比该时间早的消息都视为已读
  ///
  /// @return 消息的时间
  num time;

  MessageReceipt.fromJson(Map json){
    sessionId = json["sessionId"];
    time = json["time"];
  }
}
