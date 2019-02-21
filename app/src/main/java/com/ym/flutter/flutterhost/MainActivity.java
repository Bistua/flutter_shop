package com.ym.flutter.flutterhost;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.ym.flutter.flutterhost.plugin.PluginDelegate;
import com.ym.flutter.flutterhost.plugin.PluginProvider;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity   {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        FlutterView flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "route1");
        FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        addContentView(flutterView, layout);

        PluginProvider.registerPlugin(this, flutterView, new PluginDelegate());
    }


}
