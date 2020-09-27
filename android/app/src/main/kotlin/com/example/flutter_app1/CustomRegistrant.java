package com.example.flutter_app1;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;

class CustomViewRegistrant {

    private static final String TAG = CustomViewRegistrant.class.getName();

    public static void registerWith(PluginRegistry registry) {
        final String key = CustomViewRegistrant.class.getCanonicalName();

        if (registry.hasPlugin(key)) {
            return;
        }
        PluginRegistry.Registrar registrar = registry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("sampleView", new SampleViewFactory(registrar.messenger()));

    }


    public static void registerWith(FlutterEngine flutterEngine, BottomLayout mapView) {
        final String key = CustomViewRegistrant.class.getCanonicalName();
        ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
        if (shimPluginRegistry.hasPlugin(key)) return;
        PluginRegistry.Registrar registrar = shimPluginRegistry.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory("sampleView", new SampleViewFactory(registrar.messenger()));
    }
}
