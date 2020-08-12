import 'package:flutter_app1/http/img_result_entity.dart';

imgResultEntityFromJson(ImgResultEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['data'] != null) {
		data.data = new ImgResultData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> imgResultEntityToJson(ImgResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['msg'] = entity.msg;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

imgResultDataFromJson(ImgResultData data, Map<String, dynamic> json) {
	if (json['arrRes'] != null) {
		data.arrRes = new List<ImgResultDataArrRe>();
		(json['arrRes'] as List).forEach((v) {
			data.arrRes.add(new ImgResultDataArrRe().fromJson(v));
		});
	}
	if (json['total'] != null) {
		data.total = json['total']?.toInt();
	}
	if (json['nextIndex'] != null) {
		data.nextIndex = json['nextIndex']?.toInt();
	}
	if (json['correctionResults'] != null) {
		data.correctionResults = new List<dynamic>();
		data.correctionResults.addAll(json['correctionResults']);
	}
	return data;
}

Map<String, dynamic> imgResultDataToJson(ImgResultData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.arrRes != null) {
		data['arrRes'] =  entity.arrRes.map((v) => v.toJson()).toList();
	}
	data['total'] = entity.total;
	data['nextIndex'] = entity.nextIndex;
	if (entity.correctionResults != null) {
		data['correctionResults'] =  [];
	}
	return data;
}

imgResultDataArrReFromJson(ImgResultDataArrRe data, Map<String, dynamic> json) {
	if (json['smallimage'] != null) {
		data.smallimage = json['smallimage']?.toString();
	}
	if (json['largeimage'] != null) {
		data.largeimage = json['largeimage']?.toString();
	}
	if (json['web_url'] != null) {
		data.webUrl = json['web_url']?.toString();
	}
	if (json['docid'] != null) {
		data.docid = json['docid']?.toString();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	if (json['ImageInfo'] != null) {
		data.imageInfo = json['ImageInfo']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['host'] != null) {
		data.host = json['host']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['summary'] != null) {
		data.summary = json['summary']?.toString();
	}
	return data;
}

Map<String, dynamic> imgResultDataArrReToJson(ImgResultDataArrRe entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['smallimage'] = entity.smallimage;
	data['largeimage'] = entity.largeimage;
	data['web_url'] = entity.webUrl;
	data['docid'] = entity.docid;
	data['time'] = entity.time;
	data['ImageInfo'] = entity.imageInfo;
	data['url'] = entity.url;
	data['host'] = entity.host;
	data['title'] = entity.title;
	data['summary'] = entity.summary;
	return data;
}