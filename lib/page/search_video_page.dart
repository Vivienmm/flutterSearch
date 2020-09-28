
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_video_entity.dart';
import 'package:flutter_app1/page/web_view_page.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/util/color_factory.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_app1/widget/full_screen_page.dart';

class VideoSearchPage extends StatefulWidget{
  String qury="北京";
  VideoSearchPage(String key){
    this.qury=key;
  }

  @override
  _VideoSearchPageState createState()=>_VideoSearchPageState();

}
class _VideoSearchPageState extends State<VideoSearchPage> {
  bool isloadingMore = false; //是否显示加载中
  bool ishasMore = true; //是否还有更多
  num mCurPage = 1;

  ScrollController mScrollController = new ScrollController();
  @override
  bool get wantKeepAlive => true; //必须重写
  List<ArrRes> mVideoResultList = [];


  VideoSearchPageState() {}


  Future getVideoResultList(bool isRefresh) {
    if (isRefresh) {
      isloadingMore = false;
      ishasMore = true;
      mCurPage = 1;
      FormData params =
      FormData.fromMap({
        "q":widget.qury,
        'start_index': "$mCurPage",
        "order": "time"});
      DioManager.getInstance().get(ServiceUrl.getVideoResult, params, (data) {

        List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;
        mVideoResultList=[];
        for(int i=0;i<entityList.length;i++){
          mVideoResultList.add(entityList[i]);
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

      DioManager.getInstance().get(ServiceUrl.getVideoResult, params, (data) {


        List<ArrRes> entityList = Data.fromJson(data['data']).arrRes;

        setState(() {
          mVideoResultList.addAll(entityList);
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


  Future pullToRefresh() async {
    getVideoResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
    EventBusUtil.getInstance().on<PageEvent>().listen((data) {
      widget.qury=data.test;
      setState(() {
        getVideoResultList(true);
      });
    });
    getVideoResultList(true);
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

              getVideoResultList(false);
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


    return Container(
      padding: EdgeInsets.only(top: 15),

      child: RefreshIndicator(
        onRefresh: pullToRefresh,
        child:new CustomScrollView(
          controller: mScrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(

                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,

                  crossAxisCount: 4,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 10,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: mVideoResultList.length,
                  itemBuilder: (context, index) {
                    return itemWidget(index);
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2,index==0?2:2),
                ),
              ),


            new SliverToBoxAdapter(
              child: Container(
                height: 40,
                child:Footer(isloadingMore: isloadingMore, ishasMore: ishasMore),
              ),
            ),
          ]),
      ),
    );

  }

  Widget  itemWidget(int index){
    String imgPath = mVideoResultList[index].image_src;
    String jumpUrl=mVideoResultList[index].url;
    var size = MediaQuery.of(context).size;
    final double mGridItemHeight = 200;
    final double mGridItemWidth = size.width / 2;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 8.0,
            color: Colors.black,
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
                child:GestureDetector(
                  onTap:(){
                    Navigator.of(context).push(

                        new MaterialPageRoute(builder: (context) {

                          return new WebViewExample();//url为要跳转的地址,title为需要传递的参数
                          //return new WebViewExample(url:mVideoResultList[index].url,title: "新闻详情",);//url为要跳转的地址,title为需要传递的参数
                        },
                        ));
                  },
                  child: FadeInImage(
                    height: 100,
                    width: mGridItemWidth,
                    fit: BoxFit.contain,
                    placeholder:
                    AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
                    image: NetworkImage(
                      imgPath,
                    ),
                  ),


                )

              ),
            ),

          ),
          Container(

            margin: EdgeInsets.only(bottom: 5),
            child: SelectText(mVideoResultList[index].title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.0, color: Colors.black)),
            //  margin: EdgeInsets.only(left: 60),
          ),
          Container(

            margin: EdgeInsets.only(bottom: 5),
            child: SelectText(mVideoResultList[index].siteName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11.0, color: LcfarmColor.sourceColor,)),
            //  margin: EdgeInsets.only(left: 60),
          ),
        ],
      ),
    );

  }


}