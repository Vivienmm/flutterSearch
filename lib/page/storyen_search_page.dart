
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_en_story_entity.dart';
import 'package:flutter_app1/util/ColorsUtil.dart';
import 'package:flutter_app1/widget/ScrollTagView.dart';
import 'package:flutter_app1/widget/ItemImgTitle.dart';
import 'package:flutter_app1/widget/ItemNoImg.dart';
import 'package:flutter_app1/widget/ItemImgDes.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/loading_container.dart';
class StoryEnEnSearchPage extends StatefulWidget{
  String qury="北京";
  StoryEnEnSearchPage(String key){
    this.qury=key;
  }

  @override
  _StoryEnEnSearchPageState createState()=>_StoryEnEnSearchPageState();

}
class _StoryEnEnSearchPageState extends State<StoryEnEnSearchPage> with AutomaticKeepAliveClientMixin{
  bool isRefreshloading=true;
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mStoryEnResultList = [];


  StoryEnSearchPageState() {}


  Future getStoryEnResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getEnResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mStoryEnResultList=[];
        for(int i=0;i<entityList.length;i++){
          mStoryEnResultList.add(entityList[i]);
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

      DioManager.getInstance().get(ServiceUrl.getEnResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mStoryEnResultList.addAll(entityList);
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
    getStoryEnResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {

      widget.qury=data.test;
      setState(() {
        getStoryEnResultList(true);
      });
    });
    getStoryEnResultList(true);
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

              getStoryEnResultList(false);
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
          // key: _refreshIndicatorKey,

          onRefresh: pullToRefresh,
          child: ListView.builder(
            shrinkWrap: true,

            //physics: new NeverScrollableScrollPhysics(),
            itemCount: mStoryEnResultList.length+1,
            itemBuilder: (context, index) {

              int imgLength=mStoryEnResultList[index].imageList.length;


              if(imgLength==0){
                return getContentItemTxt(context, mStoryEnResultList[index]);
              }else if(0<imgLength&&imgLength<3){
                if(mStoryEnResultList[index].snippet.length>0){
                  return getContentItemImgDes(context, mStoryEnResultList[index]);
                }else{
                  return getContentItemImgNoDes(context, mStoryEnResultList[index]);
                }

              }else{
                return getContentItemImgs(context, mStoryEnResultList[index]);
              }

            },
            controller: mScrollController,
          ),
        ),

      ),

    );

  }


  Widget getContentItemImgNoDes(BuildContext context, Data mModel) {
    List<String> tags=[];
    if (mModel.extend != null && mModel.extend.length > 0) {
      //先转json
      var json = jsonDecode(mModel.extend);
      tags = json['tags'].cast<String>();
    }
    return Container(
      //  height: 200,
      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          ItemImgTitle(
              title:mModel.title,
              source:mModel.source,
              imgUrl: mModel.imageList[0]),

          Container(
            child: Row(

              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize :MainAxisSize.max,
              children: <Widget>[
                ScrollTagView(
                  tags: tags,
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(color: ColorsUtil.hexColor(0xC47E66),fontSize: 14),
                  radius: 15,
                  tagHeight: 30,
                  width: 250,
                  onTap: (text) {
                    print(text);
                  },
                ),
              ],
            ),
          ),

        ],

      ),

    );
  }

  Widget getContentItemTxt(BuildContext context, Data mModel) {
    List<String> tags=[];
    if (mModel.extend != null && mModel.extend.length > 0) {
      //先转json
      var json = jsonDecode(mModel.extend);
      tags = json['tags'].cast<String>();
    }

    return Container(
      //  height: 200,

      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          ItemNoImg(
              title:mModel.title,
              source:mModel.source),

          Container(
            child: Row(

              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize :MainAxisSize.max,
              children: <Widget>[
                ScrollTagView(
                  tags: tags,
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(color: ColorsUtil.hexColor(0xC47E66),fontSize: 14),
                  radius: 15,
                  tagHeight: 30,
                  width: 250,
                  onTap: (text) {
                    print(text);
                  },
                ),
              ],
            ),
          ),

        ],

      ),


    );
  }


  Widget getContentItemImgDes(BuildContext context, Data mModel) {
    List<String> tags=[];
    if (mModel.extend != null && mModel.extend.length > 0) {
      //先转json
      var json = jsonDecode(mModel.extend);
      tags = json['tags'].cast<String>();
    }

    return Container(
      //  height: 200,

      child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize :MainAxisSize.max,
        children: <Widget>[
          ItemImgDes(
              title:mModel.title,
              source:mModel.source,
              imgUrl: mModel.imageList[0],
              snippet: mModel.snippet),
          Container(
            child: Row(

              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize :MainAxisSize.max,
              children: <Widget>[
                ScrollTagView(
                  tags: tags,
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(color: ColorsUtil.hexColor(0xC47E66),fontSize: 14),
                  radius: 15,
                  tagHeight: 30,
                  width: 250,
                  onTap: (text) {
                    print(text);
                  },
                ),
              ],
            ),
          ),

        ],

      ),

    );
  }

  Widget getContentItemImgs(BuildContext context, Data mModel) {
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
                style: TextStyle(fontSize: 16.0, color: Colors.black)),
          ),

          Row(
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
                      mModel.imageList[0],
                    ),
                  ),

                ),
              ),
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
                      mModel.imageList[0],
                    ),
                  ),

                ),
              ),
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
                      mModel.imageList[0],
                    ),
                  ),

                ),
              ),
            ],
          ),
          Container(

            child: Text(mModel.source,
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