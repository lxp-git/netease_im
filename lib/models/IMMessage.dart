import 'MsgDirectionEnum.dart';
import 'MsgStatusEnum.dart';
import 'MsgTypeEnum.dart';
import 'SessionTypeEnum.dart';
import 'attachment/MsgAttachment.dart';
import 'index.dart';

/// NIM消息实体数据结构。
/// 第三方APP不要调用设置类接口，调用之后不会被持久化
class IMMessage {
  /// 获取消息的uuid, 该域在生成消息时即会填上
  ///
  /// @return 消息uuid
  String uuid;

  /**
   * 判断与参数message是否是同一条消息。<br>
   * 先比较数据库记录ID，如果没有数据库记录ID，则比较{@link #getUuid()}
   *
   * @param message 消息对象
   * @return 两条消息是否相同
   */
//boolean isTheSame(IMMessage message);

  /// 获取聊天对象的Id（好友帐号，群ID等）。
  ///
  /// @return 聊天对象ID
  String sessionId;

  /// 获取会话类型。
  ///
  /// @return 会话类型
  SessionTypeEnum sessionType;

  /// 获取消息发送者的昵称
  ///
  /// @return 用户的昵称
  String fromNick;

  /// 获取消息类型。
  ///
  /// @return 消息类型
  MsgTypeEnum msgType;

  /// 获取消息接收/发送状态。
  ///
  /// @return 消息状态
  MsgStatusEnum status;

  /**
   * 设置消息状态
   *
   * @param status 消息状态
   */
//void setStatus(MsgStatusEnum status);

  /**
   * 设置消息方向
   *
   * @param direct 消息方向
   */
//void setDirect(MsgDirectionEnum direct);

  /// 获取消息方向：发出去的消息还是接收到的消息
  ///
  /// @return 消息方向
  MsgDirectionEnum direct;

  /**
   * 设置消息具体内容。<br>
   * 当消息类型{@link com.netease.nimlib.sdk.msg.constant.MsgTypeEnum#text}时，该域为消息内容。
   * 当为其他消息类型时，该域为可选项，如果设置，将作为iOS的apns推送文本以及android内置消息推送的显示文本。
   *
   * @param content 消息内容/推送文本
   */
//void setContent(String content);

  /// 获取消息具体内容。<br>
  /// 当消息类型{@link com.netease.nimlib.sdk.msg.constant.MsgTypeEnum#text}时，该域为消息内容。
  /// 当为其他消息类型时，该域为可选项，如果设置，将作为iOS的apns推送文本以及android内置消息推送的显示文本（1.7.0及以上版本建议使用pushContent）。
  ///
  /// @return 消息内容/推送文本
  String content;

  /// 获取消息时间，单位为ms
  ///
  /// @return 时间
  num time;

  /// 设置说话方的帐号。消息方向{@link #getDirect()}根据改之
  ///
  /// @param account 帐号
  String fromAccount;

  /**
   * 获取该条消息发送方的帐号
   */
//String getFromAccount();

  /// 设置消息附件对象。<br>
  /// 如果附件内部包含状态，或是自定义附件类型，用户可自主更新，以便界面展现。<br>
  /// 注意：设置之后，如需持久化到数据库，需要调用{@link com.netease.nimlib.sdk.msg.MsgService#updateIMMessageStatus}更新
  ///
  /// @param attachment
  MsgAttachment attachment;

  /**
   * 获取消息附件对象。仅当{@link #getMsgType()}返回为非text时有效
   */
//MsgAttachment getAttachment();

  /// 获取消息附件文本内容
  /// @return
  String attachStr;

  /// 获取消息附件接收/发送状态
  AttachStatusEnum attachStatus;
//
  ///**
// * 设置消息附件状态
// */
//void setAttachStatus(AttachStatusEnum attachStatus);
//
  ///**
// * 获取消息配置
// *
// * @return 消息配置
// */
//CustomMessageConfig getConfig();
//
  ///**
// * 设置消息配置
// *
// * @param config 消息配置
// */
//void setConfig(CustomMessageConfig config);
//
  ///**
// * 获取扩展字段（该字段会发送到其他端）
// *
// * @return 扩展字段Map
// */
//Map<String, Object> getRemoteExtension();
//
  ///**
// * 设置扩展字段（该字段会发送到其他端），最大长度1024字节。
// *
// * @param remoteExtension 扩展字段Map，开发者需要保证此Map能够转换为JsonObject
// */
//void setRemoteExtension(Map<String, Object> remoteExtension);
//
  ///**
// * 获取本地扩展字段（仅本地有效）
// *
// * @return 扩展字段Map
// */
//Map<String, Object> getLocalExtension();
//
  ///**
// * 设置本地扩展字段（该字段仅在本地使用有效，不会发送给其他端），最大长度1024字节
// *
// * @param localExtension
// */
//void setLocalExtension(Map<String, Object> localExtension);
//
  ///**
// * 获取自定义推送文案
// *
// * @return 自定义推送文案
// */
//String getPushContent();
//
  ///**
// * 设置自定义推送文案（1.7.0及以上版本建议使用此字段，不要使用setContent来设置推送文案），目前长度限制为500字以内
// *
// * @param pushContent 自定义推送文案
// */
//void setPushContent(String pushContent);
//
  ///**
// * 获取第三方自定义的推送属性
// *
// * @return 第三方自定义的推送属性Map
// */
//Map<String, Object> getPushPayload();
//
  ///**
// * 设置第三方自定义的推送属性
// *
// * @param pushPayload 第三方自定义的推送属性Map，开发者需要保证此Map能够转换为JsonObject，属性内容最大长度2048字节
// */
//void setPushPayload(Map<String, Object> pushPayload);
//
  ///**
// * 获取指定成员推送选项
// *
// * @return 指定成员推送选项
// */
//MemberPushOption getMemberPushOption();
//
  ///**
// * 设置指定成员推送选项
// *
// * @param pushOption 指定成员推送选项
// */
//void setMemberPushOption(MemberPushOption pushOption);
//
  ///**
// * 判断自己发送的消息对方是否已读
// *
// * @return true：对方已读；false：对方未读
// */
//boolean isRemoteRead();
//
  ///**
// * 是否需要消息已读（主要针对群消息）
// *
// * @return 该消息是否需要发送已读确认
// */
//boolean needMsgAck();
//
  ///**
// * 设置该消息为需要消息已读的
// */
//void setMsgAck();
//
  ///**
// * 是否已经发送过群消息已读回执
// *
// * @return 是否已经发送过已读回执
// */
//boolean hasSendAck();
//
  ///**
// * 返回群消息已读回执的已读数
// *
// * @return 群里多少人已读了该消息
// */
//int getTeamMsgAckCount();
//
  ///**
// * 返回群消息已读回执的未读数
// *
// * @return 群里多少人还未读该消息
// */
//int getTeamMsgUnAckCount();
//
  ///**
// * 获取消息发送方类型
// *
// * @return 发送方的客户端类型，与ClientType类比较
// */
//int getFromClientType();
//
  ///**
// * 获取易盾反垃圾配置项
// *
// * @return NIMAntiSpamOption
// */
//NIMAntiSpamOption getNIMAntiSpamOption();
//
  ///**
// * 设置易盾反垃圾选项
// *
// * @param nimAntiSpamOption
// */
//void setNIMAntiSpamOption(NIMAntiSpamOption nimAntiSpamOption);
//
  ///**
// * 命中了客户端反垃圾，服务器处理
// *
// * @param hit
// */
//void setClientAntiSpam(boolean hit);
//
//
  ///**
// * 如果服务器存在相同的附件文件，是否强制重新上传文件 ，默认false
// *
// * @param forceUpload
// */
//void setForceUploadFile(boolean forceUpload);
//
//
  ///**
// * 发送消息给对方， 是不是被对方拉黑了（消息本身是发送成功的）
// *
// * @return
// */
//
//boolean isInBlackList();

  IMMessage.fromJson(Map json) {
    content = json["content"];
    sessionId = json["sessionId"];
    msgType = parseMsgType(json["msgType"]);
    status = parseMsgStatus(json["status"]);
    direct = parseMsgDirection(json["direct"]);
    sessionType = parseSessionType(json["sessionType"]);
    fromNick = json["fromNick"];
    fromAccount = json["fromAccount"];
    uuid = json["uuid"];
    time = json["time"];
    if (json["attachment"] != null && msgType != null)
      attachment = parseAttachment(msgType, json["attachment"]);
    attachStatus = parseAttachStatus(json["attachStatus"]);
  }

  toJson() => {
    "content": content,
    "sessionId": sessionId,
    "msgType": msgType.toString(),
    "status": status.toString(),
    "direct": direct.toString(),
    "sessionType": sessionType.toString(),
    "fromNick": fromNick.toString(),
    "fromAccount": fromAccount,
    "uuid": uuid,
    "time": time,
    "attachment": attachment?.toJson(false),
    "attachStatus": attachStatus.toString()
  };
}
