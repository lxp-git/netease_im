import 'AttachStatusEnum.dart';
import 'LoginSyncStatus.dart';
import 'MsgDirectionEnum.dart';
import 'MsgStatusEnum.dart';
import 'MsgTypeEnum.dart';
import 'SessionTypeEnum.dart';
import 'StatusCode.dart';
import './attachment/index.dart';
import '../netease_im.dart';

export 'MsgDirectionEnum.dart';
export 'MsgStatusEnum.dart';
export 'MsgTypeEnum.dart';
export 'SessionTypeEnum.dart';
export 'attachment/AudioAttachment.dart';
export 'attachment/MsgAttachment.dart';
export 'RecentContact.dart';
export 'IMMessage.dart';
export 'MessageReceipt.dart';
export 'AttachmentProgress.dart';
export 'CustomNotification.dart';
export 'RevokeMsgNotification.dart';
export 'QueryDirectionEnum.dart';
export 'CustomMessageConfig.dart';
export 'NimNosSceneKeyConstant.dart';
export './attachment/index.dart';
export 'MsgService.dart';
export 'LoginSyncStatus.dart';
export 'StatusCode.dart';
export 'RecordType.dart';
export 'AudioSystem.dart';
export 'AttachStatusEnum.dart';
export 'MsgAttachmentParser.dart';

MsgTypeEnum parseMsgType(msgTypeString) {
  MsgTypeEnum msgType;
  switch(msgTypeString){
    case "MsgTypeEnum.undef":
      msgType = MsgTypeEnum.undef;
      break;
    case "MsgTypeEnum.text":
      msgType = MsgTypeEnum.text;
      break;
    case "MsgTypeEnum.image":
      msgType = MsgTypeEnum.image;
      break;
    case "MsgTypeEnum.audio":
      msgType = MsgTypeEnum.audio;
      break;
    case "MsgTypeEnum.location":
      msgType = MsgTypeEnum.location;
      break;
    case "MsgTypeEnum.avchat":
      msgType = MsgTypeEnum.avchat;
      break;
    case "MsgTypeEnum.notification":
      msgType = MsgTypeEnum.notification;
      break;
    case "MsgTypeEnum.tip":
      msgType = MsgTypeEnum.tip;
      break;
    case "MsgTypeEnum.robot":
      msgType = MsgTypeEnum.robot;
      break;
    case "MsgTypeEnum.custom":
      msgType = MsgTypeEnum.custom;
      break;
  }
  return msgType;
}

MsgStatusEnum parseMsgStatus(statusString) {
  MsgStatusEnum status;
  switch(statusString){
    case "MsgStatusEnum.draft":
      status = MsgStatusEnum.draft;
      break;
    case "MsgStatusEnum.sending":
      status = MsgStatusEnum.sending;
      break;
    case "MsgStatusEnum.success":
      status = MsgStatusEnum.success;
      break;
    case "MsgStatusEnum.fail":
      status = MsgStatusEnum.fail;
      break;
    case "MsgStatusEnum.read":
      status = MsgStatusEnum.read;
      break;
    case "MsgStatusEnum.unread":
      status = MsgStatusEnum.unread;
      break;
  }
  return status;
}

AttachStatusEnum parseAttachStatus(statusString) {
  AttachStatusEnum status;
  switch(statusString){
    case "AttachStatusEnum.def":
      status = AttachStatusEnum.def;
      break;
    case "AttachStatusEnum.transferring":
      status = AttachStatusEnum.transferring;
      break;
    case "AttachStatusEnum.transferred":
      status = AttachStatusEnum.transferred;
      break;
    case "AttachStatusEnum.fail":
      status = AttachStatusEnum.fail;
      break;
    case "AttachStatusEnum.cancel":
      status = AttachStatusEnum.cancel;
      break;
  }
  return status;
}

MsgDirectionEnum parseMsgDirection(directString) {
  MsgDirectionEnum direct;
  switch(directString){
    case "MsgDirectionEnum.Out":
      direct = MsgDirectionEnum.Out;
      break;
    case "MsgDirectionEnum.In":
      direct = MsgDirectionEnum.In;
      break;
  }
  return direct;
}

SessionTypeEnum parseSessionType(sessionTypeString) {
  SessionTypeEnum sessionType;
  switch(sessionTypeString){
    case "SessionTypeEnum.None":
      sessionType = SessionTypeEnum.None;
      break;
    case "MsgDirectionEnum.P2P":
      sessionType = SessionTypeEnum.P2P;
      break;
    case "MsgDirectionEnum.Team":
      sessionType = SessionTypeEnum.Team;
      break;
    case "MsgDirectionEnum.SUPER_TEAM":
      sessionType = SessionTypeEnum.SUPER_TEAM;
      break;
    case "MsgDirectionEnum.System":
      sessionType = SessionTypeEnum.System;
      break;
    case "MsgDirectionEnum.ChatRoom":
      sessionType = SessionTypeEnum.ChatRoom;
      break;
  }
  return sessionType;
}

MsgAttachment parseAttachment(MsgTypeEnum msgType, attachmentMap) {
  MsgAttachment attachment;
  if (attachmentMap == null) {
    return attachment;
  }
  switch(msgType) {
    case MsgTypeEnum.audio:
      attachment = AudioAttachment.fromJson(attachmentMap);
      break;
    case MsgTypeEnum.custom:
      attachment = NeteaseIM.msgAttachmentParser.parse(attachmentMap as String);
      break;
    case MsgTypeEnum.text:
    /// 么得附件

      break;
    default:
      throw Exception("尚未实现的消息类型转换:$msgType");
  }
  return attachment;
}

StatusCode parseStatusCode(String statusCode) {
  StatusCode statusCodeEnum;
  switch(statusCode) {
    case "StatusCode.INVALID":
      statusCodeEnum = StatusCode.INVALID;
      break;
    case "StatusCode.UNLOGIN":
      statusCodeEnum = StatusCode.UNLOGIN;
      break;
    case "StatusCode.NET_BROKEN":
      statusCodeEnum = StatusCode.NET_BROKEN;
      break;
    case "StatusCode.LOGINING":
      statusCodeEnum = StatusCode.LOGINING;
      break;
    case "StatusCode.CONNECTING":
      statusCodeEnum = StatusCode.CONNECTING;
      break;
    case "StatusCode.SYNCING":
      statusCodeEnum = StatusCode.SYNCING;
      break;
    case "StatusCode.LOGINED":
      statusCodeEnum = StatusCode.LOGINED;
      break;
    case "StatusCode.KICKOUT":
      statusCodeEnum = StatusCode.KICKOUT;
      break;
    case "StatusCode.KICK_BY_OTHER_CLIENT":
      statusCodeEnum = StatusCode.KICK_BY_OTHER_CLIENT;
      break;
    case "StatusCode.FORBIDDEN":
      statusCodeEnum = StatusCode.FORBIDDEN;
      break;
    case "StatusCode.VER_ERROR":
      statusCodeEnum = StatusCode.VER_ERROR;
      break;
    case "StatusCode.PWD_ERROR":
      statusCodeEnum = StatusCode.PWD_ERROR;
      break;
    default:
      throw Exception("parseStatusCode尚未实现的消息类型转换:$statusCode");
  }
  return statusCodeEnum;
}

LoginSyncStatus parseLoginSyncStatus(String loginSyncStatus) {
  LoginSyncStatus loginSyncStatusEnum;
  switch(loginSyncStatus) {
    case "LoginSyncStatus.NO_BEGIN":
      loginSyncStatusEnum = LoginSyncStatus.NO_BEGIN;
      break;
    case "LoginSyncStatus.BEGIN_SYNC":
      loginSyncStatusEnum = LoginSyncStatus.BEGIN_SYNC;
      break;
    case "LoginSyncStatus.SYNC_COMPLETED":
      loginSyncStatusEnum = LoginSyncStatus.SYNC_COMPLETED;
      break;
    default:
      throw Exception("parseLoginSyncStatus尚未实现的消息类型转换:$loginSyncStatus");
  }
  return loginSyncStatusEnum;
}