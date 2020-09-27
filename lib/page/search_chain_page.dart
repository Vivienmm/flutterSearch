
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/chain/chain_view_adapter.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/item_no_img.dart';
import 'package:flutter_app1/widget/commonitem/item_img_des.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/chain/chain_view_no_img.dart';
import 'package:flutter_app1/widget/loading_container.dart';



class ChainSearchPage extends StatefulWidget{
  String qury="北京";
  ChainSearchPage(String key){
    this.qury=key;
  }

  @override
  _ChainSearchPageState createState()=>_ChainSearchPageState();

}
class _ChainSearchPageState extends State<ChainSearchPage>with AutomaticKeepAliveClientMixin {
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mChainResultList = [];


  ChainSearchPageState() {}


  Future getChainResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
//        'start_index': "$mCurPage",
        });
      DioManager.getInstance().get(ServiceUrl.getChainResult, params, (data) {

        List<Data> entityList = search_block_entity.fromJson(data).data;
        mChainResultList=[];
        for(int i=0;i<entityList.length;i++){
          mChainResultList.add(entityList[i]);
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
//        'start_index': mCurPage,
      });

      DioManager.getInstance().get(ServiceUrl.getChainResult, params, (data) {

        List<Data> entityList = search_block_entity.fromJson(data).data;
        mChainResultList.addAll(entityList);
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
    getChainResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getChainResultList(true);
      });
    });
    getChainResultList(true);
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

              getChainResultList(false);
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
        isLoading:  isRefreshloading ,
        child: RefreshIndicator(
          // key: _refreshIndicatorKey,

          onRefresh: pullToRefresh,
          child: new ListView.builder(
            itemCount: mChainResultList.length + 1,
            itemBuilder: (context, index) {
              if (index == mChainResultList.length) {
                return  Container(
                  height: 40,
                  child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
                );
              } else {
                //return getContentItem(context, index, mChainResultList[index]);
                if(mCurPage==1){
                  if (mChainResultList[index].type == 1 ||
                      mChainResultList[index].type == 2) {
                    return ChainVideoList(context, mChainResultList[index]);
                    //return ChainViewAdapter( result:mChainResult.searchResults[index]);
                  } else {
                    return ChainNewsList(context, mChainResultList[index]);
                  }
                }else{
                  return ChainNewsList(context, mChainResultList[index]);
                }

              }
            },
            controller: mScrollController,
          ),
        ),
      ),
    );

  }

  Widget getContentItem(BuildContext context, int index, Data mChainResult) {



    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height:30,

          ),

          ListView.separated(
            shrinkWrap: true,

            physics: new NeverScrollableScrollPhysics(),
            itemCount: mChainResult.searchResults.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 1.0, color:Colors.grey),
            itemBuilder: (context, index) {
              if(mChainResult.type==1||mChainResult.type==2){
                return ChainVideoList(context,mChainResult);
                //return ChainViewAdapter( result:mChainResult.searchResults[index]);
              }else{
                return ChainNewsList(context, mChainResult);
              }

//              if(mChainResult.type==0&&mChainResult.searchResults[index].imageList.length>0){
//                return ItemImgTitle(title:mChainResult.searchResults[index].title,imgUrl: mChainResult.searchResults[index].imageList[0],);
//              }else if(mChainResult.type==0&&mChainResult.searchResults[index].imageList.length==0){
//                return ItemNoImg(
//                  title: mChainResult.searchResults[index].title,
//                  source: mChainResult.searchResults[index].source,
//                );
//              }

            },

          ),
          Divider(height: 1.0,indent: 60.0,color: Colors.grey,),

          Text(
              "查看更多"
          ),
          Container(
            height: 20,
            color: ColorsUtil.hexColor(0xF9F9F9),
          ),
        ],
      ),
    );


  }


  Widget ChainVideoList (BuildContext context,Data  data) {
    return Container(
      height: 400,
      width: 300,
      child: ListView.builder(

        scrollDirection: Axis.horizontal,
        itemCount: data.searchResults.length,
        itemBuilder:(context, index){
          return ChainViewAdapter( result:data.searchResults[index]);
        },

      ),
    );

  }


}

Widget ChainVideoList (BuildContext context,Data  data) {
  return Container(
    height: 300,
    width: 300,
    child: ListView.builder(

      scrollDirection: Axis.horizontal,
      itemCount: data.searchResults.length,
      itemBuilder:(context, index){
        return ChainViewAdapter( result:data.searchResults[index]);
      },

    ),
  );

}

  Widget ChainNewsList (BuildContext context,Data  data) {
    return Container(
      height:500,
      width: double.infinity,
      child: ListView.builder(
        physics:NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: data.searchResults.length,
        itemBuilder:(context, index){
          return ChainViewNoImg(result:data.searchResults[index]);
        },

      ),
    );

  }