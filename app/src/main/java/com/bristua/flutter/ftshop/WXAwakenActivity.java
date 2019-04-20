package com.bristua.flutter.ftshop;

import android.app.Activity;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.bristua.flutter.ftshop.wxapi.WXEntryActivity;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

public class WXAwakenActivity extends Activity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        wxLogin();
        finish();

//        WXPayResult wxPayResult = JSON.parseObject(pResult, WXPayResult.class);
//                        wxPay(wxPayResult.data.appid, wxPayResult.data.partnerid, wxPayResult.data.prepayid,
//                                wxPayResult.data.packages, wxPayResult.data.noncestr, wxPayResult.data.timestamp, wxPayResult.data.sign);
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
            //ToastUtils.showToast(mView, "检查到手机未安装微信客户端");
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
            //ToastUtils.showToast(mView, "检查到手机未安装微信客户端");
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
