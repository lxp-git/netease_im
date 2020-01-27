import 'dart:core';

import '../NimNosSceneKeyConstant.dart';
import 'MsgAttachment.dart';

/// 带有文件的附件类型的基类
/// 描述文件的相关信息
class FileAttachment extends MsgAttachment {
  FileAttachment();
  /// 获取文件本地路径，若文件不存在，返回null
  String path;

  /// 获取文件大小，单位为byte
  num size;

  /// 文件内容的MD5
  String md5;

  /// 获取文件在服务器上的下载url。若文件还未上传，返回null
  String url;

  /// 获取文件的显示名。可以和文件名不同，仅用于界面展示
  String displayName;

  /// 文件后缀名
  String extension;

  /// 上传文件时用的对token对应的场景，默认{@link NimNosSceneKeyConstant#NIM_DEFAULT_IM}
  String nosTokenSceneKey = NimNosSceneKeyConstant.NIM_DEFAULT_IM;

  /// 如果服务器存在相同的附件文件，是否强制重新上传 ， 默认false
  bool isForceUpload = false;

  /// 获取缩略图文件的本地路径，若文件不存在，返回null
  String thumbPath;

  /// 获取用于保存缩略图文件的位置
  String thumbPathForSave;

  /// 获取文件名。
  String fileName;

//  NimStorageType storageType() {
//    return NimStorageType.TYPE_FILE;
//  }

//  void save(JSONObject json) {
//
//  }
//
//  void load(JSONObject json) {
//
//  }

  static const String KEY_PATH = "path";
  static const String KEY_NAME = "name";
  static const String KEY_SIZE = "size";
  static const String KEY_MD5 = "md5";
  static const String KEY_URL = "url";
  static const String KEY_EXT = "ext";
  static const String KEY_SCENE = "sen";
  static const String KEY_FORCE_UPLOAD = "force_upload";
//
//  String toJson(boolean send) {
//    JSONObject object = new JSONObject();
//    try {
//      if (!send && !TextUtils.isEmpty(path)) {
//        object.put(KEY_PATH, path);
//      }
//
//      if (!TextUtils.isEmpty(md5)) {
//        object.put(KEY_MD5, md5);
//      }
//
//      if (!TextUtils.isEmpty(displayName)) {
//        object.put(KEY_NAME, displayName);
//      }
//
//      object.put(KEY_URL, url);
//      object.put(KEY_SIZE, size);
//
//
//      if (!TextUtils.isEmpty(extension)) {
//        object.put(KEY_EXT, extension);
//      }
//      if (!TextUtils.isEmpty(nosTokenSceneKey)) {
//        object.put(KEY_SCENE, nosTokenSceneKey);
//      }
//
//      object.put(KEY_FORCE_UPLOAD, forceUpload);
//      save(object);
//
//    } catch (Exception e) {
//    e.printStackTrace();
//    }
//
//    return object.toString();
//  }

//  FileAttachment.fromJson(String attach) {
//    JSONObject json = JSONHelper.parse(attach);
//    path = JSONHelper.getString(json, KEY_PATH);
//    md5 = JSONHelper.getString(json, KEY_MD5);
//    url = JSONHelper.getString(json, KEY_URL);
//    displayName = JSONHelper.getString(json, KEY_NAME);
//    size = JSONHelper.getLong(json, KEY_SIZE);
//    extension = JSONHelper.getString(json, KEY_EXT);
//    setNosTokenSceneKey(JSONHelper.getString(json, KEY_SCENE));
//    forceUpload = JSONHelper.getBoolean(json, KEY_FORCE_UPLOAD);
//    load(json);
//  }
  FileAttachment.fromJson(Map json) {
    path = json["path"];
    size = json["size"];
    md5 = json["md5"];
    url = json["url"];
    displayName = json["displayName"];
    extension = json['extension'];
    nosTokenSceneKey = json['nosTokenSceneKey'];
    isForceUpload = json['isForceUpload'];
    thumbPath = json['thumbPath'];
    thumbPathForSave = json['thumbPathForSave'];
    fileName = json['fileName'];
  }

  @override
  Map<String, Object> toJson(bool send) {
    // TODO: implement toJson
    return null;
  }
}
