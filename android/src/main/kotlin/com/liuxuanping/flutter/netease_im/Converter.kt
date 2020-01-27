import com.netease.nimlib.sdk.media.record.RecordType
import com.netease.nimlib.sdk.msg.attachment.AudioAttachment
import com.netease.nimlib.sdk.msg.attachment.FileAttachment
import com.netease.nimlib.sdk.msg.attachment.ImageAttachment
import com.netease.nimlib.sdk.msg.attachment.VideoAttachment
import com.netease.nimlib.sdk.msg.constant.MsgStatusEnum
import com.netease.nimlib.sdk.msg.constant.MsgTypeEnum
import com.netease.nimlib.sdk.msg.constant.SessionTypeEnum
import com.netease.nimlib.sdk.msg.model.*
import java.util.ArrayList
import java.util.HashMap

object Converter {
    fun iMMessageToMap(iMMessage: IMMessage): HashMap<String, Any?> {
        val messageMap = HashMap<String, Any?>()
        messageMap["fromNick"] = iMMessage.fromNick
        messageMap["attachStatus"] = "AttachStatusEnum." + iMMessage.attachStatus.toString()
        messageMap["attachStr"] = iMMessage.attachStr
        messageMap["sessionType"] = "SessionTypeEnum." + iMMessage.sessionType.toString()
        messageMap["sessionId"] = iMMessage.sessionId
        messageMap["content"] = iMMessage.content
        messageMap["msgType"] = "MsgTypeEnum." + iMMessage.msgType.toString() /// MsgTypeEnum.text
        messageMap["status"] = "MsgStatusEnum." + iMMessage.status.toString()
        messageMap["account"] = iMMessage.fromAccount
        messageMap["fromAccount"] = iMMessage.fromAccount
        messageMap["uuid"] = iMMessage.uuid
        messageMap["time"] = iMMessage.time
        messageMap["direct"] = "MsgDirectionEnum." + iMMessage.direct.toString()
        when (iMMessage.msgType) {
            MsgTypeEnum.image -> {
                val imageAttachment = iMMessage.attachment as ImageAttachment
                messageMap["attachment"] = attachmentToMap(imageAttachment)
            }
            MsgTypeEnum.audio -> {
                val audioAttachment = iMMessage.attachment as AudioAttachment
                messageMap["attachment"] = attachmentToMap(audioAttachment)
            }
            MsgTypeEnum.video -> {
                val videoAttachment = iMMessage.attachment as VideoAttachment
                messageMap["attachment"] = attachmentToMap(videoAttachment)
            }
            MsgTypeEnum.custom -> {
                val customAttachmentMap = HashMap<String, Any?>()
                messageMap["attachment"] = iMMessage.attachment.toJson(false)
            }
            else -> {
            }
        }

        return messageMap
    }

    fun recentContactToMap(recentContact: RecentContact): HashMap<String, Any?> {
        val hashMap = HashMap<String, Any?>()
        when (recentContact.msgType) {
            MsgTypeEnum.image -> {
                val imageAttachment = recentContact.attachment as ImageAttachment
                hashMap["attachment"] = attachmentToMap(imageAttachment)
            }
            MsgTypeEnum.audio -> {
                val audioAttachment = recentContact.attachment as AudioAttachment
                hashMap["attachment"] = attachmentToMap(audioAttachment)
            }
            MsgTypeEnum.video -> {
                val videoAttachment = recentContact.attachment as VideoAttachment
                hashMap["attachment"] = attachmentToMap(videoAttachment)
            }
            MsgTypeEnum.custom -> {
                val customAttachmentMap = HashMap<String, Any?>()
                hashMap["attachment"] = recentContact.attachment.toJson(false)
            }
            else -> {
            }
        }
        hashMap["contactId"] = recentContact.contactId
        hashMap["fromAccount"] = recentContact.fromAccount
        try {
            hashMap["fromNick"] = recentContact.fromNick
        } catch (e: Exception) {
//            e.printStackTrace()
            hashMap["fromNick"] = ""
        }
        hashMap["sessionType"] = "SessionTypeEnum." + recentContact.sessionType?.toString()
        hashMap["recentMessageId"] = recentContact.recentMessageId
        hashMap["msgType"] = "MsgTypeEnum." + recentContact.msgType?.toString()
        hashMap["msgStatus"] = "MsgStatusEnum." + recentContact.msgStatus?.toString()
        hashMap["unreadCount"] = recentContact.unreadCount
        hashMap["content"] = recentContact.content
        hashMap["time"] = recentContact.time
        hashMap["tag"] = recentContact.tag
        hashMap["extension"] = recentContact.extension

        return hashMap
    }

    fun messageReceiptToMap(messageReceipt: MessageReceipt): HashMap<String, Any> {
        val hashMap = HashMap<String, Any>()
        hashMap["sessionId"] = messageReceipt.sessionId
        hashMap["time"] = messageReceipt.time
        return hashMap
    }

    fun messageReceiptListToMap(messageReceiptList: List<MessageReceipt>): List<HashMap<String, Any>> {
        val hashMapList = ArrayList<HashMap<String, Any>>()
        messageReceiptList.forEach { hashMapList.add(messageReceiptToMap(it)) }
        return hashMapList
    }

    fun iMMessageListToMap(iMMessageList: List<IMMessage>): List<HashMap<String, Any?>> {
        val hashMapList = ArrayList<HashMap<String, Any?>>()
        iMMessageList.forEach { hashMapList.add(iMMessageToMap(it)) }
        return hashMapList
    }

    fun recentContactsToMap(recentContactList: List<RecentContact>?): List<HashMap<String, Any?>> {
        val hashMapList = ArrayList<HashMap<String, Any?>>()
        recentContactList?.forEach { hashMapList.add(recentContactToMap(it)) }
        return hashMapList
    }

    fun attachmentProgressToMap(attachmentProgress: AttachmentProgress): HashMap<String, Any> {
        val dataMap = HashMap<String, Any>()
        dataMap["url"] = attachmentProgress.uuid
        dataMap["transferred"] = attachmentProgress.transferred
        dataMap["total"] = attachmentProgress.total
        return dataMap
    }

    fun customNotificationToMap(customNotification: CustomNotification): HashMap<String, Any> {
        val dataMap = HashMap<String, Any>()
        dataMap["sessionId"] = customNotification.sessionId
        dataMap["sessionType"] = "SessionTypeEnum." + customNotification.sessionType.toString()
        dataMap["fromAccount"] = customNotification.fromAccount
        dataMap["time"] = customNotification.time
        dataMap["content"] = customNotification.content
        dataMap["isSendToOnlineUserOnly"] = customNotification.isSendToOnlineUserOnly
        dataMap["apnsText"] = customNotification.apnsText
        dataMap["pushPayload"] = customNotification.pushPayload
        val configMap = HashMap<String, Any>()
        configMap["enablePush"]  = customNotification.config.enablePush
        configMap["enablePushNick"]  = customNotification.config.enablePushNick
        configMap["enableUnreadCount"]  = customNotification.config.enableUnreadCount
        dataMap["config"] = configMap
        return dataMap
    }

    fun revokeMsgNotificationToMap(revokeMsgNotification: RevokeMsgNotification): HashMap<String, Any> {
        val dataMap = HashMap<String, Any>()
        dataMap["message"] = iMMessageToMap(revokeMsgNotification.message)
        dataMap["revokeAccount"] = revokeMsgNotification.revokeAccount
        dataMap["customInfo"] = revokeMsgNotification.customInfo
        dataMap["notificationType"] = revokeMsgNotification.notificationType
        return dataMap
    }

    fun attachmentToMap(fileAttachment: FileAttachment): HashMap<String, Any?> {
        val audioObject = HashMap<String, Any?>()
        audioObject["path"] = fileAttachment.path
        audioObject["size"] = fileAttachment.size
        audioObject["md5"] = fileAttachment.md5
        audioObject["url"] = fileAttachment.url
        audioObject["displayName"] = fileAttachment.displayName
        audioObject["extension"] = fileAttachment.extension
        audioObject["nosTokenSceneKey"] = fileAttachment.nosTokenSceneKey
        audioObject["fileName"] = fileAttachment.fileName
        audioObject["isForceUpload"] = fileAttachment.isForceUpload
        audioObject["thumbPath"] = fileAttachment.thumbPath
        audioObject["thumbPathForSave"] = fileAttachment.thumbPathForSave
        return audioObject
    }

    fun attachmentToMap(imageAttachment: ImageAttachment): HashMap<String, Any?> {
        val imageObject = attachmentToMap(imageAttachment as FileAttachment)
        imageObject["url"] = imageAttachment.url
        imageObject["thumbUrl"] = imageAttachment.thumbUrl
        imageObject["thumbPath"] = imageAttachment.thumbPath
        imageObject["path"] = imageAttachment.path
        imageObject["width"] = imageAttachment.width
        imageObject["height"] = imageAttachment.height
        return imageObject
    }

    fun attachmentToMap(audioAttachment: AudioAttachment): HashMap<String, Any?> {
        val audioObject = attachmentToMap(audioAttachment as FileAttachment)
        audioObject["url"] = audioAttachment.url
        audioObject["path"] = audioAttachment.path
        audioObject["duration"] = audioAttachment.duration
        return audioObject
    }

    fun attachmentToMap(videoAttachment: VideoAttachment): HashMap<String, Any?> {
        val videoObject = attachmentToMap(videoAttachment as FileAttachment)
        videoObject["url"] = videoAttachment.url
        videoObject["thumbUrl"] = videoAttachment.thumbUrl
        videoObject["path"] = videoAttachment.path
        videoObject["duration"] = videoAttachment.duration
        videoObject["width"] = videoAttachment.width
        videoObject["height"] = videoAttachment.height
        return videoObject
    }

    fun toSessionTypeEnum(sessionType: String?): SessionTypeEnum {
        return when (sessionType) {
            "SessionTypeEnum.P2P" -> SessionTypeEnum.P2P
            "SessionTypeEnum.Team" -> SessionTypeEnum.Team
            "SessionTypeEnum.SUPER_TEAM" -> SessionTypeEnum.SUPER_TEAM
            "SessionTypeEnum.System" -> SessionTypeEnum.System
            "SessionTypeEnum.ChatRoom" -> SessionTypeEnum.ChatRoom
            else -> SessionTypeEnum.P2P
        }
    }

    fun parseCustomMessageConfig(map: Map<String, Any>?): CustomMessageConfig? {
        if (map == null) {
            return null
        }
        val customMessageConfig = CustomMessageConfig()
        customMessageConfig.enableHistory = map["enableHistory"] as Boolean
        customMessageConfig.enableRoaming = map["enableRoaming"] as Boolean
        customMessageConfig.enableSelfSync = map["enableSelfSync"] as Boolean
        customMessageConfig.enablePush = map["enablePush"] as Boolean
        customMessageConfig.enablePushNick = map["enablePushNick"] as Boolean
        customMessageConfig.enableUnreadCount = map["enableUnreadCount"] as Boolean
        customMessageConfig.enableRoute = map["enableRoute"] as Boolean
        customMessageConfig.enablePersist = map["enablePersist"] as Boolean
        return customMessageConfig
    }

    fun parseMsgStatusEnum(string: String?): MsgStatusEnum? {
        return when(string) {
            "MsgStatusEnum.draft" -> MsgStatusEnum.draft
            "MsgStatusEnum.sending" -> MsgStatusEnum.sending
            "MsgStatusEnum.success" -> MsgStatusEnum.success
            "MsgStatusEnum.fail" -> MsgStatusEnum.fail
            "MsgStatusEnum.read" -> MsgStatusEnum.read
            "MsgStatusEnum.unread" -> MsgStatusEnum.unread
            else -> null
        }
    }

    fun toRecordTypeEnum(recordType: String?): RecordType? {
        if (recordType == null) {
            return null
        }
        return when(recordType) {
            "RecordType.AMR" -> RecordType.AMR
            "RecordType.AAC" -> RecordType.AAC
            else -> RecordType.AMR
        }
    }
}