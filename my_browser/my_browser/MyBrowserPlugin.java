package com.example.my_browser;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

public class MyBrowserPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  Activity activity;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.activity = (Activity)flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "my_browser");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("openBrowser")) {
      openBrowser(call, result, call.argument("url"));
    } else {
      result.notImplemented();
    }
  }

  private void openBrowser(MethodCall call, Result result, String url) {
    Activity activity = this.activity;
    if (activity == null) {
      result.error("ACTIVITY_NOT_AVAILABLE",
              "Browser cannot be opened without foreground activity", null);
      return;
    }
    Intent intent = new Intent(Intent.ACTION_VIEW);
    intent.setData(Uri.parse(url));
    activity.startActivity(intent);
    result.success(true);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
