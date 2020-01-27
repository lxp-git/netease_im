import com.netease.nimlib.sdk.msg.attachment.MsgAttachment

/**
 * 自定义消息的附件
 *
 *
 *
 * @author chuguimin
 */
class NIMCustomAttachment : MsgAttachment {
    private var customEncodeString: String? = null

    internal fun setCustomEncodeString(customEncodeString: String) {
        this.customEncodeString = customEncodeString
    }

    override fun toJson(send: Boolean): String? {
        return customEncodeString
    }

}