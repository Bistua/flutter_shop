package com.bristua.flutter.ftshop.plugin;

import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;
import android.widget.Toast;

import com.bristua.flutter.ftshop.WebActivity;
import com.bristua.framework.define.IFlutterResult;
import com.bristua.framework.router.BRouter;

import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;

public class PluginDelegate {

    public void call(Context context, MethodCall methodCall, String params, IFlutterResult result) throws Exception {
        JSONObject jsonObject = null;
        if (!TextUtils.isEmpty(params)) {
            jsonObject = new JSONObject(methodCall.arguments.toString());
        }

        switch (methodCall.method) {
            case "webview":
                if (jsonObject != null) {
                    String url = jsonObject.optString("url");
                    Intent intent = new Intent(context, WebActivity.class);
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("url",url);
                    context.startActivity(intent);
                }

                break;
            case "showShortToast":
                if (jsonObject != null)
                    Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_SHORT).show();
//                result.success("success from native toast", 0, "success from native message");
//                result.error("message",-1);
//                result.notImplemented();
                break;
            case "showLongToast":
                if (jsonObject != null)
                    Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_LONG).show();
//                result.success(null, 0, "");
                break;

            case "showToast":
                if (jsonObject != null)
                    Toast.makeText(context, jsonObject.optString("message"), jsonObject.optInt("duration")).show();
//                result.success(null, 0, "");
                break;
            default:
                if (jsonObject != null) {
                    String action = jsonObject.optString("action");
                    if (TextUtils.isEmpty(action)) {
                        break;
                    }
                    JSONObject arguments = jsonObject.optJSONObject("arguments");

                    if (arguments == null) {
                        break;
                    }
                    String argument = arguments.toString();
                    BRouter.getInstance().build(action).setProtocol(argument).setResult(result).navigation();
                }
                break;
        }

    }
}
