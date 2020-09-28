import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';

class GameTitle extends StatefulWidget{
  String title;
  bool isShow;
  GameTitle({
    Key key,
    this.title,
    this.isShow
}):super(key:key){
    this.title=this.title;
    this.isShow=this.isShow;
  }
  @override
  _GameTitleState createState()=> _GameTitleState ();
}

class _GameTitleState extends State<GameTitle> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double widthImg= widget.isShow?0.0:16.0;
   return Row(
     children: <Widget>[
       SelectText(widget.title,maxLines:2,style: TextStyle(fontSize: 16.0, color: LcfarmColor.colorTitle,fontWeight: FontWeight.bold)),
       Container(
         width: widthImg,
         child:Image(
           image: AssetImage(Constant.ASSETS_IMG + 'game_icon.png'),
         ),
       )

     ],
   );
  }

}