class StoryResult {
  int _status;
  String _msg;
  OutsideData _data;

  StoryResult({int status, String msg, OutsideData data}) {
    this._status = status;
    this._msg = msg;
    this._data = data;
  }

  int get status => _status;
  set status(int status) => _status = status;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  OutsideData get data => _data;
  set data(OutsideData data) => _data = data;

  StoryResult.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _data = json['data'] != null ? new OutsideData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class OutsideData {
  int _displayResultCount;
  int _total;
  bool _loadMore;
  int _nextIndex;
  List<String> _correctionResults;
 // Related _related;
  String _advLeftHtml;
  bool _hasAdvInfo;
  List<Data> _data;

  OutsideData(
      {int displayResultCount,
        int total,
        bool loadMore,
        int nextIndex,
        List<String> correctionResults,
      //  Related related,
        String advLeftHtml,
        bool hasAdvInfo,
        List<Data> data}) {
    this._displayResultCount = displayResultCount;
    this._total = total;
    this._loadMore = loadMore;
    this._nextIndex = nextIndex;
    this._correctionResults = correctionResults;
   // this._related = related;
    this._advLeftHtml = advLeftHtml;
    this._hasAdvInfo = hasAdvInfo;
    this._data = data;
  }

  int get displayResultCount => _displayResultCount;
  set displayResultCount(int displayResultCount) =>
      _displayResultCount = displayResultCount;
  int get total => _total;
  set total(int total) => _total = total;
  bool get loadMore => _loadMore;
  set loadMore(bool loadMore) => _loadMore = loadMore;
  int get nextIndex => _nextIndex;
  set nextIndex(int nextIndex) => _nextIndex = nextIndex;
  List<String> get correctionResults => _correctionResults;
  set correctionResults(List<String> correctionResults) =>
      _correctionResults = correctionResults;
 // Related get related => _related;
 // set related(Related related) => _related = related;
  String get advLeftHtml => _advLeftHtml;
  set advLeftHtml(String advLeftHtml) => _advLeftHtml = advLeftHtml;
  bool get hasAdvInfo => _hasAdvInfo;
  set hasAdvInfo(bool hasAdvInfo) => _hasAdvInfo = hasAdvInfo;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  OutsideData.fromJson(Map<String, dynamic> json) {
    _displayResultCount = json['display_result_count'];
    _total = json['total'];
    _loadMore = json['loadMore'];
    _nextIndex = json['nextIndex'];
    if (json['correctionResults'] != null) {
      _correctionResults = new List<String>();
      json['correctionResults'].forEach((v) {
        _correctionResults.add(v);
      });
    }
   // _related =
   // json['related'] != null ? new Related.fromJson(json['related']) : null;
    _advLeftHtml = json['advLeftHtml'];
    _hasAdvInfo = json['hasAdvInfo'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_result_count'] = this._displayResultCount;
    data['total'] = this._total;
    data['loadMore'] = this._loadMore;
    data['nextIndex'] = this._nextIndex;
    if (this._correctionResults != null) {
      data['correctionResults'] =
          this._correctionResults;
    }
//    if (this._related != null) {
//      data['related'] = this._related.toJson();
//    }
    data['advLeftHtml'] = this._advLeftHtml;
    data['hasAdvInfo'] = this._hasAdvInfo;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Related {
  List<String> _result;
  List<String> _correction;

  Related({List<String> result, List<String> correction}) {
    this._result = result;
    this._correction = correction;
  }

  List<String> get result => _result;
  set result(List<String> result) => _result = result;
  List<String> get correction => _correction;
  set correction(List<String> correction) => _correction = correction;

  Related.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      _result = new List<String>();
      json['result'].forEach((v) {
        _result.add(v);
      });
    }
    if (json['correction'] != null) {
      _correction = new List<String>();
      json['correction'].forEach((v) {
        _correction.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._result != null) {
      data['result'] = this._result;
    }
    if (this._correction != null) {
      data['correction'] = this._correction;
    }
    return data;
  }
}


class Data {
  String _snippet;
  String _title;
  List<String> _reporter;
  String _url;
  int _timestamp;
  String _source;
  int _resultType;
  List<String> _imageList;
  List<String> _videoList;
  List<String> _radioList;
  String _contentSign;
  String _sameNewsNum;
  String _extend;
  String _username;
  String _edition;
  String _icon;

  Data(
      {String snippet,
        String title,
        List<String> reporter,
        String url,
        int timestamp,
        String source,
        int resultType,
        List<String> imageList,
        List<String> videoList,
        List<String> radioList,
        String contentSign,
        String sameNewsNum,
        String extend,
        String username,
        String edition,
        String icon}) {
    this._snippet = snippet;
    this._title = title;
    this._reporter = reporter;
    this._url = url;
    this._timestamp = timestamp;
    this._source = source;
    this._resultType = resultType;
    this._imageList = imageList;
    this._videoList = videoList;
    this._radioList = radioList;
    this._contentSign = contentSign;
    this._sameNewsNum = sameNewsNum;
    this._extend = extend;
    this._username = username;
    this._edition = edition;
    this._icon = icon;
  }

  String get snippet => _snippet;
  set snippet(String snippet) => _snippet = snippet;
  String get title => _title;
  set title(String title) => _title = title;
  List<String> get reporter => _reporter;
  set reporter(List<String> reporter) => _reporter = reporter;
  String get url => _url;
  set url(String url) => _url = url;
  int get timestamp => _timestamp;
  set timestamp(int timestamp) => _timestamp = timestamp;
  String get source => _source;
  set source(String source) => _source = source;
  int get resultType => _resultType;
  set resultType(int resultType) => _resultType = resultType;
  List<String> get imageList => _imageList;
  set imageList(List<String> imageList) => _imageList = imageList;
  List<String> get videoList => _videoList;
  set videoList(List<String> videoList) => _videoList = videoList;
  List<String> get radioList => _radioList;
  set radioList(List<String> radioList) => _radioList = radioList;
  String get contentSign => _contentSign;
  set contentSign(String contentSign) => _contentSign = contentSign;
  String get sameNewsNum => _sameNewsNum;
  set sameNewsNum(String sameNewsNum) => _sameNewsNum = sameNewsNum;
  String get extend => _extend;
  set extend(String extend) => _extend = extend;
  String get username => _username;
  set username(String username) => _username = username;
  String get edition => _edition;
  set edition(String edition) => _edition = edition;
  String get icon => _icon;
  set icon(String icon) => _icon = icon;

  Data.fromJson(Map<String, dynamic> json) {
    _snippet = json['snippet'];
    _title = json['title'];

    _reporter = json['reporter'].cast<String>();
    _url = json['url'];
    _timestamp = json['timestamp'];
    _source = json['source'];
    _resultType = json['resultType'];
    _imageList = json['image_list'].cast<String>();
    _videoList = json['video_list'].cast<String>();
    _radioList = json['radio_list'].cast<String>();
    _contentSign = json['content_sign'];
    _sameNewsNum = json['same_news_num'];
    _extend = json['extend'];
    _username = json['username'];
    _edition = json['edition'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['snippet'] = this._snippet;
    data['title'] = this._title;
    if (this._reporter != null) {
      data['reporter'] = this._reporter;
    }
    data['url'] = this._url;
    data['timestamp'] = this._timestamp;
    data['source'] = this._source;
    data['resultType'] = this._resultType;
    data['image_list'] = this._imageList;
    data['video_list'] = this._videoList;
    data['radio_list'] = this._radioList;
    data['content_sign'] = this._contentSign;
    data['same_news_num'] = this._sameNewsNum;
    data['extend'] = this._extend;
    data['username'] = this._username;
    data['edition'] = this._edition;
    data['icon'] = this._icon;
    return data;
  }
}
