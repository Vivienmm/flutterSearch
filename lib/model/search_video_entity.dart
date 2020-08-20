class search_video_entity {
  int status;
  String msg;
  Data data;

  search_video_entity({this.status, this.msg, this.data});

  search_video_entity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<ArrRes> arrRes;
  bool loadMore;
  int nextIndex;
  int total;

//  List<Null> correctionResults;

  Data({
    this.arrRes,
    this.loadMore,
    this.nextIndex,
    this.total,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['arrRes'] != null) {
      arrRes = new List<ArrRes>();
      json['arrRes'].forEach((v) {
        arrRes.add(new ArrRes.fromJson(v));
      });
    }
    loadMore = json['loadMore'];
    nextIndex = json['nextIndex'];
    total = json['total'];
//    if (json['correctionResults'] != null) {
//      correctionResults = new List<Null>();
//      json['correctionResults'].forEach((v) {
//        correctionResults.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arrRes != null) {
      data['arrRes'] = this.arrRes.map((v) => v.toJson()).toList();
    }
    data['loadMore'] = this.loadMore;
    data['nextIndex'] = this.nextIndex;
    data['total'] = this.total;
//    if (this.correctionResults != null) {
//      data['correctionResults'] =
//          this.correctionResults.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

class ArrRes {
  int docid;
  String title;
  String url;
  String displayUrl;
  int videoPubDate;
  String videoTaoType;
  String videoRealUrl;
  String rawTitle;
  String image_src;
  String siteName;
  String duration;

  ArrRes(
      {this.docid,
      this.title,
      this.url,
      this.displayUrl,
      this.videoPubDate,
      this.videoTaoType,
      this.videoRealUrl,
      this.rawTitle,
      this.image_src,
      this.siteName,
      this.duration});

  ArrRes.fromJson(Map<String, dynamic> json) {
    docid = json['docid'];
    title = json['title'];
    url = json['url'];
    displayUrl = json['display_url'];
    videoPubDate = json['VideoPubDate'];
    videoTaoType = json['VideoTaoType'];
    videoRealUrl = json['VideoRealUrl'];
    rawTitle = json['raw_title'];
    image_src = json['image_src'];
    siteName = json['site_name'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docid'] = this.docid;
    data['title'] = this.title;
    data['url'] = this.url;
    data['display_url'] = this.displayUrl;
    data['VideoPubDate'] = this.videoPubDate;
    data['VideoTaoType'] = this.videoTaoType;
    data['VideoRealUrl'] = this.videoRealUrl;
    data['raw_title'] = this.rawTitle;
    data['image_src'] = this.image_src;
    data['site_name'] = this.siteName;
    data['duration'] = this.duration;
    return data;
  }
}
