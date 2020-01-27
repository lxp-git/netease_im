import 'package:netease_im/models/MsgTypeEnum.dart';
import 'package:netease_im/models/index.dart';

import 'CustomAttachParser.dart';

T fillIMMessage<T>(T iMMessage) {
  if (iMMessage is IMMessage) {
    if (iMMessage.msgType == MsgTypeEnum.custom && iMMessage.attachment is String) {
      iMMessage.attachment =
          CustomAttachParser().parse(iMMessage.attachment as String);
      return iMMessage;
    }
  }
  if (iMMessage is RecentContact) {
    if (iMMessage.msgType == MsgTypeEnum.custom && iMMessage.attachment is String) {
      iMMessage.attachment =
          CustomAttachParser().parse(iMMessage.attachment as String);
      return iMMessage;
    }
  }
  return iMMessage;
}