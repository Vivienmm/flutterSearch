
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_block_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/chain/chain_view_adapter.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';
import 'package:flutter_app1/widget/commonitem/item_img_des.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/chain/chain_view_no_img.dart';
import 'package:flutter_app1/widget/loading_container.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';



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
                    return ChainVideoList(context, mChainResultList[index],widget.qury);
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
}

  Widget ChainVideoList (BuildContext context,Data  data,String query) {
  String type;
  if(data.type==1){
    type="-图片";
  }else{
    type="-视频";
  }
  return Container(
    width: double.infinity,
    margin:EdgeInsets.only(left: 10,right: 2),
    child: Column(

      children: <Widget>[
        Container(
//          margin:EdgeInsets.only(top: 10,bottom: 20) ,
        alignment: Alignment.centerLeft,
          child:  SelectText(
              query+type,style:new TextStyle(fontSize: 18,fontWeight: FontWeight.w600,)
          ),
        ),
        Container(
        height: 370,
         width: 400,
        child: ListView.builder(

          scrollDirection: Axis.horizontal,
          itemCount: data.searchResults.length,
          itemBuilder:(context, index){
         return ChainViewAdapter( result:data.searchResults[index]);
    },

    ),
    )
      ],
    ),
  );
//  return Container(
//    height: 400,
//    width: 300,
//    child: ListView.builder(
//
//      scrollDirection: Axis.horizontal,
//      itemCount: data.searchResults.length,
//      itemBuilder:(context, index){
//        return ChainViewAdapter( result:data.searchResults[index]);
//      },
//
//    ),
//  );

}

  Widget ChainNewsList (BuildContext context,Data  data) {
    return Container(
      height:520,
      width: double.infinity,
      margin: EdgeInsets.only(left: 20,right: 20),
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