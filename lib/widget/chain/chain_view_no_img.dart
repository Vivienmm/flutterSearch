import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter_app1/widget/chain/chain_height_with_certi.dart';

import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';

import 'chain_trace.dart';
import 'chain_view_source.dart';
class ChainViewNoImg extends StatefulWidget{

  SearchResults result;

  ChainViewNoImg({
    Key key,
    this.result,

  }): super(key: key) {
    this.result = this.result;

  }

  @override
  _ChainViewNoImgState createState() => _ChainViewNoImgState();

}

class _ChainViewNoImgState extends State<ChainViewNoImg> {



  @override
  Widget build(BuildContext context) {
    List<String> traces=[];
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
      if(null!=json['same_urls']){
        var sameUrls = json['same_urls'];
      //  var jsonTrace = jsonDecode(sameUrls);
        traces.add("国搜新闻");
        traces.add("央视新闻");
        //traces = jsonTrace['source'].cast<String>();
      }else{
        traces=[];
      }
      //  cerUrl = json['cert_url'].cast<String>();
    }
    return Container(
        height: 300,
        width: double.infinity,
       // decoration: BoxDecoration(color:Colors.blue),
        child:SingleChildScrollView(
          child:Column(
            children: <Widget>[
             ItemNoImg(
            title:widget.result.title,
            source: widget.result.snippet,
           ),
              ChainViewSource(source: widget.result.source,time: widget.result.publishTimstamp.toString(),),
              ChainHeightWithCer(height:height,hashCodePrint: hashcodePrint,certiUrl: cerUrl,),
              ChainTrace(traces: traces,)
            ],
          ),
        )


    );

  }
}