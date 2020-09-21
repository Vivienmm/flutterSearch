import 'package:dio/dio.dart';
//import 'search_img_entity.dart';
import 'dart:convert';
class CommonHttpRequest {
  static final Dio dio = Dio();

  static void getHttp(String url) async {
    try {
      Response response = await dio.get(url);
      print(response.data.toString());

    } catch (e) {
      print(e);
    }
  }

//
//  static  Future<T> request<T>(String url, {
//    String method = "get",
//    Map<String, dynamic> params
//  }) async {
//    // 1.创建单独配置
//    final options = Options(method: method);
//
//    // 2.发送网络请求
//    try {
//      Response response = await dio.request(url, queryParameters: params, options: options);
//
//     // Map data = json.decode(response.toString());
//
//    //  ImgResult articleBean = ImgResult.fromJson(data);
//      print(response.toString());
//      return future;
//    } on DioError catch(e) {
//      return Future.error(e);
//    }
//  }

}