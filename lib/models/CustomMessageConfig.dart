/// 消息的配置选项，主要用于设定消息的声明周期，是否需要推送，是否需要计入未读数等。
class CustomMessageConfig {

  static const String KEY_ENABLE_HISTORY = "KEY_ENABLE_HISTORY";
  static const String KEY_ENABLE_ROAMING = "KEY_ENABLE_ROAMING";
  static const String KEY_ENABLE_SELF_SYNC = "KEY_ENABLE_SELF_SYNC";
  static const String KEY_ENABLE_PUSH = "KEY_ENABLE_PUSH";
  static const String KEY_ENABLE_PERSIST = "KEY_ENABLE_PERSIST";
  static const String KEY_ENABLE_PUSH_NICK = "KEY_ENABLE_PUSH_NICK";
  static const String KEY_ENABLE_UNREAD_COUNT = "KEY_ENABLE_UNREAD_COUNT";
  static const String KEY_ENABLE_ROUTE = "KEY_ENABLE_ROUTE";

  /// 该消息是否要保存到服务器，如果为false，通过{@link MsgService#pullMessageHistory(IMMessage, int, bool)}拉取的结果将不包含该条消息。<br>
  /// 默认为true。
  bool enableHistory = true;

  /// 该消息是否需要漫游。如果为false，一旦某一个客户端收取过该条消息，其他端将不会再漫游到该条消息。<br>
  /// 默认为true
  bool enableRoaming = true;

  /// 多端同时登录时，发送一条自定义消息后，是否要同步到其他同时登录的客户端。<br>
  /// 默认为true
  bool enableSelfSync = true;

  /// 该消息是否要消息提醒，如果为true，那么对方收到消息后，系统通知栏会有提醒。
  /// 默认为true
  bool enablePush = true;

  /// 该消息是否需要推送昵称（针对iOS客户端有效），如果为true，那么对方收到消息后，iOS端将显示推送昵称。
  /// 默认为true
  bool enablePushNick = true;

  /// 该消息是否要计入未读数，如果为true，那么对方收到消息后，最近联系人列表中未读数加1。
  /// 默认为true
  bool enableUnreadCount = true;

  /// 该消息是否支持路由，如果为true，默认按照app的路由开关（如果有配置抄送地址则将抄送该消息）
  /// 默认为true
  bool enableRoute = true;

  /// 该消息是否要存离线
  /// 默认为true
  bool enablePersist = true;

  Map<String, dynamic> toJson() => ({
    "enableHistory": enableHistory,
    "enableRoaming": enableRoaming,
    "enableSelfSync": enableSelfSync,
    "enablePush": enablePush,
    "enablePushNick": enablePushNick,
    "enableUnreadCount": enableUnreadCount,
    "enableRoute": enableRoute,
    "enablePersist": enablePersist
  });
}
