
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/http/StoryResult.dart';
import 'package:flutter_app1/util/ColorsUtil.dart';
import 'package:flutter_app1/widget/ScrollTagView.dart';
import 'package:flutter_app1/widget/TagView.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cached_network_image/cached_network_image.dart';
class StorySearchPage extends StatefulWidget{
  String qury="北京";
  StorySearchPage(String key){
    this.qury=key;
  }

  @override
  _StorySearchPageState createState()=>_StorySearchPageState();

}
class _StorySearchPageState extends State<StorySearchPage> {
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mYoungResultList = [];


  StorySearchPageState() {}


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
      DioManager.getInstance().get(ServiceUrl.getStoryResult, params, (data) {

        List<Data> entityList = OutsideData.fromJson(data['data']).data;
        mYoungResultList=[];
        for(int i=0;i<entityList.length;i++){
          mYoungResultList.add(entityList[i]);
        }

        setState(() {

        });
      }, (error) {});
    } else {
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': mCurPage,
        "order": "time"});

      DioManager.getInstance().get(ServiceUrl.getStoryResult, params, (data) {

        List<Data> entityList = OutsideData.fromJson(data['data']).data;
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

    return Container(
      padding: EdgeInsets.only(top: 15),

      child:new CustomScrollView(
          controller: mScrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: RefreshIndicator(
                onRefresh: pullToRefresh,

                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,

                  crossAxisCount: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 10,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: mYoungResultList.length,
                  itemBuilder: (context, index) {
                    if(mYoungResultList[index].imageList.length>0){
                      return getContentItemImgDes(context, mYoungResultList[index]);
                    }else{
                      return getContentItemTxt(context, mYoungResultList[index]);
                    }

                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.fit(2),
                ),
              ),

            ),
            new SliverToBoxAdapter(
              child: _buildLoadMore(),
            ),
          ]),

    );

  }


  Widget getContentItemImgNoDes(BuildContext context, Data mModel) {
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
                  mModel.imageList[0],
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

                  child: Text(mModel.timestamp.toString(),
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

            child: Text(mModel.timestamp.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            //  margin: EdgeInsets.only(left: 60),
          )


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


//    List<String> tags =  [
//      '我要好好学习',
//      'Java',
//      'Object-C',
//      'Swift',
//      'Dart',
//      'Python',
//      'Javascript'
//    ];
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
              Expanded(

                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize :MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Text(mModel.snippet,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0, color: Colors.black)),
                    ),
                    Container(

                      child: Text(mModel.snippet.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                      //  margin: EdgeInsets.only(left: 60),
                    )

                  ],

                ),
              ),

            ],


          ),Container(

            child: Text(mModel.timestamp.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.grey)),
            //  margin: EdgeInsets.only(left: 60),
          ),
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
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
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

            child: Text(mModel.timestamp.toString(),
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