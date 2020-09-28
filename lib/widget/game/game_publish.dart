import 'package:flutter/material.dart';
import 'package:flutter_app1/util/color_factory.dart';

import '../txt_keyword.dart';

class GamePublisher extends StatefulWidget{
  String publisher;
  String provider;
  String documentNumber;
  String publicationNumber;


  GamePublisher({
    Key key,
    this.publisher,
    this.provider,
    this.documentNumber,
    this.publicationNumber,
  }):super(key:key){
    this.publisher=this.publisher;
    this.provider=this.provider;
    this.documentNumber=this.documentNumber;
    this.publicationNumber=this.publicationNumber;
  }
  @override
  _GamePublishState createState()=> _GamePublishState ();
}

class _GamePublishState extends State<GamePublisher> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: widget.publisher.length>0?20:1.0,
          child:Row(
            children: <Widget>[
              Text("出版：",style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              Text(widget.publisher,maxLines:1,style: TextStyle(fontSize: 12.0, color: LcfarmColor.colorChainBlue)),
            ],
          ),

        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top:10),
          height: widget.provider.length>0?30.0:2.0,
          child:Row(
            children: <Widget>[
              Text("运营：",style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              Text(widget.provider,maxLines:1,style: TextStyle(fontSize: 12.0, color: LcfarmColor.colorChainBlue)),
            ],
          ),

        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top:20),
          height: widget.documentNumber.length>0?40.0:2.0,
          child:
          Text(widget.documentNumber+"   "+widget.publicationNumber,style: TextStyle(fontSize: 12.0, color: Colors.grey)),
        ),
      ],
    );
  }

}