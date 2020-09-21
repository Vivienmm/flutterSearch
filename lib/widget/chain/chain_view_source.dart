import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/color_factory.dart';

class ChainViewSource extends StatefulWidget{
  String source;
  String time;

  ChainViewSource({
    Key key,
    this.source,
    this.time
  }):super(key:key){
    this.source=this.source;
    this.time=this.time;
  }
  @override
  _ChainViewSourceState createState()=> _ChainViewSourceState ();
}

class _ChainViewSourceState extends State<ChainViewSource> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height:76 ,
      decoration: BoxDecoration(
        color:  LcfarmColor.chainBgColor.withOpacity(.5),
      ),
      child: Row(
        children: <Widget>[

          Text(
              widget.source+"."+widget.time.toString(),
              style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle)
          ),

          Flexible(fit: FlexFit.tight, child: SizedBox()),
          Text("反馈",style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle,fontWeight: FontWeight.bold))
        ],
      ),



    );
  }

}