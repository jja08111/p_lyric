package com.example.p_lyric

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import `in`.jvapps.system_alert_window.SystemAlertWindowPlugin
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class MainActivity : FlutterActivity(), PluginRegistrantCallback {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SystemAlertWindowPlugin.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        SystemAlertWindowPlugin.registerWith(registry.registrarFor("in.jvapps.system_alert_window"));
    }
}