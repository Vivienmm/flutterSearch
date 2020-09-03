import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/LcfarmColor.dart';
import 'package:flutter_app1/widget/chain_height_without_certi.dart';
import 'package:flutter_app1/widget/chain_view_certi.dart';

class ChainHeightWithCer extends StatefulWidget{
  String height;
  String hashCodePrint;

  String certiUrl;
  ChainHeightWithCer({
    Key key,
    this.height,
    this.hashCodePrint,
    this.certiUrl
  }):super(key:key){
    this.height=this.height;
    this.hashCodePrint=this.hashCodePrint;
  }
  @override
  _ChainHeightWithCerState createState()=> _ChainHeightWithCerState ();
}

class _ChainHeightWithCerState extends State<ChainHeightWithCer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.certiUrl.length<1){
      return ChainHeightWithoutCer(height: widget.height,hashCodePrint: widget.hashCodePrint,);
    }else{
      return Container(
          width: 300,
          height:60 ,
          decoration: BoxDecoration(
            color:  LcfarmColor.chainBgColor.withOpacity(.5),
          ),
          child:Row(

            children: <Widget>[
              ChainCerti(

              ),
              Expanded(

                child:Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                        "区块高度"+widget.height,textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle)
                    ),

                    Text(widget.hashCodePrint,maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle))
                  ],
                ),
              )

            ],
          )



      );
    }
    return Container(
      width: double.infinity,
      height:76 ,
      decoration: BoxDecoration(
        color:  LcfarmColor.chainBgColor.withOpacity(.5),
      ),
      child:Row(
        children: <Widget>[
          ChainCerti(

          ),
          Expanded(
            child:Column(
              children: <Widget>[

                Text(
                    "区块高度"+widget.height,
                    style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle)
                ),

                Text(widget.hashCodePrint,style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorTitle,fontWeight: FontWeight.bold))
              ],
            ),
          )

        ],
      )



    );
  }

}