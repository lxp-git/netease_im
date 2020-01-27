/// 消息的配置选项
class CustomNotificationConfig {

  /// 该通知是否要消息提醒，如果为true，那么对方收到通知后，系统通知栏会有提醒。
  /// 默认为true
  bool enablePush = true;

  /// 该通知是否需要推送昵称（针对iOS客户端有效），如果为false，那么对方收到通知后，iOS端将不显示推送昵称。
  /// 默认为false
  bool enablePushNick = false;

  /// 该通知是否要计入未读数，如果为true，那么对方收到通知后，可以通过读取此配置项决定自己业务的未读计数变更。
  /// 默认为true
  bool enableUnreadCount = true;

  CustomNotificationConfig.fromJson(Map json){
    enablePush = json["enablePush"];
    enablePushNick = json["enablePushNick"];
    enableUnreadCount = json["enableUnreadCount"];
  }
}
