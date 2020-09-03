import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/constant.dart';
import 'package:flutter_app1/util/LcfarmColor.dart';

class ChainCerti extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     width: 107,
     height:60 ,
     alignment: Alignment.center,
     decoration: new BoxDecoration(color:Colors.white,),
      //
     child:Center(
       child:Container(
         width: 50,
         child:Row(
           crossAxisAlignment:  CrossAxisAlignment.center,
           children: <Widget>[
             Image(
               height:19 ,
               width:17 ,
               image: AssetImage(Constant.ASSETS_IMG + 'certi.png'),
             ),
             Text("证书",style: TextStyle(fontSize: 13.0, color: LcfarmColor.colorChainBlue))
           ],
         ),
       )

     ),




   );
  }

}