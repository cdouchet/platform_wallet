package com.example.platform_wallet

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
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }

  private fun isWalletApiAvailable(): Boolean {
    var task = walletClient.getPayApiAvailabilityStatus(PayClient.RequestType.SAVE_PASSES)
    if (!task.isSuccessful) {
      return false
    }
    return task.result == PayApiAvailabilityStatus.AVAILABLE
  }

  private fun addGoogleWallet(token: String) {
    activity?.let { walletClient.savePassesJwt(token, it, 0) }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isWalletApiAvailable" -> result.success(isWalletApiAvailable())
      "addGoogleWallet" -> result.success(addGoogleWallet(call.arguments as String))
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
