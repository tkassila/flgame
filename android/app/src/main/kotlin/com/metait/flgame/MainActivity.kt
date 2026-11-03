package com.metait.flgame

import android.view.accessibility.AccessibilityManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.metait.flgame/accessibility"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isTalkBackEnabled") {
                val am = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
                // isTouchExplorationEnabled is the most reliable indicator that TalkBack is active
                result.success(am.isEnabled && am.isTouchExplorationEnabled)
            } else {
                result.notImplemented()
            }
        }
    }
}
