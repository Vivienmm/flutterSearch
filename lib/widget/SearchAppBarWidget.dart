import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app1/widget/SearchAppBarState.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double elevation; //阴影
  final Widget leading;
  final String hintText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final IconData prefixIcon;
  final List<TextInputFormatter> inputFormatters;
  final VoidCallback onEditingComplete;


  const SearchAppBarWidget(
      {Key key,
        this.height: 60.0,
        this.elevation: 0.5,
        this.leading,
        this.hintText: '搜索',
        this.focusNode,
        this.controller,
        this.inputFormatters,
        this.onEditingComplete,
        this.prefixIcon: Icons.search})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new SearchAppBarState();
  }

  ///这里设置控件（appBar）的高度
  @override
  Size get preferredSize => Size.fromHeight(height);
}




