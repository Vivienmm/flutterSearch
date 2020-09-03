import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/LcfarmColor.dart';

class ChainTitle extends StatefulWidget{
  String title;
  ChainTitle({
    Key key,
    this.title
   }):super(key:key){
    this.title=this.title;
  }
  @override
  _ChainTitleState createState()=> _ChainTitleState ();
}

class _ChainTitleState extends State<ChainTitle> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 107,
      height:60 ,

      child: Row(
          children: <Widget>[
            Image(

              image: AssetImage(Constant.ASSETS_IMG + 'chain_icon.png'),
            ),
            Text(widget.title,style: TextStyle(fontSize: 16.0, color: LcfarmColor.colorTitle,fontWeight: FontWeight.bold))
          ],
        ),



    );
  }

}