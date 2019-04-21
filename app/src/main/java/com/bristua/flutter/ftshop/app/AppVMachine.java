package com.bristua.flutter.ftshop.app;

import android.app.Application;
import android.content.Context;
import android.os.Handler;
import android.support.annotation.Nullable;

import com.bristua.bristua.sp.ShareprefenseImpl;
import com.bristua.flutter.ftshop.R;
import com.bristua.flutter.ftshop.exception.VMachineException;
import com.bristua.framework.appconfig.AppConfig;
import com.bristua.framework.appconfig.env.define.EnvConstants;
import com.bristua.framework.appconfig.env.define.manager.IEnviromentManager;
import com.bristua.framework.context.AppContextWrapper;
import com.bristua.framework.define.manager.IComponentManager;
import com.bristua.framework.https.HttpsModule;
import com.bristua.framework.manager.comp.CompManager;
import com.bristua.framework.router.BRouter;
import com.bristua.framework.system.AppContext;
import com.bristua.framework.system.ISharePrefense;
import com.bristua.ft.interceptor.response.HttpResponseInterceptor;
import com.nd.adhoc.framework.ssl.cert.HttpsSSLContext;

/**
 * 应用模拟器
 *
 * @author richsjeson
 */
public class AppVMachine {


    private final String pDATA = "ftshop";

    private IComponentManager compManager;

    private static AppVMachine mInstance;

    private AppVMachine() {

    }

    public static AppVMachine getInstance() {

        if (mInstance == null) {
            mInstance = new AppVMachine();
        }
        return mInstance;
    }

    /**
     * 虚拟机创建
     *
     * @param pContext
     */
    public void init(@Nullable Context pContext) {
        AppConfig.getInstance().init();
        //创建上下文环境
        initContext(pContext);
        IEnviromentManager envManager = AppConfig.getInstance().getEnvirmonetManager();
        envManager.init();
        //设置当前环境为开发环境
        envManager.setEnv(EnvConstants.ENVIROMENT_DEVELOP);
        initHttpsModule(envManager);
        //初始化加载模组，对retrofit进行初始化
        initBRouter();
    }

    /**
     * 执行业务模组启动
     *
     * @throws VMachineException
     */
    public void start(@Nullable Context pContext) throws VMachineException {

        if (compManager == null) {
            throw new VMachineException(pContext.getResources().getString(R.string.vm_init_exception));
        }
        compManager.start();
    }

    /**
     * 停止模组初始化
     *
     * @throws VMachineException
     */
    public void stop(@Nullable Context pContext) throws VMachineException {

        if (compManager == null) {
            throw new VMachineException(pContext.getResources().getString(R.string.vm_stop_exception));
        }
        compManager.release();
    }

    /**
     * 初始化https模组
     */
    private void initHttpsModule(@Nullable IEnviromentManager pEnvManager) {
        HttpsModule.getInstance().init(pEnvManager);
        HttpsModule.getInstance().addInterceptor(new HttpResponseInterceptor())
                .setSSL(new HttpsSSLContext())
                .setHostNameVerifier(true)
                .build();
    }

    /**
     * 创建系统全局的上下文
     *
     * @param pContext
     */
    private void initContext(@Nullable Context pContext) {
        //装载context
        AppContext context = new AppContextWrapper(pContext);
        AppConfig appConfig = AppConfig.getInstance();
        ISharePrefense sharePrefense = new ShareprefenseImpl(pContext, pDATA);
        ((AppContextWrapper) context).setSharePrenfense(sharePrefense);
        appConfig.setAppContext(context);
        /**
         * 设置全局的Handler
         */
        appConfig.setUIHandler(new Handler());
    }

    private void initBRouter() {
        compManager = new CompManager();
        //创建路由模组初始化
        BRouter.getInstance().create(compManager);
    }
}
