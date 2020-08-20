class search_app_entity {
  int status;
  String msg;
  DataBean dataBean;

  search_app_entity({this.status, this.msg, this.dataBean});

  search_app_entity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    dataBean =
        json['data'] != null ? new DataBean.fromJson(json['data']) : null;
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
  List<Data> data;

//  List<Null> correctionResults;

  DataBean({this.data});

  DataBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
//    if (json['correctionResults'] != null) {
//      correctionResults = new List<Null>();
//      json['correctionResults'].forEach((v) {
//        correctionResults.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
//    if (this.correctionResults != null) {
//      data['correctionResults'] =
//          this.correctionResults.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

class Data {
  String source;
  List<SearchResults> searchResults;
  String icon;
  String wakeupurlAndroid;
  String wakeupurlIos;
  String siteName;

  Data(
      {this.source,
      this.searchResults,
      this.icon,
      this.wakeupurlAndroid,
      this.wakeupurlIos,
      this.siteName});

  Data.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    if (json['search_results'] != null) {
      searchResults = new List<SearchResults>();
      json['search_results'].forEach((v) {
        searchResults.add(new SearchResults.fromJson(v));
      });
    }
    icon = json['icon'];
    wakeupurlAndroid = json['wakeupurl_android'];
    wakeupurlIos = json['wakeupurl_ios'];
    siteName = json['site_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    if (this.searchResults != null) {
      data['search_results'] =
          this.searchResults.map((v) => v.toJson()).toList();
    }
    data['icon'] = this.icon;
    data['wakeupurl_android'] = this.wakeupurlAndroid;
    data['wakeupurl_ios'] = this.wakeupurlIos;
    data['site_name'] = this.siteName;
    return data;
  }
}

class SearchResults {
  int publishTimstamp;
  int mobType;
  String title;
  String snippet;
  String source;
  String url;
  String author;
  List<String> imageList;
  List<String> videoList;

//  List<Null> radioList;
  Null sameNewsNum;
  String extend;

  SearchResults(
      {this.publishTimstamp,
      this.mobType,
      this.title,
      this.snippet,
      this.source,
      this.url,
      this.author,
      this.imageList,
      this.videoList,
//        this.radioList,
      this.sameNewsNum,
      this.extend});

  SearchResults.fromJson(Map<String, dynamic> json) {
    publishTimstamp = json['publish_timstamp'];
    mobType = json['mob_type'];
    title = json['title'];
    snippet = json['snippet'];
    source = json['source'];
    url = json['url'];
    author = json['author'];
    imageList = json['image_list'].cast<String>();
    videoList = json['video_list'].cast<String>();
//    if (json['radio_list'] != null) {
//      radioList = new List<Null>();
//      json['radio_list'].forEach((v) {
//        radioList.add(new Null.fromJson(v));
//      });
//    }
    sameNewsNum = json['same_news_num'];
    extend = json['extend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publish_timstamp'] = this.publishTimstamp;
    data['mob_type'] = this.mobType;
    data['title'] = this.title;
    data['snippet'] = this.snippet;
    data['source'] = this.source;
    data['url'] = this.url;
    data['author'] = this.author;
    data['image_list'] = this.imageList;
    data['video_list'] = this.videoList;
//    if (this.radioList != null) {
//      data['radio_list'] = this.radioList.map((v) => v.toJson()).toList();
//    }
    data['same_news_num'] = this.sameNewsNum;
    data['extend'] = this.extend;
    return data;
  }
}
