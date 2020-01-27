//import 'package:fish_redux/fish_redux.dart';
//import 'package:flutter_module/model/attachment/StickerAttachment.dart';
//import 'package:flutter_module/page/session_page/text_component/state.dart';
//
//class StickerState extends StickerAttachment implements Cloneable<StickerState> {
//
//  @override
//  StickerState clone() {
//    return StickerState();
//  }
//}
//
//StickerState initState(Map<String, dynamic> args) {
//  return StickerState();
//}
//
//class StickerConnector extends ConnOp<IMMessageState, StickerState>
//    with ReselectMixin<IMMessageState, StickerState> {
//  @override
//  StickerState computed(IMMessageState state) {
//    final attachment = state.attachment;
//    if (attachment is StickerAttachment) {
//      return StickerState()
//      ..catalog = attachment.catalog
//        ..chartlet = attachment.chartlet;
//    }
//    return null;
//  }
//
//  @override
//  List<dynamic> factors(IMMessageState state) {
//    final attachment = state.attachment;
//    if (attachment is StickerAttachment) {
//      return <String>[
//        attachment.catalog,
//        attachment.chartlet,
//      ];
//    }
//    return [];
//  }
//
//  @override
//  void set(IMMessageState state, StickerState subState) {
//    throw Exception('Unexcepted to set PageState from ReportState');
//  }
//}