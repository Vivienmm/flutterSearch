
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_en_story_entity.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/util/color_utils.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/scroll_tag.dart';
import 'package:flutter_app1/widget/commonitem/item_img_title.dart';
import 'package:flutter_app1/widget/commonitem/item_no_img.dart';
import 'package:flutter_app1/widget/commonitem/item_img_des.dart';
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
          child: ListView.separated(
            shrinkWrap: true,

            //physics: new NeverScrollableScrollPhysics(),
            itemCount: mStoryEnResultList.length+1,
            separatorBuilder: (context, index) {
              return Divider(height: 10.0, thickness:10,color: LcfarmColor.dividerColor);
            },
            itemBuilder: (context, index) {
              if (index == mStoryEnResultList.length) {
                return Container(
                  height: 40,
                  child: Footer(
                      isloadingMore: isloadingMore, ishasMore: ishasMore),
                );
              } else {
                int imgLength = mStoryEnResultList[index].imageList.length;


                if (imgLength == 0) {
                  return getContentItemTxt(context, mStoryEnResultList[index]);
                } else if (0 < imgLength && imgLength < 3) {
                  if (mStoryEnResultList[index].snippet.length > 0) {
                    return getContentItemImgDes(
                        context, mStoryEnResultList[index]);
                  } else {
                    return getContentItemImgNoDes(
                        context, mStoryEnResultList[index]);
                  }
                } else {
                  return getContentItemImgs(context, mStoryEnResultList[index]);
                }
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