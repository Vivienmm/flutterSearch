class search_games_entity {
  int status;
  String msg;
  DataBean dataBean;

  search_games_entity({this.status, this.msg, this.dataBean});

  search_games_entity.fromJson(Map<String, dynamic> json) {
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
  int total;
  bool loadMore;
  int nextIndex;

//  List<Null> correctionResults;
  List<Data> data;

  DataBean(
      {this.total,
      this.loadMore,
      this.nextIndex,
//        this.correctionResults,
      this.data});

  DataBean.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    loadMore = json['loadMore'];
    nextIndex = json['nextIndex'];
//    if (json['correctionResults'] != null) {
//      correctionResults = new List<Null>();
//      json['correctionResults'].forEach((v) {
//        correctionResults.add(new Null.fromJson(v));
//      });
//    }
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['loadMore'] = this.loadMore;
    data['nextIndex'] = this.nextIndex;
//    if (this.correctionResults != null) {
//      data['correctionResults'] =
//          this.correctionResults.map((v) => v.toJson()).toList();
//    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String snippet;
  String title;
  int timestamp;
  List<String> imageList;
  String extend;

  Data({this.snippet, this.title, this.timestamp, this.imageList, this.extend});

  Data.fromJson(Map<String, dynamic> json) {
    snippet = json['snippet'];
    title = json['title'];
    timestamp = json['timestamp'];
    imageList = json['image_list'].cast<String>();
    extend = json['extend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['snippet'] = this.snippet;
    data['title'] = this.title;
    data['timestamp'] = this.timestamp;
    data['image_list'] = this.imageList;
    data['extend'] = this.extend;
    return data;
  }
}
