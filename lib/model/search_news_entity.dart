
class search_news_entity {
  int status;
  String msg;
  DataBean dataBean;

  search_news_entity({this.status, this.msg, this.dataBean});

  search_news_entity.fromJson(Map<String, dynamic> json) {
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
  int displayResultCount;
  int total;
  bool loadMore;
  int nextIndex;
  List<Null> correctionResults;
  String related;

  List<Lunabox> lunabox;
  String advLeftHtml;
  bool hasAdvInfo;
  List<Data> data;

  DataBean(
      {this.displayResultCount,
      this.total,
      this.loadMore,
      this.nextIndex,
      this.correctionResults,
      this.related,
      this.lunabox,
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
    related = json['related'].toString();
    if (json['lunabox'] != null) {
      lunabox = new List<Lunabox>();
      json['lunabox'].forEach((v) {
        lunabox.add(new Lunabox.fromJson(v));
      });
    }
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
    data['related'] = this.related;
    if (this.lunabox != null) {
      data['lunabox'] = this.lunabox.map((v) => v.toJson()).toList();
    }
    data['advLeftHtml'] = this.advLeftHtml;
    data['hasAdvInfo'] = this.hasAdvInfo;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lunabox {
  String title;
  List<Content> content;
  int templateId;
  int typeId;
  String hTML;
  String cSS;
  String jS;

  Lunabox(
      {this.title,
      this.content,
      this.templateId,
      this.typeId,
      this.hTML,
      this.cSS,
      this.jS});

  Lunabox.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['content'] != null) {
      content = new List<Content>();
      if (json['content'] != null&&json['content'] is String) {
        json['content'].forEach((v) {
          if (v != null) {
            content.add(new Content.fromJson(v));
          }
        });
      }
    }
    templateId = json['template_id'];
    typeId = json['type_id'];
    hTML = json['HTML'];
    cSS = json['CSS'];
    jS = json['JS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['template_id'] = this.templateId;
    data['type_id'] = this.typeId;
    data['HTML'] = this.hTML;
    data['CSS'] = this.cSS;
    data['JS'] = this.jS;
    return data;
  }
}

class Content {
  String url;
  String name;
  String introduction;
  String tfskey;
  String source;

  Content({this.url, this.name, this.introduction, this.tfskey, this.source});

  Content.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    introduction = json['introduction'];
    tfskey = json['tfskey'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['introduction'] = this.introduction;
    data['tfskey'] = this.tfskey;
    data['source'] = this.source;
    return data;
  }
}

class Data {
  String snippet;
  String title;
  List<String> reporter;
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
      this.reporter,
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
    reporter = json['reporter'].cast<String>();
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
    data['reporter'] = this.reporter;
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
