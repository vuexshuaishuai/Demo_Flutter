enum MSNetServiceMethod {
  POST,
  GET,
  PATCH,
  DELETE,
  UPLOAD,
  DOWNLOAD
}

enum ParameterEncoding {
  //参数放在URL中
  URLEncoding,
  //参数放在BODY中
  BodyEncoding
}

class TargetType {
  //接口地址
  String path;
  //请求方式 
  MSNetServiceMethod method;
  //参数
  Object parameters;
  //参数位置
  ParameterEncoding encoding;
  //请求头
  Map headers;
  config({String path, MSNetServiceMethod method, Object parameters, ParameterEncoding encoding, Map headers}){
    this.path = path;
    this.method = method;
    if(parameters != null){
      this.parameters = parameters;
      this.encoding = encoding;
    }
    if(headers != null){
      this.headers = headers;
    }
    return this;
  }
}