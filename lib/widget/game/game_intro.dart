import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';

class GameIntro extends StatefulWidget{
  String imgUrl;
  String snippet;

  GameIntro({
    Key key,
    this.imgUrl,
    this.snippet
  }):super(key:key){
    this.imgUrl=this.imgUrl;
    this.snippet=this.snippet;
  }
  @override
  _GameIntroState createState()=> _GameIntroState ();
}

class _GameIntroState extends State<GameIntro> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double widthImg= widget.imgUrl.length>0?112:1.0;
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10,top:10,bottom: 10),
          width: widthImg,
          child:Image(

            width: widthImg,
            height: 112,
              image: NetworkImage(widget.imgUrl)
          ),
        ),
        Expanded(

          child:SelectText(widget.snippet,maxLines:2,style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle)),

        )


      ],
    );
  }

}