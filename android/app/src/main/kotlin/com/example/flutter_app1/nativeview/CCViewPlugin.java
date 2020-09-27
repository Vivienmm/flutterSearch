package com.example.flutter_app1.nativeview;




import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;


/**
 * @author liujc
 * @date 2020/3/10
 * @Description 用户注册原生组件
 */
public class CCViewPlugin{

    public static String NATIVE_CCTV_VIEW_TYPE_ID = "com.example.flutter_app1.nativeview/cctextview";//原生控件对应的viewtypeid
    ///
    /// @Params:
    /// @Desc: 兼容1.12以前旧版本
    ///
//    public static void registerWith(PluginRegistry registry) {
//        final String key = AhsNativePlugin.class.getCanonicalName();
//        if (registry.hasPlugin(key)){
//            return;
//        }
//
//        PluginRegistry.Registrar registrar = registry.registrarFor(key);
//        registrar.platformViewRegistry().registerViewFactory(NATIVE_CCTV_VIEW_TYPE_ID, new CCViewFactory(registrar.messenger()));
//    }

    ///
    /// @Params:
    /// @Desc: 新版本注册方式
    ///
    public static void registerWith(FlutterEngine flutterEngine) {
        final String key = CCViewPlugin.class.getCanonicalName();
        ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);

        if (shimPluginRegistry.hasPlugin(key)){
            System.out.println("su--"+"hasPlugin");
            return;
        }else{
            System.out.println("su--"+"no hasPlugin");
            PluginRegistry.Registrar registrar = shimPluginRegistry.registrarFor(key);
            registrar.platformViewRegistry().registerViewFactory(NATIVE_CCTV_VIEW_TYPE_ID, new CCViewFactory(registrar.messenger()));
        }

    }
}