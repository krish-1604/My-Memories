package com.mymemories

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.media.MediaScannerConnection

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.mymemories/mediaScanner"

    fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "scanFile") {
                val path = call.argument<String>("path")
                if (path != null) {
                    scanFile(path)
                    result.success(null)
                } else {
                    result.error("UNAVAILABLE", "Path not provided.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun scanFile(path: String) {
        MediaScannerConnection.scanFile(this, arrayOf(path), null, null)
    }
}
