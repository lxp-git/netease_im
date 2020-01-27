import 'dart:core';

import 'CustomAttachment.dart';
import 'CustomAttachmentType.dart';

class RedPacketAttachment extends CustomAttachment {

  String content;//  消息文本内容
  String redPacketId;//  红包id
  String title;// 红包名称

  static const String KEY_CONTENT = "content";
  static const String KEY_ID = "redPacketId";
  static const String KEY_TITLE = "title";

  RedPacketAttachment() : super(CustomAttachmentType.RedPacket);

  @override
  void parseData(Map data) {
//    content = data.getString(KEY_CONTENT);
//    redPacketId = data.getString(KEY_ID);
//    title = data.getString(KEY_TITLE);
  }

  @override
  Map packData() {
//    JSONObject data = new JSONObject();
//    data.put(KEY_CONTENT, content);
//    data.put(KEY_ID, redPacketId);
//    data.put(KEY_TITLE, title);
//    return data;
    return {};
  }

  String getRpContent() {
    return content;
  }

  String getRpId() {
    return redPacketId;
  }

  String getRpTitle() {
    return title;
  }


  void setRpContent(String content) {
    this.content = content;
  }

  void setRpId(String briberyID) {
    this.redPacketId = briberyID;
  }

  void setRpTitle(String briberyName) {
    this.title = briberyName;
  }
}
