/// 用户资料接口（无论使用网易云信用户资料托管还是还是第三方自行管理用户资料，都要实现这个接口）
class UserInfo {
  /// 返回用户帐号
  ///
  /// @return 用户帐号
  String account;

  /// 返回用户名
  ///
  /// @return 用户名
  String name;

  /// 返回用户头像链接地址
  ///
  /// @return 头像URL、URI
  String avatar;

  UserInfo({account, name, avatar});

  UserInfo.fromJson(Map json):
        account = json['account'],
        name = json['name'],
        avatar = json['avatar'];
}