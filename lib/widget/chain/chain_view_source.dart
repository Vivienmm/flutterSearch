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

    String timeStamp=widget.time+"000";
    DateTime date=DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
    String timePrint=date.year.toString()+"年"+date.month.toString()+"月"+date.day.toString()+"日";
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),

      child: Row(
        children: <Widget>[

          Text(
              widget.source+"·"+timePrint,
              style: TextStyle(fontSize: 11.0, color: LcfarmColor.sourceColor)
          ),

          Flexible(fit: FlexFit.tight, child: SizedBox()),
          Text("反馈",style: TextStyle(fontSize: 11.0, color: LcfarmColor.sourceColor))
        ],
      ),



    );
  }

}