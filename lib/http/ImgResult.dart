
class ImgResult {
  int status;
  String msg;
  Data data;

  ImgResult({this.status, this.msg, this.data});

  ImgResult.fromJson(Map<String, dynamic> json) {
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
  int total;
  int nextIndex;


  Data({this.arrRes, this.total, this.nextIndex});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['arrRes'] != null) {
      arrRes = new List<ArrRes>();
      json['arrRes'].forEach((v) {
        arrRes.add(new ArrRes.fromJson(v));
      });
    }
    total = json['total'];
    nextIndex = json['nextIndex'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arrRes != null) {
      data['arrRes'] = this.arrRes.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['nextIndex'] = this.nextIndex;

    return data;
  }
}

class ArrRes {
  String smallimage;
  String largeimage;
  String webUrl;
  String docid;
  String time;
  String imageInfo;
  String url;
  String host;
  String title;
  String summary;

  ArrRes(
      {this.smallimage,
        this.largeimage,
        this.webUrl,
        this.docid,
        this.time,
        this.imageInfo,
        this.url,
        this.host,
        this.title,
        this.summary});

  ArrRes.fromJson(Map<String, dynamic> json) {
    smallimage = json['smallimage'];
    largeimage = json['largeimage'];
    webUrl = json['web_url'];
    docid = json['docid'];
    time = json['time'];
    imageInfo = json['ImageInfo'];
    url = json['url'];
    host = json['host'];
    title = json['title'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smallimage'] = this.smallimage;
    data['largeimage'] = this.largeimage;
    data['web_url'] = this.webUrl;
    data['docid'] = this.docid;
    data['time'] = this.time;
    data['ImageInfo'] = this.imageInfo;
    data['url'] = this.url;
    data['host'] = this.host;
    data['title'] = this.title;
    data['summary'] = this.summary;
    return data;
  }
}

