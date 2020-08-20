
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/http/ImgResult.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app1/widget/FullScreenImagePage.dart';
class ImgSearchPage extends StatefulWidget{
  String qury="北京";
  ImgSearchPage(String key){
    this.qury=key;
  }

  @override
  _ImgSearchPageState createState()=>_ImgSearchPageState();

}
class _ImgSearchPageState extends State<ImgSearchPage> {
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<ArrRes> mImgResultList = [];


  ImgSearchPageState() {}


  Future getImgResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getImgResult, params, (data) {

        List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;
        mImgResultList=[];
        for(int i=0;i<entityList.length;i++){
          mImgResultList.add(entityList[i]);
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

      DioManager.getInstance().get(ServiceUrl.getImgResult, params, (data) {


        List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;
        mImgResultList.addAll(entityList);
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
    getImgResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
 EventBusUtil.getInstance().on<PageEvent>().listen((data) {
   print("eventbus-get"+data.test);
   widget.qury=data.test;
   setState(() {
     getImgResultList(true);
   });
    });
    getImgResultList(true);
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

              getImgResultList(false);
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

                    crossAxisCount: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 10,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: mImgResultList.length,
                    itemBuilder: (context, index) {
                      return itemWidget(index);
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

  Widget  itemWidget(int index){
    String imgPath = mImgResultList[index].url;



    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        Material(

        elevation: 8.0,
        borderRadius: new BorderRadius.all(
          new Radius.circular(8.0),
        ),
        child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) {
                  return new FullScreenImagePage(imageurl: imgPath);
                },
              ),
            );
          },
          child: new Hero(
            tag: imgPath,
            child: CachedNetworkImage(
              imageUrl: imgPath,

              fit: BoxFit.fitWidth,
              /*    placeholder: (context, url) =>
                      Image.asset('assets/wallfy.png'),*/
            ),
          ),
        ),

      ),
            Container(
              height: 40,
              margin: EdgeInsets.only(bottom: 5),
              child: Text(mImgResultList[index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, color: Colors.black)),
              //  margin: EdgeInsets.only(left: 60),
            )
            ],
      ),
    );

  }


  Widget getContentItem(BuildContext context, ArrRes mModel) {
    return Container(
      //  height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              //  borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder:
                AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
                image: NetworkImage(
                  mModel.url,
                ),
              ),

            ),
          ),
          Positioned(
              child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 5, right: 3),
//                        child: Image.asset(
//                          Constant.ASSETS_IMG + 'video_play.png',
//                          width: 15.0,
//                          height: 15.0,
//                        ),
//                      ),

                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                            mModel.time,
                            style: TextStyle(fontSize: 14.0, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              )),
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 5),
            child: Text(mModel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
            //  margin: EdgeInsets.only(left: 60),
          )






        ],


      ),


    );
  }
}