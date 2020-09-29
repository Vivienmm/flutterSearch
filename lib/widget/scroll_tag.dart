import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 点击回调 index
typedef TagClick = Function(int index);

/// 自定义tag builder
typedef TagBuilder = Widget Function(BuildContext context, int index);

/// 快速创建tagView
class ScrollTagView extends StatefulWidget {
  /// 内容列表
  final List<String> tags;

  /// margin
  EdgeInsets margin;

  /// padding
  EdgeInsets padding;

  /// 视图总宽度
  final double width;

  /// tag高度
  final double tagHeight;

  /// 文字样式
  TextStyle itemStyle;

  /// 内容文字上下左右间距
  EdgeInsets itemPadding;

  /// tag背景颜色
  Color color;

  /// tagView背景颜色
  Color backgroundColor;

  /// 圆角度数
  final double radius;

  /// tag横向间距
  final double spacing;

  /// tag纵向间距
  final double runSpacing;

  /// 点击回调
  final TagClick onTap;

  /// 自定义Tag
  TagBuilder builder;

  ScrollTagView({
    Key key,
    this.tags,
    this.margin,
    this.padding,
    this.width,
    this.tagHeight,
    this.itemPadding,
    this.itemStyle,
    this.backgroundColor,
    this.radius: 2,
    this.runSpacing: 10,
    this.spacing: 10,
    this.onTap,
    this.color,
    this.builder,
  }) : super(key: key) {
    /// 初始化默认值
    this.itemPadding = this.itemPadding ?? EdgeInsets.fromLTRB(8, 0, 8, 0);
    this.itemStyle = this.itemStyle ??
        TextStyle(color: Color(0xFFF0441C), fontSize: ScreenUtil().setSp(13));
    this.color = this.color ?? ColorsUtil.hexColor(0xfff6eeeb);
    this.padding = this.padding ??
        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10);
  }

  @override
  _ScrollTagViewState createState() => _ScrollTagViewState();
}

class _ScrollTagViewState extends State<ScrollTagView> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.length == 0 || widget.tags == null) return Container();
    return Material(
      color: Colors.transparent,
      child: Container(
          width: MediaQuery.of(context).size.width,
        height:60,
        margin: widget.margin,
        padding: widget.padding,

        child:Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Text('标签', style: TextStyle(color: ColorsUtil.hexColor(0xC47E66), fontSize: 12)),
          Expanded(
              child: new ListView.builder(

            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10.0),
            itemCount: widget.tags.length,
            itemBuilder: (context,position){
              return TagItem(context,position);
            },

          )
          )

         ],
       )

      ),
    );
  }

  Widget TagItem(BuildContext context, int i) {

    return Container(
      alignment: Alignment.center,

      margin: EdgeInsets.only(left: 5,right: 5),
      height: widget.tagHeight,
        child: Text(
         widget.tags[i],
         style: widget.itemStyle,
          ),
       padding: widget.itemPadding,
      decoration: BoxDecoration(
      color: ColorsUtil.hexColor(0xfff6eeeb),
      borderRadius: BorderRadius.circular(widget.radius),
    ),
    );
  }
}
