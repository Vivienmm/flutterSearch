import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app1/widget/SearchAppBarWidget.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_app1/widget/MoreWidgets.dart';
import 'package:flutter_app1/constant/constant.dart';


class SearchAppBarState extends State<SearchAppBarWidget> {
  bool _hasDeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    return new PreferredSize(
      child: new Stack(
        children: <Widget>[
          Offstage(
            offstage: false,
            child:
            MoreWidgets.buildAppBar(context, '', leading: widget.leading),
          ),
          Offstage(
            offstage: false,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(left:60,top: 40,right: 40),
                    padding: const EdgeInsets.only(left: 2.0, top: 5.0),
                    alignment: Alignment.centerLeft,
                    width: 300,
//边框设置
                    decoration: new BoxDecoration(
//背景
                      color: Colors.white,
                      //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      //设置四周边框
                      border: new Border.all(width: 1, color: Colors.red),
                    ),
                    child: Container(
                //设置 child 居中
                      alignment: Alignment(0, 0),
                      height: 20,
                      width: 200,
                      child: new TextField(
                      focusNode: widget.focusNode,

                      /// 键盘类型
                      keyboardType: TextInputType.text,

                      ///控制键盘的功能键 指enter键，比如此处设置为next时，enter键
                      textInputAction: TextInputAction.search,
                      controller: widget.controller,
                      maxLines: 1,
                      inputFormatters: widget.inputFormatters,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        suffixIcon: Container(
                          padding: EdgeInsetsDirectional.only(
                            start: 2.0,
                            end: _hasDeleteIcon ? 0.0 : 0,
                          ),
                          child: _hasDeleteIcon
                              ? new InkWell(
                            onTap: (() {
                              print("bar--InkWell--tap");
                              setState(() {
                                /// 保证在组件build的第一帧时才去触发取消清空内容
                                WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.clear());
                                _hasDeleteIcon = false;
                              });
                            }),
                            child: Icon(
                              Icons.cancel,
                              size: 18.0,
                              color: Colors.grey,
                            ),
                          )
                              : new Text('取消'),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                        filled: true,
                        fillColor: ColorsUtil.hexColor(0xffffff),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (str) {


                        setState(() {

                          if (str.isEmpty) {
                            _hasDeleteIcon = false;
                          } else {
                            _hasDeleteIcon = true;
                          }
                        });
                      },

                      onEditingComplete: widget.onEditingComplete,
                    ),
                    ),
                  ),
                ),

                /// 取消按钮
//                InkWell(
//                  child: Container(
//                    alignment: Alignment.center,
//                    padding: EdgeInsets.only(top: 36, left: 10, right: 10),
//                    child: Text(
//                      '取消',
//                      style: TextStyle(
//                        fontSize: 18,
//                      ),
//                    ),
//                  ),
//                  onTap: () {
////                      Navigator.of(context).pop();
//                  },
//                ),
              ],
            ),
          ),
          /// 搜索图标 （可以在TextField  prefixIcon 可以直接定义icon）
          Positioned(
            left: 16,
            top: 44,
            child: Image.asset(
              Constant.ASSETS_IMG + 'search_bar_icon.png',
              width: 28,
              height: 28,
//              image: AssetImage(
//              //  "assets/images/Icon/btn_seach@2x.png",
//                Constant.ASSETS_IMG + 'img_default2.jpeg'
//              ),
             // color: ColorsUtil.hexColor(0x333333),
            ),
          ),
        ],
      ),
      preferredSize: Size.fromHeight(widget.height),
    );
  }
}


