import 'dart:core';

import 'package:netease_im/models/UserInfo.dart';

import 'GenderEnum.dart';

/// 用户资料（网易云信提供的用户资料托管使用）
class NimUserInfo extends UserInfo {
  /// 用户签名
  String signature;

  /// 用户性别int值（第三方可以自定义）
  GenderEnum genderEnum;

  /// 用户邮箱地址
  String email;

  /// 格式"yyyy-MM-dd"
  String birthday;

  /// 用户手机号码
  String mobile;

  /// 扩展字段（第三方自定义属性，可以组成JSON）8
  String extension;

  /// 获取扩展字段，返回Map格式
  Map<String, Object> extensionMap;

  NimUserInfo({signature, genderEnum, email, birthday, mobile, extension, extensionMap, account, name, avatar})
      :super(account: account, name: name, avatar: avatar);

  NimUserInfo.fromJson(Map<dynamic, dynamic> json): super.fromJson(json){
    signature = json["signature"];
    if (json["genderEnum"] != null) {
      genderEnum = GenderEnum.values.elementAt(json["genderEnum"]);
    }
    email = json["email"];
    birthday = json["birthday"];
    mobile = json["mobile"];
    extension = json["extension"];
    extensionMap = json["extensionMap"];
  }
}
