import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/model/attachment/CustomAttachment.dart';
import 'package:flutter_module/model/attachment/CustomAttachmentType.dart';
import 'package:flutter_module/model/attachment/StickerAttachment.dart';
import 'package:flutter_module/utils/sticker.dart';
import 'package:netease_im/models/index.dart';

import 'state.dart';

Widget buildView(IMMessageState state, Dispatch dispatch, ViewService viewService) {

  MsgTypeEnum msgTypeEnum = state.msgType;
  String itemType;
  if (msgTypeEnum == MsgTypeEnum.custom) {
    CustomAttachment customAttachment = state.attachment;
    if (customAttachment == null) {
      itemType = "MsgTypeEnum.text";
    } else {
      itemType = 'MsgTypeEnum.custom${customAttachment.type}';
    }
  } else {
    itemType = msgTypeEnum.toString();
  }
  final List<Widget> row = [];
  final padding = SizedBox(width: 10,);
  Widget content = Container();
  final avatar = viewService.buildComponent('avatar');
  if (itemType == "MsgTypeEnum.text")
    content = TextMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.Guess}")
    content = TextMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.SnapChat}")
    content = TextMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.Sticker}")
    content = StickerMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.RTS}")
    content = TextMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.RedPacket}")
    content = TextMessage(state);
  if (itemType == "MsgTypeEnum.custom${CustomAttachmentType.OpenedRedPacket}")
    content = TextMessage(state);
  if (state.direct == MsgDirectionEnum.In) {
    row.add(avatar);row.add(padding);row.add(content);
  }
  if (state.direct == MsgDirectionEnum.Out) {
    row.add(content);row.add(padding);row.add(avatar);
  }
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: state.direct == MsgDirectionEnum.In ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: row,
    ),
  );
}

class TextMessage extends StatelessWidget {

  final IMMessageState state;

  TextMessage(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Theme.of(context).primaryColor,),
      child: Text(state.content),
    );
  }

}

class StickerMessage extends StatelessWidget {

  final IMMessageState state;

  StickerMessage(this.state);

  @override
  Widget build(BuildContext context) {
    StickerAttachment stickerAttachment = (state.attachment as StickerAttachment);
    return Image.asset(StickerUtils.getStickerUri(stickerAttachment.catalog, stickerAttachment.chartlet), height: 88,);
  }

}