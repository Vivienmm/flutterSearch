import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/color_factory.dart';

class ChainHeightWithoutCer extends StatefulWidget{
  String height;
  String hashCodePrint;

  ChainHeightWithoutCer({
    Key key,
    this.height,
    this.hashCodePrint
  }):super(key:key){
    this.height=this.height;
    this.hashCodePrint=this.hashCodePrint;
  }
  @override
  _ChainHeightWithoutCerState createState()=> _ChainHeightWithoutCerState ();
}

class _ChainHeightWithoutCerState extends State<ChainHeightWithoutCer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 8,left: 8,bottom: 8,right: 8),

      decoration: BoxDecoration(
        color:  LcfarmColor.chainBgColor.withOpacity(.9),
      ),
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.start,
        children: <Widget>[

          Text(
            "区块高度: "+widget.height,textAlign: TextAlign.left,
              style: TextStyle(fontSize: 13.0, color: LcfarmColor.chainTxtColor)
          ),
          Container(
            height: 12,
          ),
          Row(
            children: <Widget>[
              Text(
                  "指纹认证: ",
                  style: TextStyle(fontSize: 13.0, color: LcfarmColor.chainTxtColor)
              ),
              Expanded(
                child: Text(widget.hashCodePrint,textAlign: TextAlign.left,maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorChainBlue))
                ,
              )
            ],
          )
        ],
      ),



    );
  }

}