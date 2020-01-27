import 'CustomAttachment.dart';
import 'CustomAttachmentType.dart';

class StickerAttachment extends CustomAttachment {

  static const String KEY_CATALOG = "catalog";
  static const String KEY_CHARTLET = "chartlet";

  String catalog;
  String chartlet;

  StickerAttachment({this.catalog, this.chartlet}): super(CustomAttachmentType.Sticker);

//  StickerAttachment(String catalog, String emotion) {
//    this();

//    this.chartlet = FileUtil.getFileNameNoEx(emotion);
//  }

  @override
  void parseData(Map data) {
    this.catalog = data[KEY_CATALOG];
    this.chartlet = data[KEY_CHARTLET];
  }

  @override
  Map packData() {
    return {
      KEY_CATALOG: catalog,
      KEY_CHARTLET: chartlet,
    };
  }
}
