package com.bristua.flutter.ftshop.plugin;

import android.content.Context;
import android.widget.Toast;

import com.bristua.framework.define.IFlutterResult;
import com.bristua.framework.router.BRouter;

import org.json.JSONObject;

import io.flutter.plugin.common.MethodCall;

public class PluginDelegate {

    public void call(Context context, MethodCall methodCall, JSONObject jsonObject, IFlutterResult result) throws Exception {
        switch (methodCall.method) {
            case "showShortToast":
                Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_SHORT).show();
                result.success(null, 0, "");
                break;
            case "showLongToast":
                Toast.makeText(context, jsonObject.optString("message"), Toast.LENGTH_LONG).show();
                result.success(null, 0, "");
                break;

            case "showToast":
                Toast.makeText(context, jsonObject.optString("message"), jsonObject.optInt("duration")).show();
                result.success(null, 0, "");
                break;
            default:
                String action = jsonObject.optString("action");
                BRouter.getInstance().build(action).setProtocol(jsonObject.toString()).setResult(result).navigation();
                break;
        }

    }
}
