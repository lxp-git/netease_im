/// 附件传输状态枚举类
enum AttachStatusEnum {

  /// 默认状态，未开始
  def,

  /// 正在传输
  transferring,

  /// 传输成功
  transferred,

  /// 传输失败
  fail,

  /// 传输取消
  cancel,
}
