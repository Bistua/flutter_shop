package com.bristua.flutter.ftshop.wxapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.bristua.flutter.ftshop.plugin.PluginProvider;
import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

/**
 * 微信支付回掉
 */
public class WXPayEntryActivity extends Activity implements IWXAPIEventHandler {
    private static final String TAG = "WXPayEntryActivity";

    private IWXAPI api;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        api = WXAPIFactory.createWXAPI(this, WXEntryActivity.WX_APP_ID);
        api.handleIntent(getIntent(), this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        api.handleIntent(intent, this);
    }

    @Override
    public void onReq(BaseReq req) {
    }

    @Override
    public void onResp(BaseResp resp) {
        if (resp.getType() == ConstantsAPI.COMMAND_PAY_BY_WX) {
            Log.d(TAG, "onPayFinish,errCode=" + resp.errCode);
//            AlertDialog.Builderbuilder = newAlertDialog.Builder(this);
//            builder.setTitle(R.string.app_tip);
        }
        switch (resp.errCode) {
            case BaseResp.ErrCode.ERR_OK:
                PluginProvider.resultCallBack(200,"微信支付成功");
                break;
            case BaseResp.ErrCode.ERR_COMM:// 支付失败
                Log.e(TAG, "微信支付 ------ 支付失败");
                PluginProvider.resultCallBack(403,"微信支付失败");
                break;
            case BaseResp.ErrCode.ERR_USER_CANCEL:// 支付取消
                Log.e(TAG, "微信支付 ------ 支付取消");
                PluginProvider.resultCallBack(406,"支付取消");
                break;
        }
        finish();
    }
}
