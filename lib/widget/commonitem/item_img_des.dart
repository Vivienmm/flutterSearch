import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app1/constant/constant.dart';
class ItemImgDes extends StatefulWidget{

  String title;
  String imgUrl;
  String source;
  String snippet;
  ItemImgDes({
    Key key,
    this.title,
    this.imgUrl,
    this.source,
    this.snippet
  }): super(key: key) {
    this.title = this.title;
    this.imgUrl=this.imgUrl;
    this.source=this.source;
    this.snippet=this.snippet;
  }

  @override
  _ItemImgDesState createState() => _ItemImgDesState();

}

class _ItemImgDesState extends State<ItemImgDes> {
  @override
  Widget build(BuildContext context) {

    return Container(
        //  height: 200,
      padding: EdgeInsets.only(top: 15,bottom: 5),
        child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          Container(
        padding: EdgeInsets.only(bottom: 15),
          child: SelectText(widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight:FontWeight.w500)),
         ),
          Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize :MainAxisSize.max,
          children: <Widget>[
            Container(
            height: 70,
            width: 112,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
                image: NetworkImage(
                widget.imgUrl,
                  ),
                ),

              ),
            ),
            Expanded(

              child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize :MainAxisSize.max,
              children: <Widget>[
                Container(
                height: 50,
                  padding: EdgeInsets.only(left: 15),
                  child: SelectText(widget.snippet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
                ),

                ],

              ),
            ),

            ],


          ),Container(
            padding: EdgeInsets.only(top: 15,bottom: 0),
            child: Text(widget.source,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11.0, color: Colors.grey)),
            //  margin: EdgeInsets.only(left: 60),
            ),

        ],
        ),

    );


  }
}