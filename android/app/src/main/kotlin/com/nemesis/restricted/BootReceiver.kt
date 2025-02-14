package com.nemesis.restricted

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (Intent.ACTION_BOOT_COMPLETED == intent.action) {
            val serviceIntent = Intent(context, MainActivity::class.java)
            serviceIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(serviceIntent)
        }
    }
}