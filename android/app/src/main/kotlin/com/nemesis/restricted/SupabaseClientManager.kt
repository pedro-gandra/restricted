package com.nemesis.restricted

import io.github.jan.supabase.postgrest.*
import io.github.jan.supabase.createSupabaseClient
import io.github.jan.supabase.storage.Storage

object SupabaseClientManager {

    private const val supabaseUrl = "https://mfmdywuxtclmgzjypylq.supabase.co"
    private const val supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1mbWR5d3V4dGNsbWd6anlweWxxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzNjUxOTQsImV4cCI6MjA0Njk0MTE5NH0.YDu1892UI_N-fXHBIkeiwXogiwl_ah4zWeQ9l2ozep0"

    val supabase by lazy {
        createSupabaseClient(
            supabaseUrl = supabaseUrl,
            supabaseKey = supabaseKey
        ) {
            install(Postgrest)
            install(Storage)
        }
    }
}