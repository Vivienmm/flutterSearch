package com.example.flutter_app1;



import android.os.Bundle;


import com.example.flutter_app1.nativeview.CCViewPlugin;

import io.flutter.embedding.android.FlutterActivity;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);


//        PluginRegistry.Registrar registrar = registrarFor("samples.chenhang/native_views");//生成注册类
//        SampleViewFactory playerViewFactory = new SampleViewFactory(registrar.messenger());//生成视图工厂
//
//        registrar.platformViewRegistry().registerViewFactory("sampleView", playerViewFactory);//注册视图工厂


    }


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine){
      //  GeneratedPluginRegistrant.registerWith(flutterEngine);

//        MapView mapView = new MapView(this);
//        MapRegistrant.registerWith(flutterEngine, mapView);

//        BottomLayout bottomLayout=new BottomLayout(this);
//        CustomViewRegistrant.registerWith(flutterEngine,bottomLayout);



        CCViewPlugin.registerWith(flutterEngine);
        //GeneratedPluginRegistrant.registerWith(flutterEngine);
//        PluginRegistry.Registrar registrar = PluginRegistry.registrarFor("samples.chenhang/native_views");//生成注册类
//        SampleViewFactory playerViewFactory = new SampleViewFactory(registrar.messenger());//生成视图工厂
//
//        registrar.platformViewRegistry().registerViewFactory("sampleView", bottomLayout);//注册视图工厂

    }



}
