package net.doggo_saloon.platform_wallet

import android.util.Log
import com.google.android.gms.pay.Pay
import com.google.android.gms.pay.PayApiAvailabilityStatus
import com.google.android.gms.pay.PayClient
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/** PlatformWalletPlugin */
class PlatformWalletPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private var activity: FlutterActivity? = null
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var walletClient: PayClient

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "platform_wallet")
    channel.setMethodCallHandler(this)
    walletClient = Pay.getClient(flutterPluginBinding.applicationContext)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity as FlutterActivity
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onDetachedFromActivity() {

  }

  private fun isWalletApiAvailable(callback: (Boolean) -> Unit) {
    walletClient.getPayApiAvailabilityStatus(PayClient.RequestType.SAVE_PASSES)
      .addOnCompleteListener {task ->
        if (task.isSuccessful) {
          val isAvailable = task.result == PayApiAvailabilityStatus.AVAILABLE
          Log.d("TAG", "isAvailable $isAvailable")
          callback(isAvailable)
        } else {
          callback(false)
        }
      }
  }

  private fun addGoogleWallet(token: String): String {
    if (activity == null) {
      return "unknown"
    }
    activity?.let { walletClient.savePassesJwt(token, it, 0) }
    return "success"
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isWalletApiAvailable" -> isWalletApiAvailable { res -> result.success(res) }
      "addGoogleWallet" -> result.success(addGoogleWallet(call.arguments as String))
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
