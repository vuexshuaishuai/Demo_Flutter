import "package:dio/dio.dart";

class LogInterceptors extends Interceptor {
  //请求拦截
  @override 
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    print("请求接口地址:" + options.baseUrl + options.path);
    print("请求方式:" + options.method);
    print("请求头:");
    print(options.headers);   //请求头不是String类型,故不可以拼接字符串
    print("请求参数");
    if(options.queryParameters == null){
      print(options.data);
    }else{
      print(options.queryParameters);
    }
    return super.onRequest(options, handler);
  }
  //响应拦截
  @override 
  Future onResponse(Response response, ResponseInterceptorHandler handler){
    print("返回Code:");
    print(response.statusCode);
    print("返回值:" + response.data);
    return onResponse(response, handler);
  }

  //报错拦截
  @override 
  Future onError(DioError err, ErrorInterceptorHandler handler){
    print("错误返回Code:");
    print(err.response.statusCode);  //错误返回的code值为int类型,故不能拼接S听类型的字符
    print("错误返回值:" + err.response.data);
    return onError(err, handler);
  }
}