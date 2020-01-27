import 'FileAttachment.dart';

/// 音频消息附件
class AudioAttachment extends FileAttachment {

  /// 音频的播放时长
  num duration;
//
//  private static final String KEY_DURATION = "dur";
//
//  @Override
//  protected NimStorageType storageType() {
//    return NimStorageType.TYPE_AUDIO;
//  }
//
//  @Override
//  protected void save(JSONObject json) {
//    JSONHelper.put(json, KEY_DURATION, duration);
//  }
//
//  @Override
//  protected void load(JSONObject json) {
//    duration = JSONHelper.getInt(json, KEY_DURATION);
//  }

  AudioAttachment.fromJson(Map json): duration = json["duration"], super.fromJson(json);
}
