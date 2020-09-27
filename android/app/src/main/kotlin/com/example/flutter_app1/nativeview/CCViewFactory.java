package com.example.flutter_app1.nativeview;



import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @author liujc
 * @date 2020/3/28
 * @Description 用于生成PlatformView
 */
public class CCViewFactory extends PlatformViewFactory {
    /**
     * @param messenger the codec used to decode the args parameter of {@link #create}.
     */
    private final BinaryMessenger messenger;

    public CCViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        return new CCTextView(context, messenger, viewId, params);
    }


}
