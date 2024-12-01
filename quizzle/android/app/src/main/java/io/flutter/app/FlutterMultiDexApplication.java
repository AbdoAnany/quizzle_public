package io.flutter.app;

import androidx.multidex.MultiDexApplication;
import android.content.Context;
import androidx.multidex.MultiDex;

public class FlutterMultiDexApplication extends MultiDexApplication {
  @Override
  protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);
    MultiDex.install(this);
  }
}