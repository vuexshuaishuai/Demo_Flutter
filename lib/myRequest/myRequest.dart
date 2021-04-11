import "package:dio/dio.dart";
import "dart:async";

class Request {
  // Dio默认参数配置
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://elm.cangdu.org',
      connectTimeout: 10000,
      receiveTimeout: 3000,
    )
  );
  //请求
  static Future<Map>  myRequest(String url, {Map data,String method}) async{
    //默认设置：如果参数为空则为{}
    data = data?? {};
    //默认设置：如果请求方法为空则为get请求
    method = method ?? 'get';

    var result;
    try{
      Response response = await dio.request(
        url,
        options:Options(
          method: method,
          headers: {}
        ),
        data:data
      );
      result = response;
    } catch(err) {
      print("请求出错" + err.toString());
    }
    return result;
  }
}