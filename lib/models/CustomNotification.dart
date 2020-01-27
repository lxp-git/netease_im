import 'CustomNotificationConfig.dart';
import 'SessionTypeEnum.dart';
import 'index.dart';

/// 自定义通知。<br>
/// 区别于IMMessage，SDK仅透传该类型消息，不负责解析和存储。消息内容由第三方APP自由扩展。<br>
/// 自定义通知消息可选择要不要发送给当前不在线的用户。<br>
class CustomNotification  {

//  private String sessionId;
//
//  private SessionTypeEnum sessionType;
//
//  private String fromAccount;
//
//  private long time;
//
//  private String content;
//
//  private boolean sendToOnlineUserOnly = true;
//
//  private String apnsText;
//
//  private Map<String, Object> pushPayload;
//
//  private CustomNotificationConfig config;
//
//  private NIMAntiSpamOption antiSpamOption;
  /// 获取聊天对象的Id（好友帐号，群ID等）。
  ///
  /// @return 聊天对象ID
  String sessionId;

  /// 获取会话类型。
  ///
  /// @return 会话类型
  SessionTypeEnum sessionType;

  /// 获取该通知的发出者帐号。
  ///
  /// @return 发出者帐号
  String fromAccount;

  /// 获取消息时间，单位为ms
  num time;

  /// 获取消息具体内容。
  String content;

  /// 设置该消息是否只发送给当前在线的用户。<br>
  /// 如果该值为true，只有接收方当前在线时，才能收到该消息。<br>
  /// 如果该值为false，如果接收方当前在线，会立即收到该消息，如果不在线，会在下一次登录后收到该消息。
  /// 设置为false后，该消息和普通IM消息一样保证必达。<br>
  ///
  /// @param sendToOnlineUserOnly 是否只发送给在线用户/群组，云信SDK 4.1版本开始支持群组离线自定义通知.
  bool isSendToOnlineUserOnly;

  /// 获取如果接收方是iOS设备登录，该消息的APNS推送文本内容
  ///
  /// @return apns推送文本设置
  String apnsText;

  /// 设置第三方自定义的推送属性
  ///
  /// @param pushPayload 第三方自定义的推送属性Map，开发者需要保证此Map能够转换为JsonObject，属性内容最大长度2048字节
  Map<String, Object> pushPayload;

  CustomNotificationConfig config;

  /**
   * 获取反垃圾配置
   *
   * @return
   */
//  NIMAntiSpamOption getNIMAntiSpamOption() {
//    return antiSpamOption;
//  }

  ///设置反垃圾配置项
  ///
  /// @param antiSpamOption
//  void setNIMAntiSpamOption(NIMAntiSpamOption antiSpamOption) {
//    this.antiSpamOption = antiSpamOption;
//  }

  CustomNotification.fromJson(Map json){
    sessionId = json["sessionId"];
    sessionType = parseSessionType(json["sessionType"]);
    fromAccount = json["fromAccount"];
    time = json["time"];
    content = json["content"];
    isSendToOnlineUserOnly = json["isSendToOnlineUserOnly"];
    apnsText = json["apnsText"];
    pushPayload = json["pushPayload"];
    config = CustomNotificationConfig.fromJson(json["config"]);
  }
}
