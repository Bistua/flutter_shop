package com.bristua.flutter.ftshop.plugin;

import android.content.Context;
import android.support.annotation.Nullable;
import android.text.TextUtils;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class PluginProvider {
    private static final String CHANNEL = "com.ym.framework.plugins/bridge";

    public static void registerPlugin(final Context context, BinaryMessenger messenger, final PluginDelegate iDelegate) {
        new MethodChannel(messenger, CHANNEL).setMethodCallHandler((methodCall, result) -> {
            try {
                JSONObject jsonObject;
                if (!TextUtils.isEmpty(methodCall.arguments.toString())) {
                    jsonObject = new JSONObject(methodCall.arguments.toString());
                } else {
                    result.notImplemented();
                    return;
                }
                iDelegate.call(context, methodCall, jsonObject, new Result() {
                    @Override
                    public void success(@Nullable Object o) {
                        result.success(o);
                    }

                    @Override
                    public void error(String s, @Nullable String s1, @Nullable Object o) {
                        result.error(s,s1,o);
                    }

                    @Override
                    public void notImplemented() {
                        result.notImplemented();
                    }
                });
            } catch (JSONException e) {
                e.printStackTrace();
            }
        });


    }



}
