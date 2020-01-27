import 'dart:convert';

import 'package:netease_im/models/attachment/MsgAttachment.dart';
import 'package:netease_im/models/index.dart';

import 'attachment/CustomAttachment.dart';
import 'attachment/CustomAttachmentType.dart';
import 'attachment/StickerAttachment.dart';

class CustomAttachParser extends MsgAttachmentParser {

  static const String KEY_TYPE = "type";
  static const String KEY_DATA = "data";

  @override
  MsgAttachment parse(String attach) {
    CustomAttachment attachment = null;
    try {
      Map object = jsonDecode(attach);
      int type = object[KEY_TYPE];
      Map data = object[KEY_DATA];
      switch (type) {
        case CustomAttachmentType.Guess:
//          attachment = new GuessAttachment();
          break;
        case CustomAttachmentType.SnapChat:
//          return new SnapChatAttachment(data);
        case CustomAttachmentType.Sticker:
          attachment = StickerAttachment();
          break;
        case CustomAttachmentType.RTS:
//          attachment = new RTSAttachment();
          break;
        case CustomAttachmentType.RedPacket:
//          attachment = new RedPacketAttachment();
          break;
        case CustomAttachmentType.OpenedRedPacket:
//          attachment = new RedPacketOpenedAttachment();
          break;
        default:
//          attachment = new DefaultCustomAttachment();
          break;
      }

      if (attachment != null) {
        attachment.fromJson(data);
      }
    } catch (error) {
      print("error:$error");
    }

    return attachment;
  }

}