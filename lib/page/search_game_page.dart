import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_games_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/item_no_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/game/game_intro.dart';
import 'package:flutter_app1/widget/game/game_publish.dart';
import 'package:flutter_app1/widget/game/game_title.dart';
import 'package:flutter_app1/widget/loading_container.dart';

class GameSearchPage extends StatefulWidget{
  String qury="北京";
  GameSearchPage(String keyWord){
    this.qury=keyWord;
  }
  @override
  _GameSearchPageState createState()=> _GameSearchPageState();

}

class _GameSearchPageState extends State<GameSearchPage>with AutomaticKeepAliveClientMixin{
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mGameResultList = [];


  GameSearchPageState() {}


  Future getGameResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        });
      DioManager.getInstance().get(ServiceUrl.getGameResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mGameResultList=[];
        for(int i=0;i<entityList.length;i++){
          mGameResultList.add(entityList[i]);
        }

        setState(() {
          isRefreshloading = false;

        });
      }, (error) {
        isRefreshloading = false;

      });
    } else {
      FormData params =
      FormData.fromMap({
        "q":widget.qury,

       });
      DioManager.getInstance().get(ServiceUrl.getGameResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mGameResultList.addAll(entityList);
        isloadingMore = false;
        ishasMore = entityList.length >= Constant.PAGE_SIZE;
        setState(() {

        });
      }, (error) {
        setState(() {
          isloadingMore = false;
          ishasMore = false;
        });
      });
    }
  }
  Widget _buildLoadMore() {
    return isloadingMore
        ? Container(
        height: 20,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      height: 12.0,
                      width: 12.0,
                    ),
                  ),
                  Text("加载中..."),
                ],
              )),
        ))
        : new Container(
      child: ishasMore
          ? new Container()
          : Center(
          child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "没有更多数据",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ))),
    );
  }


  Future pullToRefresh() async {
    getGameResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getGameResultList(true);
      });
    });
    getGameResultList(true);
    mScrollController.addListener(() {

      var maxScroll = mScrollController.position.maxScrollExtent;
      var pixels = mScrollController.position.pixels;
      if (maxScroll == pixels) {
        if (!isloadingMore) {
          if (ishasMore) {
            setState(() {
              isloadingMore = true;
              mCurPage += 1;
            });

            Future.delayed(Duration(seconds: 3), () {

              getGameResultList(false);
            });
          } else {
            setState(() {
              ishasMore = false;
            });
          }
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: LoadingContainer(
          isLoading: isRefreshloading,
          child: RefreshIndicator(
            // key: _refreshIndicatorKey,

            onRefresh: pullToRefresh,

                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mGameResultList.length+1,
                  itemBuilder: (context, index) {
                  if (index == mGameResultList.length) {
                  return  Container(
                    height: 40,
                    child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
                    );
                  } else {
                    return getContentItem(context, mGameResultList[index]);}
                  },
                  controller: mScrollController,
                ),
              ),

            ),


    );

  }


  Widget getContentItem(BuildContext context, Data mModel) {
    bool isShowCe=true;
    String publisher="";
    String provider="";
    String documentNumber="";
    String publicationNumber="";
    String description="";
    if (mModel.extend != null && mModel.extend.length > 0) {
      //先转json
      var json = jsonDecode(mModel.extend);
      if(null!=json['publisher']){
        publisher = json['publisher'];
      }
      if(null!=json['document_number']){
        documentNumber = json['document_number'];
      }
      if(null!=json['service_provider']){
        provider = json['service_provider'];
      }
      if(null!=json['publication_number']){
        publicationNumber = json['publication_number'];
      }
      if(null!=json['description']){
        description = json['description'];
      }

    }
    String imgUrl="";
    if(null!=mModel.imageList&&mModel.imageList.length>0){
      imgUrl=mModel.imageList[0];
    }
    return Container(

      child: Column(
        children: <Widget>[
          new GameTitle(title:mModel.title,isShow: isShowCe),
          new GameIntro(imgUrl:imgUrl ,snippet: description,),
          new GamePublisher(publisher: publisher,publicationNumber: publicationNumber,provider: provider,documentNumber: documentNumber,)
        ],


      ),


    );
  }



}