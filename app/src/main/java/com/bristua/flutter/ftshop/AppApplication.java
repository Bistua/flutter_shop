package com.bristua.flutter.ftshop;
import android.app.Application;

import com.bristua.flutter.ftshop.app.AppVMachine;
import com.bristua.flutter.ftshop.exception.VMachineException;

/**
 * 系统入口
 * @author richsjeson
 */
public class AppApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        //初始化系统
        AppVMachine.getInstance().init(this.getApplicationContext());
        try {
            //启动组件模块
            AppVMachine.getInstance().start(this.getApplicationContext());
        } catch (VMachineException e) {
            e.printStackTrace();
        }
    }
}
