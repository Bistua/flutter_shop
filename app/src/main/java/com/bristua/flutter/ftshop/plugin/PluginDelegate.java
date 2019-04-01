package com.bristua.flutter.ftshop.plugin;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.text.TextUtils;
import android.widget.Toast;
import com.bristua.flutter.ftshop.plugin.*;

import com.bristua.flutter.ftshop.VideoActivity;

import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class PluginDelegate {

    public void call(Context context, MethodCall methodCall, JSONObject jsonObject, Result result) {
        String action = jsonObject.optString("action");
        switch (action) {
            case "toast":
                doToast(context, methodCall, jsonObject, result);
                break;
            case "http":
                doHttp(methodCall, jsonObject, result);
                break;
            case "battery":
                getBattery(context, methodCall, result);
                break;
            case "navigate":
                doNavigate(context, methodCall, result);
                break;
        }
    }

    private void doNavigate(Context context, MethodCall methodCall, Result result) {
        if (methodCall.method.equals("video")) {
            Intent intent = new Intent(context, VideoActivity.class);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    private void getBattery(Context context, MethodCall methodCall, Result result) {
        if (methodCall.method.equals("getBatteryLevel")) {
            String batteryLevel = getBatteryLevel(context);
            if (!TextUtils.equals(batteryLevel, "-1")) {
                result.success(batteryLevel);
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null);
            }
        } else {
            result.notImplemented();
        }
    }

    private void doHttp(MethodCall methodCall, JSONObject jsonObject, Result result) {
        switch (methodCall.method) {
            case "get":
                String param = jsonObject.optString("json");
                result.success(param + "get 成功 success");
                break;
            case "post":
                result.success("post成功success");
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void doToast(Context context, MethodCall methodCall, JSONObject jsonObject, Result result) {
        switch (methodCall.method) {
            case "showShortToast":
                Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_SHORT).show();
                result.success(null);
                break;
            case "showLongToast":
                Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_LONG).show();
                result.success(null);
                break;

            case "showToast":
                Toast.makeText(context, jsonObject.optString("message"), jsonObject.optInt("duration")).show();
                result.success(null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private String getBatteryLevel(Context context) {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) context.getSystemService(Context.BATTERY_SERVICE);
            if (batteryManager != null) {
                batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
            }
        } else {
            Intent intent = new ContextWrapper(context.getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            if (intent != null) {
                batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                        intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
            }
        }
        return String.valueOf(batteryLevel);
    }
}
