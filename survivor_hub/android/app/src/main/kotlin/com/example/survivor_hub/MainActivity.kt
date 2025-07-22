package com.example.survivor_hub // Update your correct package

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterActivity() {
    private val CHANNEL = "SecureScreen"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "SecureScreen") {
                val secure = call.argument<Boolean>("secure") ?: true
                if (secure) {
                    window.setFlags(LayoutParams.FLAG_SECURE, LayoutParams.FLAG_SECURE)
                } else {
                    window.clearFlags(LayoutParams.FLAG_SECURE)
                }
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
