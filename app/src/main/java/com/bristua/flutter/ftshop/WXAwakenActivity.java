package com.bristua.flutter.ftshop;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;

import com.bristua.flutter.ftshop.wxapi.WXEntryActivity;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

public class WXAwakenActivity extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        IWXAPI api = null;
        try {
            api = WXAPIFactory.createWXAPI(WXAwakenActivity.this, WXEntryActivity.WX_APP_ID, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 是否安装微信客户端
        if (api == null || !api.isWXAppInstalled()) {
            //ToastUtils.showToast(mView, "检查到手机未安装微信客户端");
            return;
        }
        SendAuth.Req req = new SendAuth.Req();
        req.scope = "snsapi_userinfo";
        req.state = "wechat_zhyy";
        api.sendReq(req);
        finish();
    }
}
