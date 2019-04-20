/*
 * 官网地站:http://www.mob.com
 * 技术支持QQ: 4006852216
 * 官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
 *
 * Copyright (c) 2013年 mob.com. All rights reserved.
 */

package com.bristua.flutter.ftshop.wxapi;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.bristua.framework.define.IFlutterResult;
import com.bristua.framework.router.BRouter;
import com.bristua.ft.component.userlogin.UserLoginConstant;
import com.bristua.ft.protocol.Protocol;
import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelmsg.WXAppExtendObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;


/**
 * 微信客户端回调activity示例
 */
public class WXEntryActivity extends AppCompatActivity implements IWXAPIEventHandler, IFlutterResult {


    // IWXAPI 是第三方app和微信通信的openapi接口
    private IWXAPI api;
    public static final String WX_APP_ID = "wx1d942a6d38bd07f0";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 通过WXAPIFactory工厂，获取IWXAPI的实例
        api = WXAPIFactory.createWXAPI(this, WX_APP_ID, false);
        // 将该app注册到微信
        api.registerApp(WX_APP_ID);
//        int wxSdkVersion = api.getWXAppSupportAPI();
//        if (wxSdkVersion >= TIMELINE_SUPPORTED_VERSION) {
//            Toast.makeText(WXEntryActivity.this, "wxSdkVersion = " + Integer.toHexString(wxSdkVersion) + "\ntimeline supported", Toast.LENGTH_LONG).show();
//        } else {
//            Toast.makeText(WXEntryActivity.this, "wxSdkVersion = " + Integer.toHexString(wxSdkVersion) + "\ntimeline not supported", Toast.LENGTH_LONG).show();
//        }
        //注意：
        //第三方开发者如果使用透明界面来实现WXEntryActivity，需要判断handleIntent的返回值，如果返回值为false，则说明入参不合法未被SDK处理，应finish当前透明界面，避免外部通过传递非法参数的Intent导致停留在透明界面，引起用户的疑惑
        try {
            api.handleIntent(getIntent(), this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);

        setIntent(intent);
        api.handleIntent(intent, this);
    }

    // 微信发送请求到第三方应用时，会回调到该方法
    @Override
    public void onReq(BaseReq req) {
        switch (req.getType()) {
            case ConstantsAPI.COMMAND_GETMESSAGE_FROM_WX:
                break;
            case ConstantsAPI.COMMAND_SHOWMESSAGE_FROM_WX:
                break;
            default:
                break;
        }
    }

    // 第三方应用发送到微信的请求处理后的响应结果，会回调到该方法
    @Override
    public void onResp(BaseResp resp) {
        int result = 0;
        switch (resp.errCode) {
            case BaseResp.ErrCode.ERR_OK:
                if (resp.getType() == ConstantsAPI.COMMAND_SENDAUTH) { //登录成功的回调
                    if (resp instanceof SendAuth.Resp) {
                        SendAuth.Resp res = (SendAuth.Resp) resp;
                        String code = res.code;
                        //RxBus.getDefault().send(AllContants.RxBusCode.RXBUS_CODE_WECHAT_LOGIN, code);
                        Protocol protocol = new Protocol();
                        WXCode wxCode = new WXCode();
                        wxCode.setCode(code);
                        protocol.setData(wxCode);
                        protocol.setMethod(UserLoginConstant.WX_AWAKEN_MODULE);
                        String json = JSON.toJSONString(protocol);
                        try {
                            BRouter.getInstance().build(UserLoginConstant.USER_LOGIN_MODULE).setProtocol(json).setResult(this).navigation();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                break;
            case BaseResp.ErrCode.ERR_USER_CANCEL:
//                result = R.string.errcode_cancel;
                SendAuth.Resp res = (SendAuth.Resp) resp;
                int code = res.errCode;
                Log.d("WXEntryActivity", "code = " + code);
                //RxBus.getDefault().send(AllContants.RxBusCode.RXBUS_CODE_WECHAT_LOGIN_CANCEL, code);
                break;
            case BaseResp.ErrCode.ERR_AUTH_DENIED:
//                result = R.string.errcode_deny;
                break;
            case BaseResp.ErrCode.ERR_UNSUPPORT:
//                result = R.string.errcode_unsupported;
                break;
            default:
//                result = R.string.errcode_unknown;
                break;
        }
        finish();
        overridePendingTransition(0, 0);
    }


    /**
     * 处理微信发出的向第三方应用请求app message
     * <p>
     * 在微信客户端中的聊天页面有“添加工具”，可以将本应用的图标添加到其中
     * 此后点击图标，下面的代码会被执行。Demo仅仅只是打开自己而已，但你可
     * 做点其他的事情，包括根本不打开任何页面
     */
    public void onGetMessageFromWXReq(WXMediaMessage msg) {
        if (msg != null) {
            Intent iLaunchMyself = getPackageManager().getLaunchIntentForPackage(getPackageName());
            startActivity(iLaunchMyself);
        }
    }

    /**
     * 处理微信向第三方应用发起的消息
     * <p>
     * 此处用来接收从微信发送过来的消息，比方说本demo在wechatpage里面分享
     * 应用时可以不分享应用文件，而分享一段应用的自定义信息。接受方的微信
     * 客户端会通过这个方法，将这个信息发送回接收方手机上的本demo中，当作
     * 回调。
     * <p>
     * 本Demo只是将信息展示出来，但你可做点其他的事情，而不仅仅只是Toast
     */
    public void onShowMessageFromWXReq(WXMediaMessage msg) {
        if (msg != null && msg.mediaObject != null
                && (msg.mediaObject instanceof WXAppExtendObject)) {
            WXAppExtendObject obj = (WXAppExtendObject) msg.mediaObject;
            Toast.makeText(this, obj.extInfo, Toast.LENGTH_SHORT).show();
        }
    }

    @Override
    public void success(@Nullable String pResult, int pErrorCode, @Nullable String pMessage) {
        //此处接收回调
    }

    @Override
    public void error(@Nullable String pMessage, int pErrorCode) {

    }

    @Override
    public void notImplemented() {

    }
}
