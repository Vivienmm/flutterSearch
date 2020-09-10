import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app1/constant/constant.dart';
class ItemImgTitle extends StatefulWidget{

  String title;
  String imgUrl;
  String source;
  ItemImgTitle({
    Key key,
    this.title,
    this.imgUrl,
    this.source
  }): super(key: key) {
    this.title = this.title;
    this.imgUrl=this.imgUrl;
    this.source=this.source;
  }

   @override
  _ItemImgTitleState createState() => _ItemImgTitleState();

}

class _ItemImgTitleState extends State<ItemImgTitle> {
  @override
  Widget build(BuildContext context) {

    return Container(
      //  height: 200,

      child: Row(
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
          )


        ],


      ),


    );
  }
}