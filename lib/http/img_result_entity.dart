import 'package:flutter_app1/generated/json/base/json_convert_content.dart';
import 'package:flutter_app1/generated/json/base/json_filed.dart';

class ImgResultEntity with JsonConvert<ImgResultEntity> {
	int status;
	String msg;
	ImgResultData data;
}

class ImgResultData with JsonConvert<ImgResultData> {
	List<ImgResultDataArrRe> arrRes;
	int total;
	int nextIndex;
	List<dynamic> correctionResults;
}

class ImgResultDataArrRe with JsonConvert<ImgResultDataArrRe> {
	String smallimage;
	String largeimage;
	@JSONField(name: "web_url")
	String webUrl;
	String docid;
	String time;
	@JSONField(name: "ImageInfo")
	String imageInfo;
	String url;
	String host;
	String title;
	String summary;
}
