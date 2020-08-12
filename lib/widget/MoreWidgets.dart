
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 控件点击时触发
typedef OnItemDoubleClick = Future<void> Function(Object);
class MoreWidgets {

  static Widget buildAppBar(
      BuildContext context,
      String text, {
        double fontSize: 18.0,
        double height: 50.0,
        double elevation: 0.5,
        Widget leading,
        bool centerTitle: false,
        List<Widget> actions,
        OnItemDoubleClick onItemDoubleClick,
      }) {
    return PreferredSize(
      child: GestureDetector(
          onDoubleTap: () {
            if (null != onItemDoubleClick) {
              onItemDoubleClick(null);
            }
          },
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: elevation,
            //阴影
            centerTitle: centerTitle,
            title: Text(text, style: TextStyle(fontSize: fontSize)),
            leading: leading,
            actions: actions,
          )),
      preferredSize: Size.fromHeight(height),
    );
  }
}