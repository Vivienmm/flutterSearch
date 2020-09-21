import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app1/page/search_app_page.dart';
import 'package:flutter_app1/page/search_img_page.dart';
import 'package:flutter_app1/page/search_news_page.dart';
import 'package:flutter_app1/page/search_video_page.dart';
import 'package:flutter_app1/page/search_young_page.dart';
import 'package:flutter_app1/page/search_story_page.dart';
import 'package:flutter_app1/page/search_game_page.dart';
import 'package:flutter_app1/page/search_storyen_page.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/chinaso_search_bar.dart';
import 'package:flutter_app1/widget/chinaso_search_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'native/sample_view.dart';
import 'widget/full_screen_page.dart';
import 'dart:convert';
import 'model/search_img_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/widget/SearchAppBarWidget.dart';
import 'package:flutter_app1/page/search_chain_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ThemeData kIOSTheme = ThemeData( brightness: Brightness.light,//亮色主题
       accentColor: Colors.white,//(按钮)Widget前景色为白色
      primaryColor: Colors.blue,//主题色为蓝色
      iconTheme:IconThemeData(color: Colors.grey),//icon主题为灰色
      textTheme: TextTheme(body1: TextStyle(color: Colors.black))//文本主题为黑色
       );
  final ThemeData kAndroidTheme = ThemeData( brightness: Brightness.light,//深色主题
       accentColor: LcfarmColor.themeColor,//(按钮)Widget前景色为黑色
       primaryColor: Colors.cyan,//主题色Wie青色
      iconTheme:IconThemeData(color: Colors.blue),//icon主题色为蓝色
      textTheme: TextTheme(body1: TextStyle(color: LcfarmColor.colorTitle))//文本主题色为红色
      );
  ThemeData defaultTargetPlatform;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kAndroidTheme,//根据平台选择不同主题
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
  String queryWord="习近平";
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
    mTabList.add(new SearchCategory(id: 5, cname: "China Story"));

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
        appBar: new CsSearchBar(
        focusNode: _focusNode,
        controller: _controller,
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
              alignment: Alignment.bottomLeft,

              height: 50,
              child: TabBar(
                  isScrollable: true,
                  indicator: RoundUnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3.5,
                        color:LcfarmColor.themeColor,
                      )
                  ),
                  indicatorColor: LcfarmColor.themeColor,
                  labelColor: Color(0xff222222),
                  unselectedLabelColor: Color(0xff555555),
                  labelStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(fontSize: 16.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,

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
            Container(
                child: Center(
                  child:Container(
                    width: double.infinity, height:50,
                    child:SampleView() ,
                  ),
                )),
          ],
        ),
      ),
    );
  }


}
