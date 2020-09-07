import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app1/page/AppSearchPage.dart';
import 'package:flutter_app1/page/ImgSearchPage.dart';
import 'package:flutter_app1/page/NewsSearchPage.dart';
import 'package:flutter_app1/page/VideoSearchPage.dart';
import 'package:flutter_app1/page/YoungSearchPage.dart';
import 'package:flutter_app1/page/StorySearchPage.dart';
import 'package:flutter_app1/page/game_search_page.dart';
import 'package:flutter_app1/page/storyen_search_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widget/FullScreenImagePage.dart';
import 'dart:convert';
import 'http/ImgResult.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/widget/SearchAppBarWidget.dart';
import 'package:flutter_app1/page/chain_page_search.dart';
import 'package:flutter/services.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  int _counter = 0;
  List<String> imgList=new List();

  TabController mTabController;
  List<SearchCategory> mTabList = new List();

  FocusNode _focusNode;
  TextEditingController _controller;
  String queryWord="故事";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }


  dioDemo() async{
    try {
      Dio dio = new Dio();
      var response = await dio.get("http://appapitest.chinaso.com/general/v1/search/image?q=%E6%95%85%E4%BA%8B", options:Options(headers: {"user-agent" : "Custom-UA"}));
      final jsonResponse = json.decode(response.toString());
      ImgResult student = ImgResult.fromJson(jsonResponse);
      print("hehe"+student.data.arrRes[1].smallimage.toString());
      for(int i=0;i<student.data.arrRes.length;i++){
        imgList.add(student.data.arrRes[i].smallimage.toString());
      }
      setState(() {});
    }
    catch(e) {
      print('Error:$e');
    }
  }

  DioManagerDemo(){
    DioManager.getInstance().get(ServiceUrl.getImgResult, null, (data) {

      print("susus"+data.toString());
      List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;

      for(int i=0;i<entityList.length;i++){
        imgList.add(entityList[i].smallimage.toString());
      }

      print(entityList.length);
      setState(() {

      });
    }, (error) {
      //ToastUtil.show(error);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTabList.add(new SearchCategory(id: 1, cname: "新闻"));
    mTabList.add(new SearchCategory(id: 2, cname: "图片"));
    mTabList.add(new SearchCategory(id: 3, cname: "视频"));
    mTabList.add(new SearchCategory(id: 4, cname: "青少年"));
    mTabList.add(new SearchCategory(id: 5, cname: "好故事"));
    mTabList.add(new SearchCategory(id: 5, cname: "APP"));
    mTabList.add(new SearchCategory(id: 5, cname: "区块链"));
    mTabList.add(new SearchCategory(id: 5, cname: "游戏"));
    mTabList.add(new SearchCategory(id: 5, cname: "CHina Story"));

    mTabController = TabController(length: mTabList.length, vsync: this);
   // dioDemo();
    DioManager.getInstance().get(ServiceUrl.getImgResult, null, (data) {

      List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;
      for(int i=0;i<entityList.length;i++){
        imgList.add(entityList[i].smallimage.toString());
      }
      setState(() {
        mTabController = TabController(length: mTabList.length, vsync: this);
      });
    }, (error) {
      //ToastUtil.show(error);
    });

    _focusNode = FocusNode();
    _controller = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: new SearchAppBarWidget(
        focusNode: _focusNode,
        controller: _controller,
        elevation: 2.0,
        inputFormatters: [
        LengthLimitingTextInputFormatter(150),
    ],

          onEditingComplete: () {
          print("eventbus-ensd"+_controller.text);
          //发送订阅消息传值
          EventBusUtil.getInstance().fire(PageEvent('${_controller.text}'));
          queryWord=_controller.text;
       print('搜索框输入的内容是： ${_controller.text}');
       setState(() {

    });

       _focusNode.unfocus();
    },

        ),
      body: Container(
        //color: MyColorRes.bgTagColor,
        child: Column(
          children: <Widget>[
            Container(
                child: Center(

                )),
            Container(
              alignment: Alignment.bottomLeft,

              height: 50,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xffF78005),
                  unselectedLabelColor: Color(0xff666666),
                  labelStyle:TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontSize: 16.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: mTabController,
                  tabs: mTabList.map((value) {
                    return Text(value.cname);
                  }).toList()),
            ),

            Expanded(
              flex: 1,
              child: TabBarView(
                children: <Widget>[
                  NewsSearchPage(queryWord),
                  ImgSearchPage(queryWord),
                  VideoSearchPage(queryWord),
                  YoungSearchPage(queryWord),
                  StorySearchPage(queryWord),
                  AppSearchPage(queryWord),
                  ChainSearchPage(queryWord),
                  GameSearchPage(queryWord),
                  StoryEnEnSearchPage(queryWord),
                ],
                controller: mTabController,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
