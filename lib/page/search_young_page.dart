
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_young_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/loading_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app1/widget/full_screen_page.dart';
class YoungSearchPage extends StatefulWidget{
  String qury="北京";
  YoungSearchPage(String key){
    this.qury=key;
  }

  @override
  _YoungSearchPageState createState()=>_YoungSearchPageState();

}
class _YoungSearchPageState extends State<YoungSearchPage> {
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mYoungResultList = [];


  ImgSearchPageState() {}


  Future getYoungResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getYoungResult, params, (data) {

        List<Data> entityList = OutData.fromJson(data['data']).data;
        mYoungResultList=[];
        for(int i=0;i<entityList.length;i++){
          mYoungResultList.add(entityList[i]);
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

      DioManager.getInstance().get(ServiceUrl.getYoungResult, params, (data) {

        List<Data> entityList = OutData.fromJson(data['data']).data;
        mYoungResultList.addAll(entityList);
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
    getYoungResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getYoungResultList(true);
      });
    });
    getYoungResultList(true);
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
            print("susus"+"滑动到底部");
            Future.delayed(Duration(seconds: 3), () {

              getYoungResultList(false);
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
        itemCount: mYoungResultList.length+1,
        separatorBuilder: (context, index) {
          return Divider(height: 10.0, thickness:10,color: LcfarmColor.dividerColor);
        },
          itemBuilder: (context, index) {

         if (index == mYoungResultList.length) {
              return  Container(
                  height: 40,
                  child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
               );
          } else {
                    if(mYoungResultList[index].imgs.length>0){

                      return ItemImgTitle(
                          title:mYoungResultList[index].title,
                          source:mYoungResultList[index].originalsource,
                      imgUrl: mYoungResultList[index].imgs[0]);
                    }else{
                      return ItemNoImg(
                          title:mYoungResultList[index].title,
                          source:mYoungResultList[index].originalsource);
                    }
          }
                  },
          controller: mScrollController,
                ),
              ),


      ),
    );

  }


  Widget getContentItem(BuildContext context, Data mModel) {
    return Container(
      //  height: 200,

      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 70,
            width: 112,
            child: ClipRRect(
              //  borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
                image: NetworkImage(
                  mModel.imgs[0],
                ),
              ),

            ),
          ),
          Expanded(

            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize :MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Text(mModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: Colors.black)),
                ),
                Container(

                  child: Text(mModel.publishtime,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                  //  margin: EdgeInsets.only(left: 60),
                )

              ],

            ),
          )


        ],


      ),


    );
  }

  Widget getContentItemTxt(BuildContext context, Data mModel) {
    return Container(
      //  height: 200,

      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 70,
            child: Text(mModel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
          ),
          Container(

            child: Text(mModel.publishtime,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            //  margin: EdgeInsets.only(left: 60),
          )


        ],


      ),


    );
  }
}