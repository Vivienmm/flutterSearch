import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_news_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter_app1/widget/ItemImgTitle.dart';
import 'package:flutter_app1/widget/ItemNoImg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NewsSearchPage extends StatefulWidget{
  String qury="北京";
  NewsSearchPage(String keyWord){
    this.qury=keyWord;
  }
  @override
  _NewsSearchPageState createState()=> _NewsSearchPageState();

}

class _NewsSearchPageState extends State<NewsSearchPage>{
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<Data> mNewsResultList = [];


  NewsSearchPageState() {}


  Future getNewsResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getNewsResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
        mNewsResultList=[];
        for(int i=0;i<entityList.length;i++){
          mNewsResultList.add(entityList[i]);
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

      DioManager.getInstance().get(ServiceUrl.getNewsResult, params, (data) {

        List<Data> entityList = DataBean.fromJson(data['data']).data;
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
            print("susus"+"滑动到底部");
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
                  itemCount: mNewsResultList.length,
                  itemBuilder: (context, index) {
                    if(mNewsResultList[index].imageList.length>0){

                      return ItemImgTitle(
                          title:mNewsResultList[index].title,
                          source:mNewsResultList[index].source,
                          imgUrl: mNewsResultList[index].imageList[0]);
                    }else{
                      return ItemNoImg(
                          title:mNewsResultList[index].title,
                          source:mNewsResultList[index].source);
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






}