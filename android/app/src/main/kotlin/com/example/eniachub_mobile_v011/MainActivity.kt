package com.example.eniachub_mobile_v011

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    //this is commented because of double registration according to this thread https://github.com/FirebaseExtended/flutterfire/issues/1669 firebase messages configuration called multiple times
    /*override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }*/
}
