
class search_block_entity {
  int status;
  String msg;
  List<Data> data;

  search_block_entity({this.status, this.msg, this.data});

  search_block_entity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<SearchResults> searchResults;
  int type;
  int total;
  bool loadMore;
  int nextIndex;
//  List<Null> correctionResults;

  Data(
      {this.searchResults,
        this.type,
        this.total,
        this.loadMore,
        this.nextIndex,
//        this.correctionResults
      });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['search_results'] != null) {
      searchResults = new List<SearchResults>();
      json['search_results'].forEach((v) {
        searchResults.add(new SearchResults.fromJson(v));
      });
    }
    type = json['type'];
    total = json['total'];
    loadMore = json['loadMore'];
    nextIndex = json['nextIndex'];
//    if (json['correctionResults'] != null) {
//      correctionResults = new List<Null>();
//      json['correctionResults'].forEach((v) {
//        correctionResults.add(new Null.fromJson(v));
//      });
//    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchResults != null) {
      data['search_results'] =
          this.searchResults.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['total'] = this.total;
    data['loadMore'] = this.loadMore;
    data['nextIndex'] = this.nextIndex;
//    if (this.correctionResults != null) {
//      data['correctionResults'] =
//          this.correctionResults.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

class SearchResults {
  int publishTimstamp;
  int blockchainType;
  String title;
  String snippet;
  String source;
  String url;
  Null author;
  List<String> imageList;
  List<String> videoList;
  Null radioList;
  Null sameNewsNum;
  String extend;
  String sameImageValue;
  String sameVideoValue;

  SearchResults(
      {this.publishTimstamp,
        this.blockchainType,
        this.title,
        this.snippet,
        this.source,
        this.url,
        this.author,
        this.imageList,
        this.videoList,
        this.radioList,
        this.sameNewsNum,
        this.extend,
        this.sameImageValue,
        this.sameVideoValue});

  SearchResults.fromJson(Map<String, dynamic> json) {
    publishTimstamp = json['publish_timstamp'];
    blockchainType = json['blockchain_type'];
    title = json['title'];
    snippet = json['snippet'];
    source = json['source'];
    url = json['url'];
    author = json['author'];
    imageList = json['image_list'].cast<String>();
    if(null!=json['video_list']){
      videoList = json['video_list'].cast<String>();
    }else{
      videoList=[];
    }

    radioList = json['radio_list'];
    sameNewsNum = json['same_news_num'];
    extend = json['extend'];
    sameImageValue = json['same_image_value'];
    sameVideoValue = json['same_video_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publish_timstamp'] = this.publishTimstamp;
    data['blockchain_type'] = this.blockchainType;
    data['title'] = this.title;
    data['snippet'] = this.snippet;
    data['source'] = this.source;
    data['url'] = this.url;
    data['author'] = this.author;
    data['image_list'] = this.imageList;
    data['video_list'] = this.videoList;
    data['radio_list'] = this.radioList;
    data['same_news_num'] = this.sameNewsNum;
    data['extend'] = this.extend;
    data['same_image_value'] = this.sameImageValue;
    data['same_video_value'] = this.sameVideoValue;
    return data;
  }
}