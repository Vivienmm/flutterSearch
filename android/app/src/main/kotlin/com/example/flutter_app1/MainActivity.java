package com.example.flutter_app1;



import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.PluginRegistry;


public class MainActivity extends FlutterActivity {

    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        PluginRegistry.Registrar registrar = registrarFor("samples.chenhang/native_views");//生成注册类
        SampleViewFactory playerViewFactory = new SampleViewFactory(registrar.messenger());//生成视图工厂

        registrar.platformViewRegistry().registerViewFactory("sampleView", playerViewFactory);//注册视图工厂


    }




}
