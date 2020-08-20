class search_en_story_entity {
  int status;
  String msg;
  DataBean dataBean;

  search_en_story_entity({this.status, this.msg, this.dataBean});

  search_en_story_entity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    dataBean = json['data'] != null ? new DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.dataBean != null) {
      data['data'] = this.dataBean.toJson();
    }
    return data;
  }
}

class DataBean {
  int displayResultCount;
  int total;
  bool loadMore;
  int nextIndex;
//  List<Null> correctionResults;
  Related related;
  String advLeftHtml;
  bool hasAdvInfo;
  List<Data> data;

  DataBean(
      {this.displayResultCount,
        this.total,
        this.loadMore,
        this.nextIndex,
//        this.correctionResults,
        this.related,
        this.advLeftHtml,
        this.hasAdvInfo,
        this.data});

  DataBean.fromJson(Map<String, dynamic> json) {
    displayResultCount = json['display_result_count'];
    total = json['total'];
    loadMore = json['loadMore'];
    nextIndex = json['nextIndex'];
//    if (json['correctionResults'] != null) {
//      correctionResults = new List<Null>();
//      json['correctionResults'].forEach((v) {
//        correctionResults.add(new Null.fromJson(v));
//      });
//    }
//    related =
//    json['related'] != null ? new Related.fromJson(json['related']) : null;
    advLeftHtml = json['advLeftHtml'];
    hasAdvInfo = json['hasAdvInfo'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_result_count'] = this.displayResultCount;
    data['total'] = this.total;
    data['loadMore'] = this.loadMore;
    data['nextIndex'] = this.nextIndex;
//    if (this.correctionResults != null) {
//      data['correctionResults'] =
//          this.correctionResults.map((v) => v.toJson()).toList();
//    }
//    if (this.related != null) {
//      data['related'] = this.related.toJson();
//    }
    data['advLeftHtml'] = this.advLeftHtml;
    data['hasAdvInfo'] = this.hasAdvInfo;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Related {
//  List<Null> result;
//  List<Null> correction;

//  Related({this.result, this.correction});

//  Related.fromJson(Map<String, dynamic> json) {
//    if (json['result'] != null) {
//      result = new List<Null>();
//      json['result'].forEach((v) {
//        result.add(new Null.fromJson(v));
//      });
//    }
//    if (json['correction'] != null) {
//      correction = new List<Null>();
//      json['correction'].forEach((v) {
//        correction.add(new Null.fromJson(v));
//      });
//    }
//  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.result != null) {
//      data['result'] = this.result.map((v) => v.toJson()).toList();
//    }
//    if (this.correction != null) {
//      data['correction'] = this.correction.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
}

class Data {
  String snippet;
  String title;
//  List<Null> reporter;
  String url;
  int timestamp;
  String source;
  int resultType;
  List<String> imageList;
  List<String> videoList;
//  List<Null> radioList;
  String contentSign;
  String sameNewsNum;
  String extend;
  String username;
  String edition;
  String icon;

  Data(
      {this.snippet,
        this.title,
//        this.reporter,
        this.url,
        this.timestamp,
        this.source,
        this.resultType,
        this.imageList,
        this.videoList,
//        this.radioList,
        this.contentSign,
        this.sameNewsNum,
        this.extend,
        this.username,
        this.edition,
        this.icon});

  Data.fromJson(Map<String, dynamic> json) {
    snippet = json['snippet'];
    title = json['title'];
//    if (json['reporter'] != null) {
//      reporter = new List<Null>();
//      json['reporter'].forEach((v) {
//        reporter.add(new Null.fromJson(v));
//      });
//    }
    url = json['url'];
    timestamp = json['timestamp'];
    source = json['source'];
    resultType = json['resultType'];
    imageList = json['image_list'].cast<String>();
    videoList = json['video_list'].cast<String>();
//    if (json['radio_list'] != null) {
//      radioList = new List<Null>();
//      json['radio_list'].forEach((v) {
//        radioList.add(new Null.fromJson(v));
//      });
//    }
    contentSign = json['content_sign'];
    sameNewsNum = json['same_news_num'];
    extend = json['extend'];
    username = json['username'];
    edition = json['edition'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['snippet'] = this.snippet;
    data['title'] = this.title;
//    if (this.reporter != null) {
//      data['reporter'] = this.reporter.map((v) => v.toJson()).toList();
//    }
    data['url'] = this.url;
    data['timestamp'] = this.timestamp;
    data['source'] = this.source;
    data['resultType'] = this.resultType;
    data['image_list'] = this.imageList;
    data['video_list'] = this.videoList;
//    if (this.radioList != null) {
//      data['radio_list'] = this.radioList.map((v) => v.toJson()).toList();
//    }
    data['content_sign'] = this.contentSign;
    data['same_news_num'] = this.sameNewsNum;
    data['extend'] = this.extend;
    data['username'] = this.username;
    data['edition'] = this.edition;
    data['icon'] = this.icon;
    return data;
  }
}

