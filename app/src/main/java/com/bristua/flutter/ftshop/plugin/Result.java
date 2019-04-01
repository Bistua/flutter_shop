package com.bristua.flutter.ftshop.plugin;

import android.support.annotation.Nullable;

public interface Result {
    void success(@Nullable Object var1);

    void error(String var1, @Nullable String var2, @Nullable Object var3);

    void notImplemented();
}
