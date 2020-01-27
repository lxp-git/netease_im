/// 消息类型定义
enum MsgTypeEnum {
  /// 未知消息类型
  undef,

  /// 文本消息类型
  text,

  /// 图片消息
  image,

  /// 音频消息
  audio,

  /// 视频消息
  video,

  /// 位置消息
  location,

  /// 文件消息
  file,

  /// 音视频通话
  avchat,

  /// 通知消息
  notification,

  /// 提醒类型消息
  tip,

  /// 机器人消息
  robot,

  /// 第三方APP自定义消息
  custom,
}
