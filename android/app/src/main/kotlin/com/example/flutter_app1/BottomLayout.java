package com.example.flutter_app1;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;

public class BottomLayout extends LinearLayout {
    private Context mContext;
    private View view;
    public BottomLayout(Context context) {
        super(context);
        mContext = context;
        intiView();
    }

    public BottomLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContext = context;
        intiView();
    }

    private void intiView() {
        LayoutInflater inflater = LayoutInflater.from(getContext());
        if (view == null) {
            view = inflater.inflate(R.layout.bottom, this);

        }
    }
}
