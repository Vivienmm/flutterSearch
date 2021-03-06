
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_app_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';
import 'package:flutter_app1/widget/commonitem/item_img_des.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/loading_container.dart';

class AppSearchPage extends StatefulWidget{
  String qury="北京";
  AppSearchPage(String key){
    this.qury=key;
  }

  @override
  _AppSearchPageState createState()=>_AppSearchPageState();

}
class _AppSearchPageState extends State<AppSearchPage> with AutomaticKeepAliveClientMixin{
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mAppResultList = [];


  AppSearchPageState() {}


  Future getAppResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getAppResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mAppResultList=[];
        for(int i=0;i<entityList.length;i++){
          mAppResultList.add(entityList[i]);
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
        'start_index': mCurPage,
        "order": "time"});

      DioManager.getInstance().get(ServiceUrl.getAppResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;

        setState(() {
          mAppResultList.addAll(entityList);
          isloadingMore = false;
          ishasMore = entityList.length >= Constant.PAGE_SIZE;
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
    getAppResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getAppResultList(true);
      });
    });
    getAppResultList(true);
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

              getAppResultList(false);
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
        isLoading:isRefreshloading,
        child: RefreshIndicator(
          onRefresh: pullToRefresh,
          child: new ListView.separated(
            itemCount: mAppResultList.length + 1,
            separatorBuilder: (context, index) {
              return Divider(height: 10.0, thickness:10,color: LcfarmColor.dividerColor);
            },
            itemBuilder: (context, index) {
              if (index == mAppResultList.length) {
                return  Container(
                  height: 40,
                  child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
                );
              } else {
                return getContentItem(context, index, mAppResultList[index]);
              }
            },
            controller: mScrollController,
          ),
        ),
      ),
    );

  }

  Widget getContentItem(BuildContext context, int index, Data mAppResult) {

    int size=mAppResult.searchResults.length>2?2:mAppResult.searchResults.length;

      return Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height:30,
            ),
            Row(
             mainAxisSize: MainAxisSize.min,

              children: <Widget>[

                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:FadeInImage(
                      fit: BoxFit.fitWidth,
                      width: 62,
                      height: 62,
                      placeholder:
                      AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
                      image: NetworkImage(
                        mAppResult.icon,

                      ),
                    ),

                ),
                Container(
                  width: 10,
                ),
                Text(mAppResult.siteName,style: TextStyle(fontSize:16,fontWeight: FontWeight.w400,),),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
          ],
        ),

            ListView.separated(
              shrinkWrap: true,

              physics: new NeverScrollableScrollPhysics(),
              itemCount: size,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1.0, color:Colors.white),
              itemBuilder: (context, index) {

                int imgLength=mAppResult.searchResults[index].imageList.length;
                String timeStamp=mAppResult.searchResults[index].publishTimstamp.toString()+"000";
                DateTime date=DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp));
                String time=date.year.toString()+"年"+date.month.toString()+"月"+date.day.toString()+"日";
                if(imgLength==0){
                  return ItemNoImg(title:mAppResult.searchResults[index].title,
                      source:time);
                }else if(0<imgLength&&imgLength<3){
                  if(mAppResult.searchResults[index].snippet.length>0){
                    return ItemImgDes(
                        title:mAppResult.searchResults[index].title,
                        source:time,
                        imgUrl: mAppResult.searchResults[index].imageList[0],
                        snippet: mAppResult.searchResults[index].snippet);
                  }else{
                    return ItemImgTitle(
                        title:mAppResult.searchResults[index].title,
                        source:time,
                        imgUrl: mAppResult.searchResults[index].imageList[0],
                        );
                  }

                }else{
                  return ItemImgTitle(
                    title:mAppResult.searchResults[index].title,
                    source:time,
                    imgUrl: mAppResult.searchResults[index].imageList[0],
                  );
                }

              },

            ),

            Container(
              alignment: Alignment.center,
              width: 100,

              padding: EdgeInsets.only(top: 10,bottom: 10),
              child:Row(
                children: <Widget>[
                  Text(
                      "查看更多",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey)
                  ),
                  Image(
                    height:12 ,
                    width:12 ,
                    image: AssetImage(Constant.ASSETS_IMG + 'down_more.png'),
                  ),
                ],
              ),
            ),

          ],
        ),
      );


  }

}