import 'CommonHttpRequest.dart';
class HomeRequest {
  static requestMovieList(int start) async {
    // 1.构建URL
    final movieURL = "http://appapitest.chinaso.com/general/v1/search/image?q=%E6%95%85%E4%BA%8B";
    // 2.发送网络请求获取结果
    final result = await CommonHttpRequest.getHttp(movieURL);

  }
}