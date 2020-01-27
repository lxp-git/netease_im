/// 用户当前状态码定义
enum StatusCode {
  /// 未定义
  INVALID,

  /// 未登录/登录失败
  UNLOGIN,

  /// 网络连接已断开
  NET_BROKEN,

  /// 正在连接服务器
  CONNECTING,

  /// 正在登录中
  LOGINING,

  /// 正在同步数据
  SYNCING,

  /// 已成功登录
  LOGINED,

  /// 被其他端的登录踢掉
  KICKOUT,

  /// 被同时在线的其他端主动踢掉
  KICK_BY_OTHER_CLIENT,

  /// 被服务器禁止登录
  FORBIDDEN,

  /// 客户端版本错误
  VER_ERROR,

  /// 用户名或密码错误
  PWD_ERROR,

  /**
   * 判断处于当前状态码时，SDK还会不会继续自动重连登录。
   *
   * @return 如果返回true，SDK将停止自动登录，需要上层app显示调用login才能继续登录
   */
//public boolean wontAutoLogin() {
//  return this == KICKOUT || this == KICK_BY_OTHER_CLIENT || this == FORBIDDEN || this == PWD_ERROR;
//}

  /**
   * 判断处于当前状态码时，SDK还会不会继续自动重连登录，即使进程杀掉重启，也不会再做自动登录。
   * FORBIDDEN可能会被服务器解禁，PWD_ERROR可能在服务器有修复机制因此这里还是允许进程重启时自动登录。
   *
   * @return 如果返回true，SDK将停止自动登录，push调度重启也不再connect，需要上层app显示调用login才能继续登录
   */
//public boolean wontAutoLoginForever() {
//  return this == KICKOUT || this == KICK_BY_OTHER_CLIENT;
//}

//public boolean shouldReLogin() {
//  return this == UNLOGIN || this == NET_BROKEN;
//}

//private int value;
//
//StatusCode(int value) {
//  this.value = value;
//}
//
//public int getValue() {
//  return value;
//}
//
//public static StatusCode typeOfValue(int value) {
//  for (StatusCode c : values()) {
//  if (c.getValue() == value) {
//  return c;
//  }
//  }
//
//  return INVALID;
//}
//
//public static StatusCode statusOfResCode(int resCode) {
//  switch (resCode) {
//    case ResponseCode.RES_SUCCESS:
//      return StatusCode.LOGINED;
//    case ResponseCode.RES_FORBIDDEN:
//    case ResponseCode.RES_ACCOUNT_BLOCK:
//      return StatusCode.FORBIDDEN;
//    case ResponseCode.RES_VERSION_EXPIRED:
//      return StatusCode.VER_ERROR;
//    case ResponseCode.RES_ENONEXIST:
//    case ResponseCode.RES_EUIDPASS:
//    case ResponseCode.RES_EPARAM:
//      return StatusCode.PWD_ERROR;
//    case ResponseCode.RES_EEXIST:
//      return StatusCode.KICKOUT;
//    case ResponseCode.RES_DEVICE_NOT_TRUST:
//      return StatusCode.UNLOGIN;
//    default:
//      return StatusCode.UNLOGIN;
//  }
//}
}
