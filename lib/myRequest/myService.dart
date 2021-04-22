import "myRequest.dart";
import "TargetType.dart";

class Api {
  static getCurrentCity(params){
    return TargetType().config(
      path: "/v1/cities",
      headers:{},
      method: MSNetServiceMethod.GET,
      parameters: params,
      encoding: ParameterEncoding.URLEncoding
    );
  }
}

final HttpManager httpManager = HttpManager.instance;
