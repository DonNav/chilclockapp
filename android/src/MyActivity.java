package com.example;

//remplaced in /home/donatien/Qt/6.4.0/android_arm64_v8a/src/android/java/src/org/qtproject/qt/android/bindings/

public class MyActivity extends org.qtproject.qt.android.bindings.QtActivity {
      @Override
      public void onCreate(android.os.Bundle savedInstanceState){
              super.onCreate(savedInstanceState);
              this.getWindow().addFlags(android.view.WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
      }
}
