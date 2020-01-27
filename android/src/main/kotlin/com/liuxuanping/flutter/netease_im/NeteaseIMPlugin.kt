package com.liuxuanping.flutter.netease_im

import Converter
import NIMCustomAttachParser
import NIMCustomAttachment
import NIMSharePreferences
import android.content.Context
import android.content.Intent
import android.util.Log
import com.netease.nimlib.sdk.*
import com.netease.nimlib.sdk.auth.AuthService
import com.netease.nimlib.sdk.auth.AuthServiceObserver
import com.netease.nimlib.sdk.auth.LoginInfo
import com.netease.nimlib.sdk.auth.constant.LoginSyncStatus
import com.netease.nimlib.sdk.friend.FriendService
import com.netease.nimlib.sdk.media.player.AudioPlayer
import com.netease.nimlib.sdk.media.player.OnPlayListener
import com.netease.nimlib.sdk.media.record.AudioRecorder
import com.netease.nimlib.sdk.media.record.IAudioRecordCallback
import com.netease.nimlib.sdk.media.record.RecordType
import com.netease.nimlib.sdk.msg.MessageBuilder
import com.netease.nimlib.sdk.msg.MsgService
import com.netease.nimlib.sdk.msg.MsgServiceObserve
import com.netease.nimlib.sdk.msg.constant.SessionTypeEnum
import com.netease.nimlib.sdk.msg.model.*
import com.netease.nimlib.sdk.uinfo.UserService
import com.netease.nimlib.sdk.uinfo.model.NimUserInfo
import com.netease.nimlib.sdk.util.NIMUtil
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.File

class NeteaseIMPlugin() : FlutterPlugin, MethodCallHandler, PluginRegistry.NewIntentListener, EventChannel.StreamHandler {
  companion object {
    private val METHOD_CHANNEL_NAME = "flutter.liuxuanping.com/netease_im"
    private val EVENT_CHANNEL_NAME = "flutter.liuxuanping.com/netease_im_event"

    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val instance = NeteaseIMPlugin()
      registrar.addNewIntentListener(instance)
      instance.onAttachedToEngine(registrar.context(), registrar.messenger())
    }
  }

  private fun onAttachedToEngine(context: Context, binaryMessenger: BinaryMessenger) {
    val channel = MethodChannel(binaryMessenger, METHOD_CHANNEL_NAME)
    val eventChannel = EventChannel(binaryMessenger, EVENT_CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    eventChannel.setStreamHandler(this)
  }

  private val localMessageMap = HashMap<String, IMMessage>()
  private var applicationContext: Context? = null
  private var eventSink: EventChannel.EventSink? = null
  private var player: AudioPlayer? = null
  private var audioRecorder: AudioRecorder? = null

  override fun onMethodCall(methodCall: MethodCall, result: Result) {
    when (methodCall.method) {
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "initSDK" -> {
        if (NIMUtil.isMainProcess(applicationContext)) {
          NIMClient.initSDK()
          NIMClient.getService(MsgService::class.java).registerCustomAttachmentParser(NIMCustomAttachParser())
          registerAllObserver()
        }
        result.success(true)
      }
      "login" -> {
        val account = methodCall.argument<String>("account")
        val token = methodCall.argument<String>("token")
        val imAccount = account!!.toLowerCase()
        val imToken = token!!.toLowerCase()
        val info = LoginInfo(imAccount, imToken)
        val callback = object : RequestCallback<LoginInfo> {
          override fun onSuccess(param: LoginInfo?) {
            if (param !== null) {
              NIMSharePreferences.saveLoginInfo(applicationContext, param)
              result.success(true)
            } else {
              result.success(false)
            }
//                        result.error("302", "login onFailed code:302", null)
          }

          override fun onFailed(code: Int) {
            Log.e("FlutterNIM", "im login failure$code")
            result.error("$code", "login onFailed code:$code", null)
          }

          override fun onException(exception: Throwable) {
            exception.printStackTrace()
            Log.e("FlutterNIM", "im login error")
            result.success(false)
          }
        }
        NIMClient.getService(AuthService::class.java).login(info).setCallback(callback)
      }
      "logout" -> {
        NIMClient.getService(AuthService::class.java).logout()
        NIMSharePreferences.clear(applicationContext)
      }
      "deleteChattingHistory" -> {
        val messageUuid = methodCall.argument<String>("messageUuid")
        val iMMessage = queryMessageListByUuidBlock(listOf(messageUuid!!))[0]
        NIMClient.getService(MsgService::class.java).deleteChattingHistory(iMMessage)
        result.success(true)
      }
      "removeFromBlackList" -> {
        val account = methodCall.argument<String>("account")
        NIMClient.getService(FriendService::class.java).removeFromBlackList(account).setCallback(object : RequestCallback<Void> {
          override fun onSuccess(aVoid: Void?) {
            result.success(true)
          }

          override fun onFailed(i: Int) {
            result.error(i.toString() + "", "", null)
          }

          override fun onException(throwable: Throwable) {
            result.error("onException", throwable.message, null)
          }
        })
      }
      "addToBlackList" -> {
        val account = methodCall.argument<String>("account")
        NIMClient.getService(FriendService::class.java).addToBlackList(account).setCallback(object : RequestCallback<Void> {
          override fun onSuccess(aVoid: Void?) {
            result.success(true)
          }

          override fun onFailed(i: Int) {
            result.error(i.toString() + "", "", null)
          }

          override fun onException(throwable: Throwable) {
            result.error("onException", throwable.message, null)
          }
        })
      }
      "isInBlackList" -> {
        val account = methodCall.argument<String>("account")
        result.success(NIMClient.getService(FriendService::class.java).isInBlackList(account))
      }
      "clearChattingHistory" -> {
        val account = methodCall.argument<String>("account")
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        NIMClient.getService(MsgService::class.java).clearChattingHistory(account, sessionTypeEnum)
        result.success(true)
      }
      "updateIMMessageStatus" -> { // TODO 暂时只支持消息状态
        val updatedIMMessage = methodCall.argument<Map<String, Any>>("updatedIMMessage")
        val uuid = updatedIMMessage!!["uuid"] as String
        val iMMessage = queryMessageListByUuidBlock(listOf(uuid))[0]
        if (updatedIMMessage["status"] != null) {
          iMMessage.status = Converter.parseMsgStatusEnum(updatedIMMessage["status"] as String)
        }
//                if (updatedIMMessage["attachStatus"] != null) {
//                    iMMessage.status = Converter.parseMsgStatusEnum(updatedIMMessage["attachStatus"] as String)
//                }
//                if (updatedIMMessage["attachment"] != null) {
//                    iMMessage.status = Converter.parseMsgStatusEnum(updatedIMMessage["attachment"] as String)
//                }
        NIMClient.getService(MsgService::class.java).updateIMMessageStatus(iMMessage)
        result.success(true)
      }
      "AudioRecorder#startRecord" -> {
        val recordType = methodCall.argument<String>("recordType")
        val recordTypeEnum = Converter.toRecordTypeEnum(recordType)
        val maxDuration = methodCall.argument<Int>("maxDuration")!!
        if (audioRecorder == null) {
          audioRecorder = AudioRecorder(applicationContext, recordTypeEnum, maxDuration, object : IAudioRecordCallback {
            override fun onRecordReady() {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordReady"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }

            override fun onRecordStart(audioFile: File, recordType: RecordType) {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordStart"
              dataMap["audioFilePath"] = audioFile.path
              dataMap["recordType"] = "RecordType.$recordType"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }

            override fun onRecordSuccess(audioFile: File, audioLength: Long, recordType: RecordType) {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordSuccess"
              dataMap["audioFilePath"] = audioFile.path
              dataMap["audioLength"] = audioLength
              dataMap["recordType"] = "RecordType.$recordType"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }

            override fun onRecordFail() {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordFail"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }

            override fun onRecordCancel() {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordCancel"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }

            override fun onRecordReachedMaxTime(maxTime: Int) {
              val objectMap = HashMap<String, Any>()
              objectMap["observeType"] = "AudioRecorder"
              val dataMap = HashMap<String, Any>()
              dataMap["IAudioRecordCallback"] = "onRecordReachedMaxTime"
              dataMap["maxTime"] = "maxTime"
              objectMap["data"] = dataMap
              eventSink?.success(objectMap)
            }
          })
        }
        audioRecorder!!.startRecord()
        result.success(true)
      }
      "AudioRecorder#completeRecord" -> {
        val cancel = methodCall.argument<Boolean>("cancel")!!
        audioRecorder!!.completeRecord(cancel)
        result.success(true)
      }
      "AudioPlayer#stop" -> {
        this.player?.stop()
        result.success(true)
      }
      "AudioPlayer#start" -> {
        val filePath = methodCall.argument<String>("filePath")
        val audioSystem = methodCall.argument<Int>("audioSystem")!!
        this.player?.stop()
        this.player = AudioPlayer(applicationContext, filePath, object : OnPlayListener {
          override fun onPrepared() {
            val objectMap = HashMap<String, Any>()
            objectMap["observeType"] = "AudioPlayer"
            val dataMap = HashMap<String, Any?>()
            dataMap["filePath"] = filePath
            dataMap["OnPlayListener"] = "onPrepared"
            objectMap["data"] = dataMap
            eventSink?.success(objectMap)
          }

          override fun onCompletion() {
            val objectMap = HashMap<String, Any>()
            objectMap["observeType"] = "AudioPlayer"
            val dataMap = HashMap<String, Any?>()
            dataMap["filePath"] = filePath
            dataMap["OnPlayListener"] = "onCompletion"
            objectMap["data"] = dataMap
            eventSink?.success(objectMap)
          }

          override fun onInterrupt() {
            val objectMap = HashMap<String, Any>()
            objectMap["observeType"] = "AudioPlayer"
            val dataMap = HashMap<String, Any?>()
            dataMap["filePath"] = filePath
            dataMap["OnPlayListener"] = "onInterrupt"
            objectMap["data"] = dataMap
            eventSink?.success(objectMap)
          }

          override fun onError(error: String) {
            val objectMap = HashMap<String, Any>()
            objectMap["observeType"] = "AudioPlayer"
            val dataMap = HashMap<String, Any?>()
            dataMap["filePath"] = filePath
            dataMap["OnPlayListener"] = "onError"
            dataMap["error"] = error
            objectMap["data"] = dataMap
            eventSink?.success(objectMap)
          }

          override fun onPlaying(curPosition: Long) {
            val objectMap = HashMap<String, Any>()
            objectMap["observeType"] = "AudioPlayer"
            val dataMap = HashMap<String, Any?>()
            dataMap["filePath"] = filePath
            dataMap["OnPlayListener"] = "onPlaying"
            dataMap["currentPosition"] = curPosition
            objectMap["data"] = dataMap
            eventSink?.success(objectMap)
          }
        })
        this.player?.start(audioSystem)
        result.success(true)
      }
      "getUserInfo" -> {
        val account = methodCall.argument<String>("account")
        NIMClient.getService(UserService::class.java).getUserInfo(account)
      }
      "fetchUserInfo" -> {
        val account = methodCall.argument<String>("account")
        val accountList = ArrayList<String>()
        accountList.add(account!!)
        NIMClient.getService(UserService::class.java).fetchUserInfo(accountList).setCallback(object : RequestCallback<List<NimUserInfo>> {
          override fun onSuccess(nimUserInfoList: List<NimUserInfo>?) {
            val nimUserInfoMapList = ArrayList<Map<String, Any?>>()
            if (nimUserInfoList != null) {
              for (nimUserInfo in nimUserInfoList) {
                val nimUserInfoMap = HashMap<String, Any?>()
                nimUserInfoMap["account"] = nimUserInfo.account
                nimUserInfoMap["avatar"] = nimUserInfo.avatar
                nimUserInfoMap["name"] = nimUserInfo.name
                nimUserInfoMap["birthday"] = nimUserInfo.birthday
                nimUserInfoMap["email"] = nimUserInfo.email
                nimUserInfoMap["extension"] = nimUserInfo.extension
                nimUserInfoMap["extensionMap"] = nimUserInfo.extensionMap
                nimUserInfoMap["genderEnum"] = nimUserInfo.genderEnum.value!!
                nimUserInfoMap["mobile"] = nimUserInfo.mobile
                nimUserInfoMap["signature"] = nimUserInfo.signature
                nimUserInfoMapList.add(nimUserInfoMap)
              }
            }
            result.success(nimUserInfoMapList)
          }

          override fun onFailed(code: Int) {

          }

          override fun onException(exception: Throwable) {

          }
        })
      }
      "queryMessageListEx" -> {
        val messageUuid = methodCall.argument<String>("messageUuid")
        val sessionId = methodCall.argument<String>("sessionId")
        val direction = methodCall.argument<String>("direction")
        var queryDirectionEnum = QueryDirectionEnum.QUERY_OLD
        when (direction) {
          "QueryDirectionEnum.QUERY_OLD" -> queryDirectionEnum = QueryDirectionEnum.QUERY_OLD
          "QueryDirectionEnum.QUERY_NEW" -> queryDirectionEnum = QueryDirectionEnum.QUERY_NEW
        }
        val limit = methodCall.argument<Int>("limit")!!
        val asc = methodCall.argument<Boolean>("asc")!!
        val message: IMMessage?
        message = if (messageUuid != null) {
          getIMMessageByUuid(messageUuid)
        } else {
          MessageBuilder.createEmptyMessage(sessionId, SessionTypeEnum.P2P, 0)
        }
        NIMClient.getService(MsgService::class.java)
          .queryMessageListEx(message, queryDirectionEnum, limit, asc)
          .setCallback(object : RequestCallback<List<IMMessage>?> {
            override fun onSuccess(imMessageListTmp: List<IMMessage>?) {
              if (imMessageListTmp != null) {
                result.success(Converter.iMMessageListToMap(imMessageListTmp))
              }
            }

            override fun onFailed(code: Int) {
            }

            override fun onException(exception: Throwable?) {
            }
          })
      }
      "MessageBuilder#createTextMessage" -> {
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        val sessionId = methodCall.argument<String>("sessionId")
        val text = methodCall.argument<String>("text")
        val imMessage = MessageBuilder.createTextMessage(sessionId, sessionTypeEnum, text)
        localMessageMap[imMessage.uuid] = imMessage
        result.success(Converter.iMMessageToMap(imMessage))
      }
      "MessageBuilder#createImageMessage" -> {
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        val sessionId = methodCall.argument<String>("sessionId")
        val filePath = methodCall.argument<String>("filePath")
        val displayName = methodCall.argument<String>("displayName")
        val nosTokenSceneKey = methodCall.argument<String>("nosTokenSceneKey")
        val imMessage = MessageBuilder.createImageMessage(sessionId, sessionTypeEnum, File(filePath), displayName, nosTokenSceneKey)
        localMessageMap[imMessage.getUuid()] = imMessage
        result.success(Converter.iMMessageToMap(imMessage))
      }
      "MessageBuilder#createAudioMessage" -> {
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        val sessionId = methodCall.argument<String>("sessionId")
        val filePath = methodCall.argument<String>("filePath")
        val duration = methodCall.argument<Int>("duration")!!
        val nosTokenSceneKey = methodCall.argument<String>("nosTokenSceneKey")
        val imMessage = MessageBuilder.createAudioMessage(sessionId, sessionTypeEnum, File(filePath), duration.toLong(), nosTokenSceneKey)
        localMessageMap[imMessage.getUuid()] = imMessage
        result.success(Converter.iMMessageToMap(imMessage))
      }
      "MessageBuilder#createVideoMessage" -> {
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        val sessionId = methodCall.argument<String>("sessionId")
        val filePath = methodCall.argument<String>("filePath")
        val duration = methodCall.argument<Int>("duration")!!
        val width = methodCall.argument<Int>("width")!!
        val height = methodCall.argument<Int>("height")!!
        val displayName = methodCall.argument<String>("displayName")
        val nosTokenSceneKey = methodCall.argument<String>("nosTokenSceneKey")
        val imMessage = MessageBuilder.createVideoMessage(sessionId, sessionTypeEnum, File(filePath), duration!!.toLong(), width, height, displayName, nosTokenSceneKey)
        localMessageMap[imMessage.getUuid()] = imMessage
        result.success(Converter.iMMessageToMap(imMessage))
      }
      "MessageBuilder#createCustomMessage" -> {
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        val sessionId = methodCall.argument<String>("sessionId")
        val content = methodCall.argument<String>("content")
        // TODO 暂用
        val flutterNIMCustomAttachment = NIMCustomAttachment()
        val attachment = methodCall.argument<Map<*, *>>("attachment")
        flutterNIMCustomAttachment.setCustomEncodeString(JSONUtil.unwrap(attachment).toString())
        val nosTokenSceneKey = methodCall.argument<String>("nosTokenSceneKey")
        val customMessageConfigMap = methodCall.argument<Map<String, Any>>("customMessageConfig")
        var customMessageConfig: CustomMessageConfig? = null
        if (customMessageConfigMap != null) {
          customMessageConfig = Converter.parseCustomMessageConfig(customMessageConfigMap)
        }
        val imMessage = MessageBuilder.createCustomMessage(sessionId, sessionTypeEnum, content, flutterNIMCustomAttachment, customMessageConfig, nosTokenSceneKey)
        localMessageMap[imMessage.getUuid()] = imMessage
        result.success(Converter.iMMessageToMap(imMessage))
      }
      "sendMessage" -> {
        val messageUuid = methodCall.argument<String>("messageUuid")
        val resend = methodCall.argument<Boolean>("resend")!!
        val uuidList: List<String>? = listOf(messageUuid!!)
        val imMessage = queryMessageListByUuidBlock(uuidList)[0]
        NIMClient.getService(MsgService::class.java).sendMessage(imMessage, resend).setCallback(object : RequestCallback<Void> {
          override fun onSuccess(param: Void?) {
            result.success(param)
            localMessageMap.remove(messageUuid)
          }

          override fun onFailed(code: Int) {
            result.success(code)
          }

          override fun onException(exception: Throwable) {
            //                        result.error("onException", exception.getMessage(), null);
          }
        })
      }
      "queryRecentContactsBlock" -> {
        val limit = methodCall.argument<Int>("limit")!!
        val recentContacts: List<RecentContact>
        recentContacts = if (limit > 0) {
          NIMClient.getService(MsgService::class.java).queryRecentContactsBlock(limit)
        } else {
          NIMClient.getService(MsgService::class.java).queryRecentContactsBlock()
        }
        result.success(Converter.recentContactsToMap(recentContacts))
      }
      "toggleNotification" -> {
        val enable = methodCall.argument<Boolean>("enable")!!
        NIMClient.toggleNotification(enable)
        result.success(true)
      }
      "queryMessageListByUuidBlock" -> {
        val uuidList = methodCall.argument<List<String>>("uuidList")
        result.success(Converter.iMMessageListToMap(queryMessageListByUuidBlock(uuidList)))
      }
      "setChattingAccount" -> {
        val account = methodCall.argument<String>("account")
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        NIMClient.getService(MsgService::class.java).setChattingAccount(account, sessionTypeEnum)
        result.success(true)
      }
      "clearUnreadCount" -> {
        val account = methodCall.argument<String>("account")
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        NIMClient.getService(MsgService::class.java).clearUnreadCount(account, sessionTypeEnum)
        result.success(true)
      }
      "deleteRecentContact2" -> {
        val account = methodCall.argument<String>("account")
        val sessionType = methodCall.argument<String>("sessionType")
        val sessionTypeEnum = Converter.toSessionTypeEnum(sessionType)
        NIMClient.getService(MsgService::class.java).deleteRecentContact2(account, sessionTypeEnum)
        result.success(true)
      }
      "getStatus" -> {
        result.success("StatusCode.${NIMClient.getStatus()}")
      }
      else -> result.notImplemented()
    }
  }

  internal var recentContactObserver: Observer<List<RecentContact>> = Observer { recentContacts ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "recentContactObserver"
    val recentContactMapList = Converter.recentContactsToMap(recentContacts)
    dataMap["data"] = recentContactMapList
    eventSink?.success(dataMap)
  }
  internal var receiveMessageObserver: Observer<List<IMMessage>> = Observer { imMessageList ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "receiveMessageObserver"
    dataMap["data"] = Converter.iMMessageListToMap(imMessageList)
    eventSink?.success(dataMap)
  }
  internal var recentContactDeletedObserver: Observer<RecentContact> = Observer { recentContact ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "recentContactDeletedObserver"
    dataMap["data"] = Converter.recentContactToMap(recentContact)
    eventSink?.success(dataMap)
  }
  internal var msgStatusObserver: Observer<IMMessage> = Observer { imMessage ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "msgStatusObserver"
    dataMap["data"] = Converter.iMMessageToMap(imMessage)
    eventSink?.success(dataMap)
  }
  internal var messageReceiptObserver: Observer<List<MessageReceipt>> = Observer { messageReceipts ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "messageReceiptObserver"
    dataMap["data"] = Converter.messageReceiptListToMap(messageReceipts)
    eventSink?.success(dataMap)
  }
  internal var attachmentProgressObserver: Observer<AttachmentProgress> = Observer { attachmentProgress ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "attachmentProgressObserver"
    dataMap["data"] = Converter.attachmentProgressToMap(attachmentProgress)
    eventSink?.success(dataMap)
  }
  internal var customNotificationObserver: Observer<CustomNotification> = Observer { customNotification ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "customNotificationObserver"
    dataMap["data"] = Converter.customNotificationToMap(customNotification)
    eventSink?.success(dataMap)
  }
  internal var revokeMsgNotificationObserver: Observer<RevokeMsgNotification> = Observer { revokeMsgNotification ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "revokeMsgNotificationObserver"
    dataMap["data"] = Converter.revokeMsgNotificationToMap(revokeMsgNotification)
    eventSink?.success(dataMap)
  }
  internal var onlineStatusObserver: Observer<StatusCode> = Observer { statusCode ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "onlineStatusObserver"
    dataMap["data"] = "StatusCode.$statusCode"
    eventSink?.success(dataMap)
  }
  internal var loginSyncDataStatusObserver: Observer<LoginSyncStatus> = Observer { loginSyncStatus ->
    val dataMap = HashMap<String, Any>()
    dataMap["observeType"] = "loginSyncDataStatusObserver"
    dataMap["data"] = "LoginSyncStatus.$loginSyncStatus"
    eventSink?.success(dataMap)
  }

  private fun queryMessageListByUuidBlock(uuidList: List<String>?): List<IMMessage> {
    val imMessageList = NIMClient.getService(MsgService::class.java).queryMessageListByUuidBlock(uuidList)
      ?: ArrayList<IMMessage>()
    if (imMessageList.size == 0) {
      for (uuid in uuidList!!) {
        imMessageList.add(localMessageMap[uuid])
      }
    }
    return imMessageList
  }

  override fun onNewIntent(intent: Intent): Boolean {
    val extraNotifyContent = intent.getSerializableExtra(NimIntent.EXTRA_NOTIFY_CONTENT)
    var messages = listOf<IMMessage>()
    if (extraNotifyContent != null) {
      messages = extraNotifyContent as ArrayList<IMMessage>
    }
    if (messages.isNotEmpty()) {
      if (eventSink != null) {
        val dataMap = HashMap<String, Any>()
        dataMap["observeType"] = "onNewIntent"
        dataMap["data"] = Converter.iMMessageListToMap(messages)
        eventSink!!.success(dataMap)
      }
    }

    return messages.isNotEmpty()
  }

  override fun onListen(o: Any?, eventSink: EventChannel.EventSink?) {
    this.eventSink = eventSink
    Log.i("onListen:", eventSink.toString())
  }

  internal fun registerAllObserver() {
    val service = NIMClient.getService(MsgServiceObserve::class.java)
    val authService = NIMClient.getService(AuthServiceObserver::class.java)

    service.observeReceiveMessage(receiveMessageObserver, false)
    service.observeMsgStatus(msgStatusObserver, false)
    service.observeMessageReceipt(messageReceiptObserver, false)
    service.observeRecentContact(recentContactObserver, false)
    service.observeRecentContactDeleted(recentContactDeletedObserver, false)
    service.observeAttachmentProgress(attachmentProgressObserver, false)
    service.observeCustomNotification(customNotificationObserver, false)
    service.observeRevokeMessage(revokeMsgNotificationObserver, false)
    authService.observeOnlineStatus(onlineStatusObserver, false)
    authService.observeLoginSyncDataStatus(loginSyncDataStatusObserver, false)

    service.observeReceiveMessage(receiveMessageObserver, true)
    service.observeMsgStatus(msgStatusObserver, true)
    service.observeMessageReceipt(messageReceiptObserver, true)
    service.observeRecentContact(recentContactObserver, true)
    service.observeRecentContactDeleted(recentContactDeletedObserver, true)
    service.observeAttachmentProgress(attachmentProgressObserver, true)
    service.observeCustomNotification(customNotificationObserver, true)
    service.observeRevokeMessage(revokeMsgNotificationObserver, true)
    authService.observeOnlineStatus(onlineStatusObserver, true)
    authService.observeLoginSyncDataStatus(loginSyncDataStatusObserver, true)
  }

  fun getIMMessageByUuid(uuid: String?): IMMessage? {
    var msg: IMMessage? = null
    val uuids = ArrayList<String>()
    uuids.add(uuid!!)
    val msgs = NIMClient.getService(MsgService::class.java).queryMessageListByUuidBlock(uuids)
    if (null != msgs && 0 < msgs.size) {
      msg = msgs[0]
      Log.d("getIMMessageByUuid:{}", java.lang.Long.toString(msg!!.time))
    }
    if (msg == null) {
      msg = localMessageMap[uuid]
    }
    return msg
  }

  override fun onCancel(o: Any?) {
    this.eventSink = null
  }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    this.onAttachedToEngine(binding.applicationContext, binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = null
  }
}
