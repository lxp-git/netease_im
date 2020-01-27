import 'dart:core';

import 'FileAttachment.dart';

/// 图片类型附件
class ImageAttachment extends FileAttachment {
  /// 图片的宽度
  int width;

  /// 图片的高度
  int height;

  /// 获取缩略图 thumbUrl
  /// @return thumbUrl 缩略图 ，如果url 为空，返回null
//  public String getThumbUrl() {
//    return MsgHelper.getThumbUrl(this, getUrl());
//  }

//  public boolean isHdImage() {
//    return false;
//  }

//  @Override
//  protected NimStorageType storageType() {
//    return NimStorageType.TYPE_IMAGE;
//  }

//  private static final String KEY_WIDTH = "w";
//  private static final String KEY_HEIGHT = "h";

//  @Override
//  protected void save(JSONObject json) {
//    JSONHelper.put(json, KEY_WIDTH, width);
//    JSONHelper.put(json, KEY_HEIGHT, height);
//  }

//  @Override
//  protected void load(JSONObject json) {
//    width = JSONHelper.getInt(json, KEY_WIDTH);
//    height = JSONHelper.getInt(json, KEY_HEIGHT);
//  }
}
