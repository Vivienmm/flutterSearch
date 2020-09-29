import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/chain/chain_height_without_certi.dart';
import 'package:flutter_app1/widget/chain/chain_view_certi.dart';

class ChainTrace extends StatefulWidget{
  List<String> traces;
  ChainTrace({
    Key key,
    this.traces,

  }):super(key:key){
   this.traces=this.traces;
  }
  @override
  _ChainTraceState createState()=> _ChainTraceState ();
}

class _ChainTraceState extends State<ChainTrace> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.traces.length<1){
      return Container(
        height: 1,
        width: double.infinity,
      );
    }else{
      return Container(
          width:  double.infinity,
          height:60 ,
          decoration: BoxDecoration(
            color:  LcfarmColor.chainBgColor.withOpacity(.5),
          ),
          child:Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "溯源新闻： ",
                 style: TextStyle(fontSize: 11.0, color: LcfarmColor.colorTitle)
              ),
              Expanded(

                  child: ListView.builder(

                    physics:NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,

                    itemCount: widget.traces.length,
                    itemBuilder:(context, index){

                      return Container(
                        height: 60,
                        alignment: Alignment.center,
                        child:Text(widget.traces[index]+"  ",style: TextStyle(fontSize: 11.0, color: LcfarmColor.colorChainBlue)) ,
                      );
                    },

                  ),

                ),



              Text(
                  "详情",
                  style: TextStyle(fontSize: 11.0, color: LcfarmColor.colorChainBlue)
              ),

            ],
          )



      );
    }

  }

}