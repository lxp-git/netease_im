import 'dart:core';

import 'package:netease_im/models/attachment/MsgAttachment.dart';
/// 自定义消息的附件
abstract class CustomAttachment extends MsgAttachment {
  int type;

  CustomAttachment(int type) {
    this.type = type;
  }

  void fromJson(Map data) {
    if (data != null) {
      parseData(data);
    }
  }

  @override
  Map<String, Object> toJson(bool send) {
    return {};
  }

  void parseData(Map data);

  Map packData();
}