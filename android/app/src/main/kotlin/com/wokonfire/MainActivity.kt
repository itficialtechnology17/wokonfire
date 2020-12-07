package com.wokonfire

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
  /*  private val CHANNEL = "flutter.native/helper" //Change as per project
    private lateinit var plugin : AllInOneSDKPlugin

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler { call, result ->
            plugin = AllInOneSDKPlugin(this,call,result)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        plugin.onActivityResult(requestCode,resultCode,data)
    }
*/

}
