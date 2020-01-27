import 'package:flutter/services.dart';

import 'models/index.dart';

/// 云信IM消息构造器
class MessageBuilder {
  static final MethodChannel methodChannel =
      const MethodChannel("flutter.liuxuanping.com/netease_im");

  /// 创建一条普通文本消息
  ///
  /// @param sessionId   聊天对象ID
  /// @param sessionType 会话类型
  /// @param text        文本消息内容
  /// @return IMMessage 生成的消息对象
  static Future<IMMessage> createTextMessage(
      String sessionId, SessionTypeEnum sessionType, String text) async {
    final jsonMap = await methodChannel
        .invokeMapMethod("MessageBuilder#createTextMessage", {
      "sessionId": sessionId,
      "sessionType": sessionType.toString(),
      "text": text,
    });
    IMMessage iMMessage = IMMessage.fromJson(jsonMap);
    return iMMessage;
  }

  /**
   * 创建一条图片消息 并指定图片上传时使用的 nos scene
   *
   * @param sessionId        聊天对象ID
   * @param sessionType      会话类型
   * @param file             图片文件
   * @param displayName      图片文件的显示名，可不同于文件名
   * @param nosTokenSceneKey 图片上传时使用的 nos scene ，默认为 {@link NimNosSceneKeyConstant#NIM_DEFAULT_IM}
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createImageMessage(String sessionId, SessionTypeEnum sessionType, File file, String displayName, String nosTokenSceneKey) {
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.image.getValue());
//
//    final ImageAttachment attachment = new ImageAttachment();
//    attachment.setPath(file.getPath());
//    attachment.setSize(file.length());
//    int[] dimension = BitmapDecoder.decodeBound(file);
//    attachment.setWidth(dimension[0]);
//    attachment.setHeight(dimension[1]);
//    attachment.setDisplayName(displayName);
//    attachment.setExtension(StringUtil.getExtension(file.getName()));
//    attachment.setNosTokenSceneKey(nosTokenSceneKey);
//    msg.setAttachment(attachment);
//    return msg;
//  }

  /**
   * 创建一条音频消息
   *
   * @param sessionId   聊天对象ID
   * @param sessionType 会话类型
   * @param file        音频文件对象
   * @param duration    音频文件持续时间，单位是ms
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createAudioMessage(String sessionId, SessionTypeEnum sessionType, File file, long duration) {
//    return createAudioMessage(sessionId, sessionType, file, duration, NimNosSceneKeyConstant.NIM_DEFAULT_IM);
//  }

  /// 创建一条音频消息  并指定音频文件上传时使用的 nos scene
  ///
  /// @param sessionId        聊天对象ID
  /// @param sessionType      会话类型
  /// @param file             音频文件对象
  /// @param duration         音频文件持续时间，单位是ms
  /// @param nosTokenSceneKey 音频文件上传时使用的 nos scene ，默认为 {@link NimNosSceneKeyConstant#NIM_DEFAULT_IM}
  /// @return IMMessage 生成的消息对象
  static Future<IMMessage> createAudioMessage(String sessionId,
      SessionTypeEnum sessionType, String filePath, num duration,
      {String nosTokenSceneKey = NimNosSceneKeyConstant.NIM_DEFAULT_IM}) async {
    final iMMessageMap = await methodChannel
        .invokeMapMethod("MessageBuilder#createAudioMessage", {
      "sessionId": sessionId,
      "sessionType": sessionType.toString(),
      "filePath": filePath,
      "nosTokenSceneKey": nosTokenSceneKey,
      "duration": duration,
    });
    return IMMessage.fromJson(iMMessageMap);
  }

  /**
   * 创建一条地理位置信息
   *
   * @param sessionId   聊天对象ID
   * @param sessionType 会话类型
   * @param lat         纬度
   * @param lng         经度
   * @param addr        地理位置描述信息
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createLocationMessage(String sessionId, SessionTypeEnum sessionType, double lat, double lng, String addr) {
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.location.getValue());
//
//    final LocationAttachment location = new LocationAttachment();
//    location.setLatitude(lat);
//    location.setLongitude(lng);
//    location.setAddress(addr);
//    msg.setAttachStatus(AttachStatusEnum.transferred);
//    msg.setAttachment(location);
//
//    return msg;
//  }

  /**
   * 创建一条视频消息
   *
   * @param sessionId   聊天对象ID
   * @param sessionType 会话类型
   * @param file        视频文件对象
   * @param duration    视频文件持续时间
   * @param width       视频宽度
   * @param height      视频高度
   * @param displayName 视频文件显示名，可以为空
   * @return 视频消息
   */
//  static IMMessage createVideoMessage(String sessionId, SessionTypeEnum sessionType, File file, long duration, int width, int height, String displayName) {
//    return createVideoMessage(sessionId, sessionType, file, duration, width, height, displayName, NimNosSceneKeyConstant.NIM_DEFAULT_IM);
//  }

  /**
   * 创建一条视频消息 并指定 视频文件上传使用的 nos scene
   *
   * @param sessionId        聊天对象ID
   * @param sessionType      会话类型
   * @param file             视频文件对象
   * @param duration         视频文件持续时间
   * @param width            视频宽度
   * @param height           视频高度
   * @param displayName      视频文件显示名，可以为空
   * @param nosTokenSceneKey 视频文件上传时使用的 nos scene ，默认为 {@link NimNosSceneKeyConstant#NIM_DEFAULT_IM}
   * @return 视频消息
   */
//  static IMMessage createVideoMessage(String sessionId, SessionTypeEnum sessionType, File file, long duration, int width, int height, String displayName, String nosTokenSceneKey) {
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.video.getValue());
//
//    final VideoAttachment attachment = new VideoAttachment();
//    attachment.setPath(file.getPath());
//    attachment.setSize(file.length());
//    attachment.setDuration(duration);
//    attachment.setWidth(width);
//    attachment.setHeight(height);
//    attachment.setDisplayName(displayName);
//    attachment.setExtension(StringUtil.getExtension(file.getName()));
//    attachment.setNosTokenSceneKey(nosTokenSceneKey);
//    msg.setAttachment(attachment);
//
//    BitmapDecoder.extractThumbnail(file.getPath(), attachment.getThumbPathForSave());
//
//    return msg;
//  }

  /**
   * 创建一条文件消息
   *
   * @param sessionId   聊天对象ID
   * @param sessionType 会话类型
   * @param file        文件
   * @param displayName 文件的显示名，可不同于文件名
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createFileMessage(String sessionId, SessionTypeEnum sessionType, File file, String displayName) {
//    return createFileMessage(sessionId, sessionType, file, displayName, NimNosSceneKeyConstant.NIM_DEFAULT_IM);
//  }

  /**
   * 创建一条文件消息 并指定文件上传时使用的 nos scene
   *
   * @param sessionId        聊天对象ID
   * @param sessionType      会话类型
   * @param file             文件
   * @param displayName      文件的显示名，可不同于文件名
   * @param nosTokenSceneKey 文件上传时使用的 nos scene ，默认为 {@link NimNosSceneKeyConstant#NIM_DEFAULT_IM}
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createFileMessage(String sessionId, SessionTypeEnum sessionType, File file, String displayName, String nosTokenSceneKey) {
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.file.getValue());
//
//    final FileAttachment attachment = new FileAttachment();
//    attachment.setPath(file.getPath());
//    attachment.setSize(file.length());
//    attachment.setDisplayName(displayName);
//    attachment.setExtension(StringUtil.getExtension(file.getName()));
//    attachment.setNosTokenSceneKey(nosTokenSceneKey);
//    msg.setAttachment(attachment);
//    return msg;
//  }

  /**
   * 创建一条提醒消息
   *
   * @param sessionId   聊天对象ID
   * @param sessionType 会话类型
   * @return IMMessage 生成的消息对象
   */
//  static IMMessage createTipMessage(String sessionId, SessionTypeEnum sessionType) {
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.tip.getValue());
//
//    return msg;
//  }

  /// 创建一条APP自定义类型消息, 同时提供描述字段，可用于推送以及状态栏消息提醒的展示。另外指定文件上传（如果有）时使用的 nos scene
  ///
  /// @param sessionId        聊天对象ID
  /// @param sessionType      会话类型
  /// @param content          消息简要描述，可通过IMMessage#getContent()获取，主要用于用户推送展示。
  /// @param attachment       消息附件对象
  /// @param config           自定义消息配置
  /// @param nosTokenSceneKey 文件上传（如果有）时使用的 nos scene
  /// @return 自定义消息
  static Future<IMMessage> createCustomMessage(
      String sessionId, SessionTypeEnum sessionType, MsgAttachment attachment,
      {String content,
      CustomMessageConfig config,
      String nosTokenSceneKey = NimNosSceneKeyConstant.NIM_DEFAULT_IM}) async {
    final Map<String, dynamic> params = {
      "sessionId": sessionId,
      "sessionType": sessionType.toString(),
      "content": content,
      "nosTokenSceneKey": nosTokenSceneKey,
      "content": content,
    };
    if (attachment != null) {
      if (attachment is FileAttachment) {
        attachment.nosTokenSceneKey = nosTokenSceneKey;
      }
      params["attachment"] = attachment.toJson(false);
    }
    if (config != null) {
      params["config"] = config.toJson();
    }
    final jsonMap = await methodChannel.invokeMapMethod(
        "MessageBuilder#createCustomMessage", params);
    return IMMessage.fromJson(jsonMap);
  }

/**
 * @param sessionId    聊天对象ID
 * @param sessionType  会话类型
 * @param robotAccount 机器人账号
 * @param text         消息显示的文案，一般基于content加上@机器人的标签作为消息显示的文案。
 * @param type         机器人消息类型，参考{@link com.netease.nimlib.sdk.robot.model.RobotMsgType}
 * @param content      消息内容，如果消息类型是{@link com.netease.nimlib.sdk.robot.model.RobotMsgType#TEXT}，必须传入说话内容
 * @param target       如果消息类型是{@link com.netease.nimlib.sdk.robot.model.RobotMsgType#LINK}, 必须传入跳转目标
 * @param params       如果消息类型是{@link com.netease.nimlib.sdk.robot.model.RobotMsgType#LINK}时，可能需要传入参数
 * @return 机器人消息
 */
//  static IMMessage createRobotMessage(String sessionId, SessionTypeEnum sessionType, String robotAccount, String text, String type, String content, String target, String params) {
//    if (TextUtils.isEmpty(type) || TextUtils.isEmpty(robotAccount)) {
//      throw new IllegalArgumentException("Invalid param, type and robot account should not be null");
//    }
//
//    if (type.equals(RobotMsgType.TEXT) && content == null) {
//      throw new IllegalArgumentException("Invalid param, content should not be null");
//    } else if (type.equals(RobotMsgType.LINK) && TextUtils.isEmpty(target)) {
//      throw new IllegalArgumentException("Invalid param, target should not be null");
//    }
//
//    IMMessageImpl msg = initSendMessage(sessionId, sessionType);
//    msg.setMsgType(MsgTypeEnum.robot.getValue());
//
//    // build attachment
//    RobotAttachment robotAttachment = new RobotAttachment();
//    robotAttachment.initSend(robotAccount, type, content, target, params);
//    msg.setAttachment(robotAttachment);
//    msg.setContent(text); // 文案显示用,便于全文检索等
//
//    return msg;
//  }

/**
 * 创建一条空消息，仅设置了聊天对象以及时间点，用于记录查询
 *
 * @param sessionId   聊天对象ID
 * @param sessionType 会话类型
 * @param time        查询的时间起点信息
 * @return 空消息
 */
//  static IMMessage createEmptyMessage(String sessionId, SessionTypeEnum sessionType, long time) {
//    IMMessageImpl msg = new IMMessageImpl();
//    msg.setSessionId(sessionId);
//    msg.setSessionType(sessionType);
//    msg.setTime(time);
//    return msg;
//  }

/**
 * 创建一条待转发的消息
 *
 * @param message     要转发的消息
 * @param sessionId   聊天对象ID
 * @param sessionType 会话类型
 * @return 待转发的消息
 */
//  static IMMessage createForwardMessage(IMMessage message, String sessionId, SessionTypeEnum sessionType) {
//    if (message.getMsgType() == MsgTypeEnum.notification || message.getMsgType() == MsgTypeEnum.avchat || message.getMsgType() == MsgTypeEnum.robot) {
//      return null;
//    }
//    IMMessageImpl forward = ((IMMessageImpl) message).deepClone();
//    if (forward != null) {
//      forward.setSessionId(sessionId);
//      forward.setSessionType(sessionType);
//      forward.setUuid(StringUtil.get32UUID());
//      forward.setFromAccount(SDKCache.getAccount());
//      forward.setDirect(MsgDirectionEnum.Out);
//      forward.setStatus(MsgStatusEnum.sending);
//      forward.setTime(TimeUtil.currentTimeMillis());
//      forward.setServerId(0L);
//      forward.setMessageId(0L);
//      // clear team msg ack
//      forward.setMsgAck(false);
//      forward.setHasSendAck(false);
//      forward.setTeamMsgAckCount(0);
//      forward.setTeamMsgUnAckCount(0);
//
//      // 接收到消息，但是附件没有下载成功的情况。不会再次上传附件，所以要将附件的发送状态直接改为def
//      final MsgAttachment attachment = forward.getAttachment();
//      if (attachment != null && attachment instanceof FileAttachment) {
//        final FileAttachment media = (FileAttachment) attachment;
//        if (!TextUtils.isEmpty(media.getUrl())) {
//          forward.setAttachStatus(AttachStatusEnum.def);
//        }
//      }
//    }
//
//    return forward;
//  }

//  private static IMMessageImpl initSendMessage(String toId, SessionTypeEnum sessionType) {
//    IMMessageImpl msg = new IMMessageImpl();
//
//    msg.setUuid(StringUtil.get32UUID());
//    msg.setSessionId(toId);
//    msg.setFromAccount(SDKCache.getAccount());
//    msg.setDirect(MsgDirectionEnum.Out);
//    msg.setStatus(MsgStatusEnum.sending);
//    msg.setSessionType(sessionType);
//    msg.setTime(TimeUtil.currentTimeMillis());
//
//    return msg;
//  }
}
