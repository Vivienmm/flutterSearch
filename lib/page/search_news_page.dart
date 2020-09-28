import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_news_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/commonitem/item_img_des.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/loading_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:webview_flutter_plus/webview_flutter_plus.dart';
class NewsSearchPage extends StatefulWidget{
  String qury="习近平";
  NewsSearchPage(String keyWord){
    this.qury=keyWord;
  }
  @override
  _NewsSearchPageState createState()=> _NewsSearchPageState();

}

class _NewsSearchPageState extends State<NewsSearchPage>{
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mNewsResultList = [];
  List<Lunabox> mHtmlResultList = [];
  String jsAll="";
  bool hasLuna=false;


  NewsSearchPageState() {}


  Future getNewsResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "",
        "order": ""});
      DioManager.getInstance().get(ServiceUrl.getNewsResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;


        if(null!=DataBean.fromJson(data['data']).lunabox){

          List<Lunabox> htmls=DataBean.fromJson(data['data']).lunabox;

          if(null!=htmls&&htmls.length>1){
            hasLuna=true;
            jsAll=
                "<div v-append=\""+htmls[1].cSS+"\"></div> <div v-append=\""+htmls[1].hTML+"\"></div> <div v-append=\""+htmls[1].jS+"\"></div>";
            mHtmlResultList.addAll(htmls);
          }

        }else{
          hasLuna=false;
        }

        mNewsResultList=[];
        for(int i=0;i<entityList.length;i++){
          mNewsResultList.add(entityList[i]);
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
        'start_index': "",
        "order": ""});

      DioManager.getInstance().get(ServiceUrl.getNewsResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        if(null!=DataBean.fromJson(data['data']).lunabox){
          List<Lunabox> htmls=DataBean.fromJson(data['data']).lunabox;
          if(null!=htmls&&htmls.length>1){
            hasLuna=true;
            jsAll=
                "<div v-append=\""+htmls[1].cSS+"\"></div> <div v-append=\""+htmls[1].hTML+"\"></div> <div v-append=\""+htmls[1].jS+"\"></div>";
            mHtmlResultList.addAll(htmls);
          }

        }else{
          hasLuna=false;
        }
        mNewsResultList.addAll(entityList);
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
    getNewsResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getNewsResultList(true);
      });
    });
    getNewsResultList(true);
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

              getNewsResultList(false);
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
    var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;
    return Scaffold(
        body: LoadingContainer(
        isLoading: isRefreshloading,
      child: RefreshIndicator(
        onRefresh: pullToRefresh,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: mNewsResultList.length+1,
          separatorBuilder: (context, index) {
            return Divider(height: 10.0, thickness:10,color: LcfarmColor.dividerColor);
          },
          itemBuilder: (context, index) {
            if (index == mNewsResultList.length) {
              return  Container(
                height: 40,
                child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
              );
            } else {
              if(index==0&&hasLuna){
                hasLuna=false;
                return Html(data: jsAll);

              }else{
                if(mNewsResultList[index].imageList.length>0){

                  if(mNewsResultList[index].snippet.length>0){
                    return ItemImgDes(
                      title:mNewsResultList[index].title,
                      source:mNewsResultList[index].source,
                      imgUrl: mNewsResultList[index].imageList[0],
                      snippet: mNewsResultList[index].snippet,);
                  }else{
                    return ItemImgTitle(
                        title:mNewsResultList[index].title,
                        source:mNewsResultList[index].source,
                        imgUrl: mNewsResultList[index].imageList[0]);
                  }

                }else{
                  return ItemNoImg(
                      title:mNewsResultList[index].title,
                      source:mNewsResultList[index].source);
                }
              }}
          },
          controller: mScrollController,
        ),

      ),
        ),
    );

  }


}