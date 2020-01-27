import 'package:netease_im/models/attachment/MsgAttachment.dart';

abstract class MsgAttachmentParser {

/// 将一个字符串解析为一个云信消息附件。一般而言，该字符串是一个json字符串。
/// @param attach 附件序列化后的字符串内容
/// @return 解析结果
  MsgAttachment parse(String attach);
}