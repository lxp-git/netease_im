import 'IMMessage.dart';

/// 消息撤回通知实体
/// 收到消息撤回通知后，sdk 会通知观察者，携带此对象

class RevokeMsgNotification {

  /// 被撤回的消息
  IMMessage message;


  /// 消息撤回者账号
  String revokeAccount;


  /// 获取消息撤回时设置的msg 字段（eg: 通过服务端API撤回）。
  String customInfo;


  /// 通知类型： 1表示是离线，2表示是漫游 ， 默认 0
  int notificationType;

  RevokeMsgNotification.fromJson(Map json){
    message = IMMessage.fromJson(json["message"]);
    revokeAccount = json["revokeAccount"];
    customInfo = json["customInfo"];
    notificationType = json["notificationType"];
  }
}
