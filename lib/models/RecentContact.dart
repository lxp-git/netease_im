import 'MsgStatusEnum.dart';
import 'MsgTypeEnum.dart';
import 'SessionTypeEnum.dart';
import 'attachment/MsgAttachment.dart';
import 'index.dart';

/// 最近联系人数据接口
class RecentContact {
  /// 获取最近联系人的ID（好友帐号，群ID等）
  ///
  /// @return 最近联系人帐号
  String contactId;

  /// 获取与该联系人的最后一条消息的发送方的帐号
  ///
  /// @return 发送者帐号
  String fromAccount;

  /// 获取与该联系人的最后一条消息的发送方的昵称
  ///
  /// @return 发送者昵称
  String fromNick;

  /// 获取会话类型
  SessionTypeEnum sessionType;

  /// 最近一条消息的消息ID @see {@link IMMessage#getUuid} }
  ///
  /// @return 最近一条消息的UUID
  String recentMessageId;

  /// 获取最近一条消息的消息类型
  ///
  /// @return 消息类型
  MsgTypeEnum msgType;

  /// 获取最近一条消息状态
  ///
  /// @return 最近一条消息的状态
  MsgStatusEnum msgStatus;

  /// 获取该联系人的未读消息条数
  ///
  /// @return 未读数
  int unreadCount;

  /// 获取最近一条消息的缩略内容。<br>
  ///     对于文本消息，返回文本内容。<br>
  ///     对于其他消息，返回一个简单的说明内容。如需展示更详细，或其他需求，可根据{@link #getAttachment}生成。
  ///
  /// @return 缩略内容
  String content;

  /// 获取最近一条消息的时间，单位为ms
  ///
  /// @return 时间
  num time;

  /// 如果最近一条消息是扩展消息类型，获取消息的附件内容. <br>
  ///     在最近消息列表，第三方app可据此自主定义显示的缩略语
  ///
  /// @return 附件内容
  MsgAttachment attachment;

  /// 获取标签
  /// @return 标签值
  num tag;

  /// 获取扩展字段
  /// @return 扩展字段Map
  Map<String, Object> extension;

  RecentContact.fromJson(Map json){
    contactId = json["contactId"];
    fromAccount = json["fromAccount"];
    sessionType = parseSessionType(json["sessionType"]);
    recentMessageId = json["recentMessageId"];
    msgType = parseMsgType(json["msgType"]);
    unreadCount = json["unreadCount"];
    content = json["content"];
    time = json["time"];
    attachment = parseAttachment(msgType, json["attachment"]);
    tag = json["tag"];
    extension = json["extension"];
  }
}
