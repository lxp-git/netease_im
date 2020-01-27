/// 消息本身发送/接收状态，附件状态见{@link AttachStatusEnum}
enum MsgStatusEnum {
  /// 草稿
  draft,

  /// 正在发送中
  sending,

  /// 发送成功
  success,

  /// 发送失败
  fail,

  /// 消息已读
  /// 发送消息时表示对方已看过该消息
  /// 接收消息时表示自己已读过，一般仅用于音频消息
  read,

  /// 未读状态
  unread,
}
