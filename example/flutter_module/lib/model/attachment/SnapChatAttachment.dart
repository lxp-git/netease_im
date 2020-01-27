import 'package:netease_im/models/attachment/FileAttachment.dart';

class SnapChatAttachment extends FileAttachment {

  static const String KEY_PATH = "path";
  static const String KEY_SIZE = "size";
  static const String KEY_MD5 = "md5";
  static const String KEY_URL = "url";

  SnapChatAttachment(Map data) {
    load(data);
  }

  @override
  Map<String, Object> toJson(bool send) {
//    JSONObject data = new JSONObject();
//    try {
//      if (!send && !TextUtils.isEmpty(path)) {
//        data.put(KEY_PATH, path);
//      }
//
//      if (!TextUtils.isEmpty(md5)) {
//        data.put(KEY_MD5, md5);
//      }
//
//      data.put(KEY_URL, url);
//      data.put(KEY_SIZE, size);
//    } catch (Exception e) {
//    e.printStackTrace();
//    }
//
//    return CustomAttachParser.packData(CustomAttachmentType.SnapChat, data);
    return {};
  }

  void load(Map data) {
//    path = data.getString(KEY_PATH);
//    md5 = data.getString(KEY_MD5);
//    url = data.getString(KEY_URL);
//    size = data.containsKey(KEY_SIZE) ? data.getLong(KEY_SIZE) : 0;
  }
}
