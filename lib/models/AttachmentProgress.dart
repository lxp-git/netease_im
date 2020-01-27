/// 附件发送/接收进度通知
class AttachmentProgress {

  /// 获取附件对应的消息的uuid
  String uuid;
  /// 获取已经传输的字节数
  num transferred;
  /// 获取文件总长度
  num total;

  AttachmentProgress.fromJson(Map json) {
    uuid = json["uuid"];
    transferred = json["transferred"];
    total = json["total"];
  }
}
