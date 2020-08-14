import 'package:flutter_app1/constant/constant.dart';

class ServiceUrl{
  // 请求成功
  static const API_CODE_SUCCESS = "200";
  static String getImgResult=Constant.baseUrl+"general/v1/search/image";
  static String getYoungResult=Constant.baseUrl+"general/v1/search/youlist";
  static String getStoryResult=Constant.baseUrl+"general/v1/search/story";
}
