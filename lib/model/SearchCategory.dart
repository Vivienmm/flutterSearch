
class SearchCategory  {
  int id;
  String cname;



  SearchCategory({this.id, this.cname});

  SearchCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cname = json['cname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cname'] = this.cname;
    return data;
  }

  @override
  String toString() {
    return 'SearchCategory{id: $id, cname: $cname}';
  }


}