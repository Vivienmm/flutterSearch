
class YoungResult {
  int _status;
  String _msg;
  OutData _data;

  YoungResult({int status, String msg, OutData data}) {
    this._status = status;
    this._msg = msg;
    this._data = data;
  }

  int get status => _status;
  set status(int status) => _status = status;
  String get msg => _msg;
  set msg(String msg) => _msg = msg;
  OutData get data => _data;
  set data(OutData data) => _data = data;

  YoungResult.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _msg = json['msg'];
    _data = json['data'] != null ? new OutData.fromJson(json['data']) : null;
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

class OutData {
  bool _loadMore;
  int _nextIndex;
  Null _correctionResults;
  int _total;
  List<Data> _data;

  OutData(
      {bool loadMore,
        int nextIndex,
        Null correctionResults,
        int total,
        List<Data> data}) {
    this._loadMore = loadMore;
    this._nextIndex = nextIndex;
    this._correctionResults = correctionResults;
    this._total = total;
    this._data = data;
  }

  bool get loadMore => _loadMore;
  set loadMore(bool loadMore) => _loadMore = loadMore;
  int get nextIndex => _nextIndex;
  set nextIndex(int nextIndex) => _nextIndex = nextIndex;
  Null get correctionResults => _correctionResults;
  set correctionResults(Null correctionResults) =>
      _correctionResults = correctionResults;
  int get total => _total;
  set total(int total) => _total = total;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  OutData.fromJson(Map<String, dynamic> json) {
    _loadMore = json['loadMore'];
    _nextIndex = json['nextIndex'];
    _correctionResults = json['correctionResults'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loadMore'] = this._loadMore;
    data['nextIndex'] = this._nextIndex;
    data['correctionResults'] = this._correctionResults;
    data['total'] = this._total;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String _docid;
  String _title;
  String _publishtime;
  int _timestamp;
  String _originalsource;
  int _type;
  String _url;
  int _imgsnum;
  String _scheme;
  String _radiosrc;
  List<String> _imgs;
  String _extend;
  int _rendertype;
  String _videosrc;

  Data(
      {String docid,
        String title,
        String publishtime,
        int timestamp,
        String originalsource,
        int type,
        String url,
        int imgsnum,
        String scheme,
        String radiosrc,
        List<String> imgs,
        String extend,
        int rendertype,
        String videosrc}) {
    this._docid = docid;
    this._title = title;
    this._publishtime = publishtime;
    this._timestamp = timestamp;
    this._originalsource = originalsource;
    this._type = type;
    this._url = url;
    this._imgsnum = imgsnum;
    this._scheme = scheme;
    this._radiosrc = radiosrc;
    this._imgs = imgs;
    this._extend = extend;
    this._rendertype = rendertype;
    this._videosrc = videosrc;
  }

  String get docid => _docid;
  set docid(String docid) => _docid = docid;
  String get title => _title;
  set title(String title) => _title = title;
  String get publishtime => _publishtime;
  set publishtime(String publishtime) => _publishtime = publishtime;
  int get timestamp => _timestamp;
  set timestamp(int timestamp) => _timestamp = timestamp;
  String get originalsource => _originalsource;
  set originalsource(String originalsource) => _originalsource = originalsource;
  int get type => _type;
  set type(int type) => _type = type;
  String get url => _url;
  set url(String url) => _url = url;
  int get imgsnum => _imgsnum;
  set imgsnum(int imgsnum) => _imgsnum = imgsnum;
  String get scheme => _scheme;
  set scheme(String scheme) => _scheme = scheme;
  String get radiosrc => _radiosrc;
  set radiosrc(String radiosrc) => _radiosrc = radiosrc;
  List<String> get imgs => _imgs;
  set imgs(List<String> imgs) => _imgs = imgs;
  String get extend => _extend;
  set extend(String extend) => _extend = extend;
  int get rendertype => _rendertype;
  set rendertype(int rendertype) => _rendertype = rendertype;
  String get videosrc => _videosrc;
  set videosrc(String videosrc) => _videosrc = videosrc;

  Data.fromJson(Map<String, dynamic> json) {
    _docid = json['docid'];
    _title = json['title'];
    _publishtime = json['publishtime'];
    _timestamp = json['timestamp'];
    _originalsource = json['originalsource'];
    _type = json['type'];
    _url = json['url'];
    _imgsnum = json['imgsnum'];
    _scheme = json['scheme'];
    _radiosrc = json['radiosrc'];
    _imgs = json['imgs'].cast<String>();
    _extend = json['extend'];
    _rendertype = json['rendertype'];
    _videosrc = json['videosrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docid'] = this._docid;
    data['title'] = this._title;
    data['publishtime'] = this._publishtime;
    data['timestamp'] = this._timestamp;
    data['originalsource'] = this._originalsource;
    data['type'] = this._type;
    data['url'] = this._url;
    data['imgsnum'] = this._imgsnum;
    data['scheme'] = this._scheme;
    data['radiosrc'] = this._radiosrc;
    data['imgs'] = this._imgs;
    data['extend'] = this._extend;
    data['rendertype'] = this._rendertype;
    data['videosrc'] = this._videosrc;
    return data;
  }
}
