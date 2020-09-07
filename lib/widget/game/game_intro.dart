import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/LcfarmColor.dart';

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
          width: widthImg,
          child:Image(

            width: widthImg,
            height: 112,
              image: NetworkImage(widget.imgUrl)
          ),
        ),
        Expanded(

          child:Text(widget.snippet,maxLines:2,style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle)),

        )


      ],
    );
  }

}