package com.example.flutter_app1;


import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

//视图工厂类
class SampleViewFactory extends PlatformViewFactory {


    private final BinaryMessenger messenger;
    //初始化方法
    public SampleViewFactory(BinaryMessenger msger) {
        super(StandardMessageCodec.INSTANCE);
        messenger = msger;
    }


    //创建原生视图封装类，完成关联
    @Override
    public PlatformView create(Context context, int id, Object obj) {
        return new SimpleViewControl(context, id, messenger);
    }
}

//原生视图封装类
class SimpleViewControl implements PlatformView {
    private final View view;//缓存原生视图
    //初始化方法，提前创建好视图
    public SimpleViewControl(Context context, int id, BinaryMessenger messenger) {
        view = new BottomLayout(context);


       // view.setBackgroundColor(Color.rgb(255, 0, 0));
    }

    //返回原生视图
    @Override
    public View getView() {
        return view;
    }
    //原生视图销毁回调
    @Override
    public void dispose() {
    }
}