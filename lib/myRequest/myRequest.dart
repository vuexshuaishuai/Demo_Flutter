library httpmanager;

export "myService.dart";
export "Result.dart";
export "TargetType.dart";

import 'dart:convert';
import "package:dio/dio.dart";
import "Log_Interceptors.dart";
import "TargetType.dart";

//默认的header中的 content-type 为 application/json
class HttpManager {
  Dio dio;
  var baseUrl = "https://elm.cangdu.org";
  var connectTimeout = 15000;

  //单例：工厂模式
  factory HttpManager() => _getInstance();
  static HttpManager get instance => _getInstance();
  static HttpManager _instance;
  HttpManager._internal(){
    //初始化
  }

  // * 核心请求代码:
  static HttpManager _getInstance(){
    if(_instance == null){
      _instance = HttpManager._internal();
      //初始化Dio
      _instance.dio = new Dio();
      //添加拦截器
      // _instance.dio.interceptors.add(LogInterceptors());
    }
    return _instance;
  }
  //请求功能
  request(TargetType targetType) async{
    //请求
    try{
      var response;
      //设置请求头
      Map<String, dynamic> httpHeaders;
      //如果请求头不为空
      if(targetType.headers.keys.toList().length != 0) httpHeaders = targetType.headers; 
      //设置基础请求配置:统一请求路径、请求时长
      var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        headers: httpHeaders,
      );
      dio.options = options;
      //判断请求方式
      switch (targetType.method){
        case MSNetServiceMethod.POST:
          options.method = "POST";
        break;
        case MSNetServiceMethod.GET:
          options.method = "GET";
        break;
        case MSNetServiceMethod.PATCH:
          options.method = "PATCH";
        break;
        case MSNetServiceMethod.UPLOAD:
          options.method = "UPLOAD";
        break;
        case MSNetServiceMethod.DELETE:
          options.method = "DELETE";
        break;
        case MSNetServiceMethod.DOWNLOAD:
          options.method = "DOWNLOAD";
        break;
      }
      //配置请求参数:查看是否传参
      //有传参：判断传参方式
      if(targetType.parameters != null){
        switch(targetType.encoding){
          //如果是FORM请求
          case ParameterEncoding.URLEncoding:
            // print(targetType.path);
            // print(targetType.parameters);
            response = await dio.request(targetType.path, queryParameters: targetType.parameters);
            // print(response);
          break;
          //如果是BODY请求
          case ParameterEncoding.BodyEncoding:
            response = await dio.request(targetType.path, data: targetType.parameters);
          break;
        }
      //无传参：直接请求
      }else{
        response = await dio.request(targetType.path);
      }
      print("flutter接口请求");
      // return json.decode(response.toString());
      return response;
    }catch(exception){

      print("来到了失败");
      return exception;
    }
  }
}



final HttpManager httpManager = HttpManager.instance;
