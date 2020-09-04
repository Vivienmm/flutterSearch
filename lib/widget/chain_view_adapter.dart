import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter_app1/widget/chain_height_with_certi.dart';
import 'chain_view_source.dart';
import 'package:flutter_app1/public.dart';
class ChainViewAdapter extends StatefulWidget{

  SearchResults result;

  ChainViewAdapter({
    Key key,
    this.result,

  }): super(key: key) {
    this.result = this.result;

  }

  @override
  _ChainViewAdapterState createState() => _ChainViewAdapterState();

}

class _ChainViewAdapterState extends State<ChainViewAdapter> {



  @override
  Widget build(BuildContext context) {
    String height,hashcodePrint,cerUrl;
    if (widget.result.extend != null && widget.result.extend.length > 0) {
      //先转json
      var json = jsonDecode(widget.result.extend);
      height = json['height'];
      hashcodePrint = json['hashcode'];
      if(null!=json['cert_url']){
        cerUrl = json['cert_url'];
      }else{
        cerUrl="";
      }
    //  cerUrl = json['cert_url'].cast<String>();
    }
    return Container(
      height: 360,
      width: 300,
      child:SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              height: 210,
              width: 300,
              margin: EdgeInsets.only(left: 10, right: 2.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.result.imageList[0]))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topRight,
                        child:Container(
                          margin: EdgeInsets.only(top: 3),
                          decoration: BoxDecoration(
                            color:  Colors.black.withOpacity(.5),
//                        image: DecorationImage(
//                          fit:BoxFit.fill ,
//                          image: AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
//
                          ),
                          child: Text(
                              "图片溯源",
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                        )
                    ),
                    Flexible(fit: FlexFit.tight, child: SizedBox()),//这个是实现一个左对齐，一个右对齐的关键
                    Align(
                        alignment: Alignment.bottomLeft,
                        child:Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                              widget.result.title,
                              style: TextStyle(fontSize: 16, color: Colors.white)),
                        )
                    ),

                  ]
              ),

            ),
            ChainViewSource(source: widget.result.source,time: widget.result.publishTimstamp.toString(),),
            ChainHeightWithCer(height:height,hashCodePrint: hashcodePrint,certiUrl: cerUrl,)
          ],
        ),
      )


    );

  }
}