import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'models/NimUserInfo.dart';
import 'models/index.dart';

/// 整体思路是：调用方案尽量和native保持一致，枚举统一toString在native解析
class NeteaseIM {
  factory NeteaseIM() {
    if (_instance == null) {
      _instance = NeteaseIM._private();
    }
    return _instance;
  }

  NeteaseIM._private() {
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
//    initSDK();
  }

  static NeteaseIM _instance;
  static MsgAttachmentParser msgAttachmentParser;

  static const MethodChannel _methodChannel = const MethodChannel('flutter.liuxuanping.com/netease_im');
  static final EventChannel _eventChannel = const EventChannel('flutter.liuxuanping.com/netease_im_event');

  StreamController<List<IMMessage>> _receiveMessageController =
  StreamController.broadcast();
  StreamController<List<IMMessage>> _localMessageController =
  StreamController.broadcast();
  StreamController<List<RecentContact>> _recentContactController =
  StreamController.broadcast();
  StreamController<RecentContact> _recentContactDeletedController =
  StreamController.broadcast();
  StreamController<IMMessage> _msgStatusController =
  StreamController.broadcast();
  StreamController<List<MessageReceipt>> _messageReceiptController =
  StreamController.broadcast();
  StreamController<AttachmentProgress> _attachmentProgressController =
  StreamController.broadcast();
  StreamController<CustomNotification> _customNotificationController =
  StreamController.broadcast();
  StreamController<RevokeMsgNotification> _revokeMsgNotificationController =
  StreamController.broadcast();
  StreamController<StatusCode> _onlineStatusController =
  StreamController.broadcast();
  StreamController<LoginSyncStatus> _loginSyncDataStatusController =
  StreamController.broadcast();
  StreamController<List<IMMessage>> _onNewIntentController =
  StreamController.broadcast();
  StreamController<Map> _audioRecorderController =
  StreamController.broadcast();
  StreamController<Map> _audioPlayerController =
  StreamController.broadcast();

  Stream<List<IMMessage>> get localMessageStream =>
      _localMessageController.stream;
  Stream<List<IMMessage>> get receiveMessageStream =>
      _receiveMessageController.stream;
  Stream<List<RecentContact>> get recentContactStream =>
      _recentContactController.stream;
  Stream<RecentContact> get recentContactDeletedStream =>
      _recentContactDeletedController.stream;
  Stream<StatusCode> get onlineStatusStream => _onlineStatusController.stream;
  Stream<LoginSyncStatus> get loginSyncDataStatusStream =>
      _loginSyncDataStatusController.stream;
  Stream<List<IMMessage>> get onNewIntentStream =>
      _onNewIntentController.stream;
  Stream<Map> get audioRecorderStream => _audioRecorderController.stream;
  Stream<Map> get audioPlayerStream => _audioPlayerController.stream;

  static Future<String> get platformVersion async {
    final String version = await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// IM 登录
  Future<bool> login(String account, String token) async {
    Map<String, String> map = {
      "account": account,
      "token": token,
    };

    final bool isLoginSuccess = await _methodChannel.invokeMethod("login", map);
    return isLoginSuccess;
  }

  /// IM 退出登录
  Future<void> logout() async {
    await _methodChannel.invokeMethod("logout");
  }

  /// 会话内发送音频消息
  Future<void> sendAudio(String audioPath) async {
    Map<String, String> map = {
      "audioPath": audioPath ?? "",
    };

    return await _methodChannel.invokeMethod("imSendAudio", map);
  }

  /// iOS 和 Android 均使用了 NIMSDK 中的录音功能
  /// 启动(开始)录音，如果成功，会按照顺序回调onRecordReady和onRecordStart
  /// @return 操作是否成功
  Future<bool> startRecord(RecordType recordType, int maxDuration) async {
    return await _methodChannel.invokeMethod("AudioRecorder#startRecord",
        {"recordType": recordType.toString(), "maxDuration": maxDuration});
  }

  /// 完成(结束)录音，根据参数cancel，做不同的回调。
  /// 如果cancel为true，回调onRecordCancel, 为false，回调onRecordSuccess
  ///
  /// @param cancel 是正常结束还是取消录音
  Future<void> completeRecord(bool cancel) async {
    return await _methodChannel.invokeMethod("AudioRecorder#completeRecord", {
      "cancel": cancel,
    });
  }

  /// 开始播放
  /// @param [audioStreamType] 设置播放音频流类型, 用于切换听筒/耳机播放 取值见[AudioSystem]来自android.media.AudioManager
  Future<void> audioPlayerStart(String filePath, int audioStreamType) async {
    return await _methodChannel.invokeMethod("AudioPlayer#start", {
      "filePath": filePath, "audioSystem": audioStreamType,
    });
  }

  /// 停止播放
  Future<void> audioPlayerStop() async {
    return await _methodChannel.invokeMethod("AudioPlayer#stop");
  }

  /// 标记音频已读
  Future<void> markAudioMessageRead(String messageId) async {
    Map<String, String> map = {
      "messageId": messageId,
    };

    await _methodChannel.invokeMethod("imMarkAudioMessageRead", map);
  }

  /// 删除一条消息记录
  /// @param message 待删除的消息记录
  Future deleteChattingHistory(IMMessage message) async {
    return await _methodChannel
        .invokeMethod('deleteChattingHistory', {"messageUuid": message.uuid});
  }

  Future getOneIMMessageByUuid({@required String uuid}) async {
    Map params = <String, dynamic>{'uuid': uuid};
    return await _methodChannel.invokeMethod('imGetOneIMMessageByUuid', params);
  }

  /// 清除与指定用户的所有消息记录
  /// @param account     用户帐号
  /// @param sessionType 聊天类型
  Future clearChattingHistory(
      String account, SessionTypeEnum sessionTypeEnum) async {
    return await _methodChannel.invokeMethod('clearChattingHistory', {
      "account": account,
      "sessionType": sessionTypeEnum.toString(),
    });
  }

  /// 把用户从黑名单中移除
  /// @param account 用户帐号
  /// @return InvocationFuture 可以设置回调函数。消息发送完成后才会调用，如果出错，会有具体的错误代码。
  Future<bool> removeFromBlackList(String account) async {
    bool isSuccess = await _methodChannel.invokeMethod('removeFromBlackList', {
      'account': account,
    });
    return isSuccess;
  }

  /// 判断用户是否已被拉黑
  /// [account] 用戶帐号
  /// @return 该用户是否在黑名单列表中
  Future<bool> isInBlackList(String account) async {
    bool inBlackList = await _methodChannel.invokeMethod('isInBlackList', {
      'account': account,
    });
    return inBlackList;
  }

  /// 添加用户到黑名单
  ///
  /// @param account 用户帐号
  /// @return InvocationFuture 可以设置回调函数。消息发送完成后才会调用，如果出错，会有具体的错误代码。
  Future<bool> addToBlackList(String account) async {
    bool isSuccess = await _methodChannel.invokeMethod('addToBlackList', {
      'account': account,
    });
    return isSuccess;
  }

  /// 播放
  Future<void> audioPlayStart(String path) async {
    Map<String, String> map = {
      "path": path,
    };
    return await _methodChannel.invokeMethod("imAudioPlayStart", map);
  }

  /// 停止播放
  Future<void> audioPlayStop() async {
    return await _methodChannel.invokeMethod("imAudioPlayStop");
  }

  /// 从服务器获取用户资料（每次最多获取150个用户，如果量大，上层请自行分批获取）
  /// @param accounts 要获取的用户帐号
  Future<List<NimUserInfo>> fetchUserInfo(String account) async {
    final nimUserInfoListJson = await _methodChannel
        .invokeMethod("fetchUserInfo", {"account": account});
    final nimUserInfoList = (nimUserInfoListJson as List)
        .map((nimUserInfo) => NimUserInfo.fromJson(nimUserInfo))
        .toList();
    return nimUserInfoList;
  }

  /// 根据锚点和方向从本地消息数据库中查询消息历史。
  /// 根据提供的方向(direct)，查询比anchor更老（QUERY_OLD）或更新（QUERY_NEW）的最靠近anchor的limit条数据。
  /// 调用者可使用asc参数指定结果排序规则，结果使用time作为排序字段。
  /// 注意：查询结果不包含锚点。
  ///
  /// @param messageUuid    查询锚点的消息id
  /// @param direction 查询方向
  /// @param limit     查询结果的条数限制
  /// @param asc       查询结果的排序规则，如果为true，结果按照时间升序排列，如果为false，按照时间降序排列
  /// @return 调用跟踪，可设置回调函数，接收查询结果
  Future<List<IMMessage>> queryMessageListEx(
      String sessionId,
      String messageUuid,
      QueryDirectionEnum queryDirectionEnum,
      int limit,
      bool asc) async {
    final imMessageListJson =
    await _methodChannel.invokeMethod("queryMessageListEx", {
      "sessionId": sessionId,
      "direction": queryDirectionEnum.toString(),
      "messageUuid": messageUuid,
      "limit": limit,
      "asc": asc
    });
    final imMessageList = (imMessageListJson as List)
        .map((imMessage) => IMMessage.fromJson(imMessage))
        .toList();
    return imMessageList;
  }

  /// 发送消息。<br>
  /// 如果需要更新发送进度，请调用{@link MsgServiceObserve#observeMsgStatus(com.netease.nimlib.sdk.Observer, boolean)}
  ///
  /// @param msg    带发送的消息体，由{@link MessageBuilder}构造
  /// @param resend 如果是发送失败后重发，标记为true，否则填false
  /// @return InvocationFuture 可以设置回调函数。消息发送完成后才会调用，如果出错，会有具体的错误代码。
  sendMessage(IMMessage imMessage, bool resend) async {
    _localMessageController.add([imMessage]);
    return await _methodChannel.invokeMethod(
        "sendMessage", {"messageUuid": imMessage.uuid, "resend": resend});
  }

  /// 查询最近联系人会话列表数据(同步版本)
  /// [limit]如果为0则返回所有
  Future<List<RecentContact>> queryRecentContactsBlock({int limit = 0}) async {
    final jsonMap = await _methodChannel
        .invokeMethod("queryRecentContactsBlock", {"limit": limit});
    return (jsonMap as List)
        .map((recentContact) => RecentContact.fromJson(recentContact))
        .toList();
  }

  Future<bool> toggleNotification(bool enable) async {
    bool isSuccess = await _methodChannel
        .invokeMethod("toggleNotification", {"enable": enable});
    return isSuccess;
  }

  /// 通过uuid批量获取IMMessage(同步版本)
  /// @param uuidList 消息的uuid列表
  Future<List<IMMessage>> queryMessageListByUuidBlock(
      List<String> uuidList) async {
    final json = await _methodChannel
        .invokeMethod("queryMessageListByUuidBlock", {"uuidList": uuidList});
    return (json as List)
        .map((imMessageMap) => IMMessage.fromJson(imMessageMap))
        .toList();
  }

  /// 设置当前正在聊天的对象。设置后会影响内建的消息提醒。如果有新消息到达，且消息来源是正在聊天的对象，将不会有消息提醒。<br>
  /// 调用该接口还会附带调用{@link #clearUnreadCount(String, SessionTypeEnum)},将正在聊天对象的未读数清零。
  ///
  /// @param account,    聊天对象帐号，或者以下两个值：<br>
  ///                    {@link #MSG_CHATTING_ACCOUNT_ALL}<br>
  ///                    {@link #MSG_CHATTING_ACCOUNT_NONE}
  /// @param sessionType 会话类型。如果account不是具体的对象，该参数将被忽略
  Future<bool> setChattingAccount(
      String account, SessionTypeEnum sessionType) async {
    bool isSuccess = await _methodChannel.invokeMethod("setChattingAccount",
        {"account": account, "sessionType": sessionType.toString()});
    return isSuccess;
  }

  /// 将指定最近联系人的未读数清零(标记已读)。<br>
  /// 调用该接口后，会触发{@link MsgServiceObserve#observeRecentContact(Observer, boolean)} 通知
  /// @param account     聊天对象帐号
  /// @param sessionType 会话类型
  Future clearUnreadCount(String account, SessionTypeEnum sessionType) async {
    return await _methodChannel.invokeMethod('clearUnreadCount',
        {'account': account, "sessionType": sessionType.toString()});
  }

  /// 删除最近联系人记录。<br>
  /// 调用该接口后，会触发{@link MsgServiceObserve#observeRecentContactDeleted(Observer, boolean)}通知
  Future deleteRecentContact2(
      String account, SessionTypeEnum sessionType) async {
    return await _methodChannel.invokeMethod('deleteRecentContact2',
        {'account': account, "sessionType": sessionType.toString()});
  }

  /// 获取当前用户状态
  Future<StatusCode> getStatus() async {
    String statusCodeString = await _methodChannel.invokeMethod('getStatus');
    return parseStatusCode(statusCodeString);
  }

  /// [初始化SDK方法二] 在UI进程主线程上按需使用的初始化SDK（不放在{@link Application#onCreate()}中初始化）
  /// 通过{@link SDKOptions#asyncInitSDK} 支持同步、异步初始化
  /// 通过{@link SDKOptions#reducedIM} 支持弱IM模式，延迟加载push进程服务
  /// 注意:一定要先在{@link Application#onCreate()}中调用 {@link NIMClient#config(Context, LoginInfo, SDKOptions)}
  Future<bool> initSDK() async {
    return await _methodChannel.invokeMethod('initSDK');
  }

  /// 更新消息记录的状态。可更新：<br>
  /// 消息状态 {@link IMMessage#getStatus()} 不为 null 时更新<br>
  /// 附件状态 {@link IMMessage#getAttachStatus()} 不为 null 时更新<br> TODO 暂不支持
  /// 附件内容 {@link IMMessage#getAttachment()} 不为 null 时更新       TODO 暂不支持
  ///
  /// @param message 待更新的消息记录
  Future<bool> updateIMMessageStatus(IMMessage message) async {
    if (message.uuid.isEmpty) {
      throw Exception("待更新的消息记录uuid是必须的");
    }
    return await _methodChannel.invokeMethod('updateIMMessageStatus', { "updatedIMMessage": message.toJson()});
  }

  void registerCustomAttachmentParser(MsgAttachmentParser msgAttachmentParser) {
    NeteaseIM.msgAttachmentParser = msgAttachmentParser;
  }

  void _onEvent(Object event) {
    if (event != null) {
      if (event is Map) {
        /// 新的交互方式：observeType表示注册观察者的方法名称，data为对应收到的数据，兼容以前的方案不删掉前面的代码
        switch (event["observeType"]) {
          case "receiveMessageObserver":
            List<IMMessage> iMMessageList = (event["data"] as List)
                .map((iMMessage) => IMMessage.fromJson(iMMessage))
                .toList();
            _receiveMessageController.add(iMMessageList);
            break;
          case "recentContactObserver":
            List<RecentContact> recentContactList = (event["data"] as List)
                .map((recentContact) => RecentContact.fromJson(recentContact))
                .toList();
            _recentContactController.add(recentContactList);
            break;
          case "recentContactDeletedObserver":
            RecentContact recentContact = RecentContact.fromJson(event["data"]);
            _recentContactDeletedController.add(recentContact);
            break;
          case "msgStatusObserver":
            IMMessage iMMessage = IMMessage.fromJson(event["data"]);
            _msgStatusController.add(iMMessage);
            break;
          case "messageReceiptObserver":
            List<MessageReceipt> messageReceiptList = (event["data"] as List)
                .map(
                    (messageReceipt) => MessageReceipt.fromJson(messageReceipt))
                .toList();
            _messageReceiptController.add(messageReceiptList);
            break;
          case "attachmentProgressObserver":
            AttachmentProgress attachmentProgress =
            AttachmentProgress.fromJson(event["data"]);
            _attachmentProgressController.add(attachmentProgress);
            break;
          case "customNotificationObserver":
            CustomNotification customNotification =
            CustomNotification.fromJson(event["data"]);
            _customNotificationController.add(customNotification);
            break;
          case "revokeMsgNotificationObserver":
            RevokeMsgNotification revokeMsgNotification =
            RevokeMsgNotification.fromJson(event["data"]);
            _revokeMsgNotificationController.add(revokeMsgNotification);
            break;
          case "onlineStatusObserver":
            StatusCode onlineStatus = parseStatusCode(event["data"]);
            _onlineStatusController.add(onlineStatus);
            break;
          case "loginSyncDataStatusObserver":
            LoginSyncStatus loginSyncStatus =
            parseLoginSyncStatus(event["data"]);
            _loginSyncDataStatusController.add(loginSyncStatus);
            break;
          case "onNewIntent":
            List<IMMessage> messageList = (event["data"] as List)
                .map((jsonMap) => IMMessage.fromJson(jsonMap))
                .toList();
            _onNewIntentController.add(messageList);
            break;
          case "AudioPlayer":
            _audioPlayerController.add(event["data"]);
            break;
          case "AudioRecorder":
            _audioRecorderController.add(event["data"]);
            break;
        }
      }
    }
  }

  // EventChannel 错误返回
  void _onError(Object error) {
    print("FlutterNIM - ${error.toString()}");
  }
}
