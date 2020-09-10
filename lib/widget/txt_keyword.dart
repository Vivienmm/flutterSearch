import 'package:flutter/cupertino.dart';

class SelectText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Axis direction;
  final int maxLines;
  final TextOverflow overflow;

  const SelectText(
      this.text, {
        Key key,
        this.maxLines,
        this.textAlign,
        this.overflow = TextOverflow.ellipsis,
        this.direction = Axis.horizontal,
        this.style,
      })  : assert(direction != null),
        assert(overflow != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    if (text.contains("<em>")) {
      list = getTextList(text);
    } else {
      list.add(text);
    }
    print("wangyana========" + list.toString() + "nishisha?=====" + text);
    if (list != null && list.length > 2) {
      return RichText(
        text: TextSpan(
            text: list[0],
            style: TextStyle(
              color: style == null ? null : style.color,
              fontSize: style == null ? null : style.fontSize,
              fontWeight: style == null ? null : style.fontWeight,
            ),
            children: [
              TextSpan(
                text: list[1],
                style: TextStyle(
                    color: Color(0xFFE71F26),
                    fontSize: style == null ? null : style.fontSize,
                    fontWeight: style == null ? null : style.fontWeight),
              ),
              TextSpan(
                text: list[2],
                style: TextStyle(
                    color: style == null ? null : style.color,
                    fontSize: style == null ? null : style.fontSize,
                    fontWeight: style == null ? null : style.fontWeight),
              ),
            ]),
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.clip,
        textAlign: textAlign ??
            (direction == Axis.horizontal ? TextAlign.start : TextAlign.center),
      );
    } else if (list != null && list.length == 2) {
      if (text.startsWith("<")) {
        return RichText(
          text: TextSpan(
              text: list[0],
              style: TextStyle(
                color: Color(0xFFE71F26),
                fontSize: style == null ? null : style.fontSize,
                fontWeight: style == null ? null : style.fontWeight,
              ),
              children: [
                TextSpan(
                  text: list[1],
                  style: TextStyle(
                      color: style == null ? null : style.color,
                      fontSize: style == null ? null : style.fontSize,
                      fontWeight: style == null ? null : style.fontWeight),
                ),
              ]),
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.clip,
          textAlign: textAlign ??
              (direction == Axis.horizontal
                  ? TextAlign.start
                  : TextAlign.center),
        );
      } else {
        return RichText(
          text: TextSpan(
              text: list[0],
              style: TextStyle(
                color: style == null ? null : style.color,
                fontSize: style == null ? null : style.fontSize,
                fontWeight: style == null ? null : style.fontWeight,
              ),
              children: [
                TextSpan(
                  text: list[1],
                  style: TextStyle(
                      color: Color(0xFFE71F26),
                      fontSize: style == null ? null : style.fontSize,
                      fontWeight: style == null ? null : style.fontWeight),
                ),
              ]),
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.clip,
          textAlign: textAlign ??
              (direction == Axis.horizontal
                  ? TextAlign.start
                  : TextAlign.center),
        );
      }
    } else {
      return Text(
        list[0],
        textAlign: TextAlign.left,
        style: TextStyle(
            color: style == null ? null : style.color,
            fontSize: style == null ? null : style.fontSize,
            fontWeight: style == null ? null : style.fontWeight),
        maxLines: 3,
      );
    }
  }

  List<String> getTextList(String text) {
    List<String> list = [];
    if (text.startsWith("<")) {
      String str1 = text.split("<em>")[1].split("</em>")[0];
      String str2 = text.split("<em>")[1].split("</em>")[1];
      list.add(str1);
      list.add(str2);
    } else if (text.endsWith(">")) {
      String str2 = text.split("</em>")[0].split("<em>")[1];
      String str1 = text.split("</em>")[1].split("<em>")[0];
      list.add(str1);
      list.add(str2);
    } else {
      String str1 = text.split("<em>")[0];
      String str2 = text.split("<em>")[1].split("</em>")[0];
      String str3 = text.split("<em>")[1].split("</em>")[1];
      list.add(str1);
      list.add(str2);
      list.add(str3);
    }
    return list;
  }
}