import 'package:flutter/material.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app1/constant/constant.dart';
class ChainItemNoImg extends StatefulWidget{

  String title;
  String snippt;
  ChainItemNoImg({
    Key key,
    this.title,
    this.snippt
  }): super(key: key) {
    this.title = this.title;
    this.snippt=this.snippt;
  }

  @override
  _ChainItemNoImgState createState() => _ChainItemNoImgState();

}

class _ChainItemNoImgState extends State<ChainItemNoImg> {
  @override
  Widget build(BuildContext context) {

    return Container(
      //  height: 200,
      padding: EdgeInsets.only(top: 15,bottom: 10),
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 48,
            child: SelectText(widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight:FontWeight.w500)),
          ),
          Container(

            child: SelectText(widget.snippt,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.0, color: LcfarmColor.chainTxtColor)),
            //  margin: EdgeInsets.only(left: 60),
          )


        ],


      ),


    );



  }
}