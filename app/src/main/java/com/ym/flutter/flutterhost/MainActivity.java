package com.ym.flutter.flutterhost;

import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.ym.flutter.flutterhost.plugin.PluginDelegate;
import com.ym.flutter.flutterhost.plugin.PluginProvider;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {
    FlutterView flutterView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ActionBar supportActionBar = getSupportActionBar();
        if (supportActionBar != null) {
            supportActionBar.hide();
        }
        flutterView = Flutter.createView(MainActivity.this, getLifecycle(), "route1");
        FrameLayout.LayoutParams layout = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        PluginProvider.registerPlugin(this, flutterView, new PluginDelegate());
        setContentView(flutterView, layout);
    }

    @Override
    protected void onDestroy() {
        if (flutterView != null) {
            flutterView.destroy();
        }
        super.onDestroy();
    }

    @Override
    protected void onPause() {
        super.onPause();
        flutterView.onPause();
    }

    @Override
    protected void onPostResume() {
        super.onPostResume();
        flutterView.onPostResume();
    }

    @Override
    public void onBackPressed() {
        if (flutterView != null) {
            flutterView.popRoute();
            return;
        }
        super.onBackPressed();
    }
}
