package com.bristua.flutter.ftshop.plugin;

import android.content.Context;
import android.support.annotation.Nullable;
import android.text.TextUtils;

import com.bristua.framework.define.IFlutterResult;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author richsjeson
 * flutter 桥
 */
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
                try {
                    iDelegate.call(context, methodCall, jsonObject, new IFlutterResult() {
                        @Override
                        public void success(@Nullable String pResult, int pErrorCode, @Nullable String pMessage) {
                            result.success(pResult);
                        }

                        @Override
                        public void error(@Nullable String pMessage, int pErrorCode) {
                            callbackError(result, pErrorCode, pMessage);
                        }

                        @Override
                        public void notImplemented() {
                            result.notImplemented();
                        }
                    });
                } catch (Exception e) {
                    e.printStackTrace();
                    callbackError(result, -1, e.getMessage());
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        });


    }

    private static void callbackError(MethodChannel.Result result, int code, String e) {
        JSONObject jsonObject1 = new JSONObject();
        try {
            jsonObject1.put("code", code);
            jsonObject1.put("msg", e);
            result.success(jsonObject1.toString());
        } catch (JSONException e1) {
            e1.printStackTrace();
        }
    }


}
