
import 'package:flutter/cupertino.dart';
import 'package:flutter_app1/model/search_img_entity.dart';
import 'package:flutter_app1/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/widget/build_more_footer.dart';
import 'package:flutter_app1/widget/txt_keyword.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app1/widget/full_screen_page.dart';
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


  Future pullToRefresh() async {
    getImgResultList(true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听登录事件
 EventBusUtil.getInstance().on<PageEvent>().listen((data) {
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
                  itemCount: mImgResultList.length,
                    itemBuilder: (context, index) {
                      return itemWidget(index);
                    },
                    staggeredTileBuilder: (index) =>
                        StaggeredTile.fit(2),
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
            child: FadeInImage(
              height: 120,
              fit: BoxFit.fitWidth,
              placeholder:
              AssetImage(Constant.ASSETS_IMG + 'img_default2.jpeg'),
              image: NetworkImage(
                imgPath,
              ),
            ),
          ),
        ),

      ),
            Container(
              height: 40,
              margin: EdgeInsets.only(bottom: 5),
              child: SelectText(mImgResultList[index].title,
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

