package com.example.flutter_app1.nativeview;



import android.content.Context;



import androidx.annotation.NonNull;

import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.example.flutter_app1.BottomLayout;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static com.example.flutter_app1.nativeview.CCViewPlugin.NATIVE_CCTV_VIEW_TYPE_ID;


/**
 * @author liujc
 * @date 2020/3/28
 * @Description 此处封装原生的TextView给Flutter使用
 */
public class CCTextView implements PlatformView, MethodChannel.MethodCallHandler {

    private final BottomLayout myNativeView;

    CCTextView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
//        TextView myNativeView = new TextView(context);
//        myNativeView.setText("我是来自Android的原生TextView");

        BottomLayout myNativeView=new BottomLayout(context);
        this.myNativeView = myNativeView;
        if (params.containsKey("myContent")) {
            String myContent = (String) params.get("myContent");
            Log.i("suview--",myContent);
           // myNativeView.setText(myContent);
        }
        MethodChannel methodChannel = new MethodChannel(messenger, NATIVE_CCTV_VIEW_TYPE_ID+"_" + id);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public View getView() {
        return myNativeView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {

        System.out.println("CCTextView MethodChannel call.method:"+methodCall.method+ "  call arguments:"+methodCall.arguments);
        if ("setText".equals(methodCall.method)) {
            String text = (String) methodCall.arguments;
            //myNativeView.setText(text);
            result.success("修改成功");
        }
    }

}
