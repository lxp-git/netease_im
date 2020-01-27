import com.netease.nimlib.sdk.msg.attachment.MsgAttachment
import com.netease.nimlib.sdk.msg.attachment.MsgAttachmentParser

/**
 * 自定义消息的附件解析器
 *
 *
 *
 * @author chuguimin
 */
class NIMCustomAttachParser : MsgAttachmentParser {

    override fun parse(json: String): MsgAttachment {
        val attachment = NIMCustomAttachment()
        attachment.setCustomEncodeString(json)

        return attachment
    }
}
