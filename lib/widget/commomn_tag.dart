import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 点击回调 index
typedef TagClick = Function(int index);

/// 自定义tag builder
typedef TagBuilder = Widget Function(BuildContext context, int index);

/// 快速创建tagView
class TagView extends StatefulWidget {
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

  TagView({
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
    this.itemPadding = this.itemPadding ?? EdgeInsets.fromLTRB(5, 2, 5, 2);
    this.itemStyle = this.itemStyle ??
        TextStyle(color: Color(0xFFF0441C), fontSize: ScreenUtil().setSp(12));
    this.color = this.color ?? Color.fromRGBO(254, 237, 233, 1);
    this.padding = this.padding ??
        EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10);
  }

  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  Widget build(BuildContext context) {
    if (widget.tags.length == 0 || widget.tags == null) return Container();
    return Material(
      color: Colors.transparent,
      child: Container(
        width: widget.width,
        color: widget.backgroundColor,
        margin: widget.margin,
        padding: widget.padding,
        child: Wrap(
          spacing: widget.spacing,
          runSpacing: widget.runSpacing,
          children: widget.tags.map((res) {
            int i = widget.tags.indexOf(res);
            return GestureDetector(
              onTap: widget.onTap == null
                  ? null
                  : () {
                if (widget.onTap != null) {
                  widget.onTap(i);
                }
              },
              child: widget.builder != null
                  ? Builder(
                builder: (context) {
                  return widget.builder(context, i);
                },
              )
                  : Row(
                /// 为了处理container中设置了alignment宽度无限大的问题，这里使用row来包裹
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: widget.tagHeight,
                    child: Text(
                      widget.tags[i],
                      style: widget.itemStyle,
                    ),
                    padding: widget.itemPadding,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
