package com.bristua.flutter.ftshop;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.bristua.flutter.ftshop.wxapi.WXEntryActivity;
import com.bristua.flutter.ftshop.wxapi.WXPayResult;
import com.bristua.ft.component.userpay.UserPayConstant;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

public class WXAwakenActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        boolean isWxPay = getIntent().getBooleanExtra(UserPayConstant.USER_IS_WX_PAY, false);
        if (!isWxPay) {
            wxLogin();
            finish();
            return;
        }
        int code = getIntent().getIntExtra(UserPayConstant.USER_WX_PAY_CODE, 500);
        if (code != 200) {
            Toast.makeText(this, "用户支付失败，通讯模组没有初始化", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }
        String result = getIntent().getStringExtra(UserPayConstant.USER_WX_PAY_RESULT);
        WXPayResult wxPayResult = JSON.parseObject(result, WXPayResult.class);
        if (wxPayResult == null || wxPayResult.data == null || wxPayResult.code != 0) {
            Toast.makeText(this, "用户支付失败，通讯模组没有初始化", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }
        if (wxPayResult.data.appid == null || wxPayResult.data.partnerid == null
                || wxPayResult.data.prepayid == null || wxPayResult.data.packages == null || wxPayResult.data.noncestr == null || wxPayResult.data.timestamp == null || wxPayResult.data.sign == null) {
            Toast.makeText(this, "用户支付失败，通讯模组没有初始化", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }
        wxPay(wxPayResult.data.appid, wxPayResult.data.partnerid, wxPayResult.data.prepayid,
                wxPayResult.data.packages, wxPayResult.data.noncestr, wxPayResult.data.timestamp, wxPayResult.data.sign);
    }

    //微信登录
    private void wxLogin() {
        IWXAPI api = null;
        try {
            api = WXAPIFactory.createWXAPI(WXAwakenActivity.this, WXEntryActivity.WX_APP_ID, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 是否安装微信客户端
        if (api == null || !api.isWXAppInstalled()) {
            Toast.makeText(this, "检查到手机未安装微信客户端", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }
        SendAuth.Req req = new SendAuth.Req();
        req.scope = "snsapi_userinfo";
        req.state = "wechat_zhyy";
        api.sendReq(req);
    }


    /**
     * 微信支付
     *
     * @param appid     应用ID
     * @param partnerid 商户ID
     * @param prepayid  预支付ID
     * @param noncestr  订单号
     * @param timestamp 时间戳
     * @param sign
     */
    private void wxPay(String appid, String partnerid, String prepayid, String packages, String noncestr,
                       String timestamp, String sign) {
        IWXAPI api = null;
        try {
            api = WXAPIFactory.createWXAPI(WXAwakenActivity.this, WXEntryActivity.WX_APP_ID, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 是否安装微信客户端
        if (api == null || !api.isWXAppInstalled()) {
            Toast.makeText(this, "检查到手机未安装微信客户端", Toast.LENGTH_SHORT).show();
            finish();
            return;
        }
        PayReq req = new PayReq();
        req.appId = appid;
        req.partnerId = partnerid;
        req.prepayId = prepayid;
        req.nonceStr = noncestr;
        req.timeStamp = timestamp;
        req.packageValue = packages;
        req.sign = sign;
        req.extData = "app data"; // optional
        // Toast.makeText(mActivity, "正常调起支付", Toast.LENGTH_SHORT).show();
        // 在支付之前，如果应用没有注册到微信，应该先调用IWXMsg.registerApp将应用注册到微信
        api.sendReq(req);
    }
}
