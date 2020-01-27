import android.content.Context
import android.content.SharedPreferences
import android.text.TextUtils

import com.netease.nimlib.sdk.auth.LoginInfo

object NIMSharePreferences {
    private const val KEY_USER_ACCOUNT = "flutter_nim_account"
    private const val KEY_USER_TOKEN = "flutter_nim_token"
    private const val KEY_SHARED_PREFERENCES = "flutter_nim"

    /**
     * 获取云信用户登录信息，用于自动登录
     */
    fun getLoginInfo(context: Context): LoginInfo? {
        val sharedPreferences: SharedPreferences = context.getSharedPreferences(KEY_SHARED_PREFERENCES, Context.MODE_PRIVATE)
        val account = sharedPreferences.getString(KEY_USER_ACCOUNT, "")
        val token = sharedPreferences.getString(KEY_USER_TOKEN, "")

        return if (!TextUtils.isEmpty(account) && !TextUtils.isEmpty(token)) {
            LoginInfo(account, token)
        } else {
            null
        }
    }

    fun saveLoginInfo(context: Context?, param: LoginInfo?) {
        if (param != null) {
            val sharedPreferences: SharedPreferences? = context?.getSharedPreferences(KEY_SHARED_PREFERENCES, Context.MODE_PRIVATE)
            val editor: SharedPreferences.Editor? = sharedPreferences?.edit()
            editor?.putString(KEY_USER_ACCOUNT, param.account)
            editor?.putString(KEY_USER_TOKEN, param.token)
            editor?.apply()
        }
    }

    fun clear(context: Context?) {
        val sharedPreferences: SharedPreferences? = context?.getSharedPreferences(KEY_SHARED_PREFERENCES, Context.MODE_PRIVATE)
        val editor = sharedPreferences?.edit()
        editor?.clear()
        editor?.apply()
    }
}