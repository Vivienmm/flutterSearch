import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app1/constant/constant.dart';
class ItemNoImg extends StatefulWidget{

  String title;
  String source;
  ItemNoImg({
    Key key,
    this.title,
    this.source
  }): super(key: key) {
    this.title = this.title;
    this.source=this.source;
  }

  @override
  _ItemNoImgState createState() => _ItemNoImgState();

}

class _ItemNoImgState extends State<ItemNoImg> {
  @override
  Widget build(BuildContext context) {

    return Container(
      //  height: 200,

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

            child: Text(widget.source,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11.0, color: Colors.grey)),
            //  margin: EdgeInsets.only(left: 60),
          )


        ],


      ),


    );



  }
}