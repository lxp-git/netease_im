import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/model/attachment/StickerAttachment.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';


Widget buildView(IMMessageState state, Dispatch dispatch, ViewService viewService) {
  return CachedNetworkImage(imageUrl: (state.attachment as StickerAttachment).chartlet);
}
