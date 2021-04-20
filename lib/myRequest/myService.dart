import "myRequest.dart";
import "TargetType.dart";

class Api {
  static getCurrentCity(){
    return TargetType().config(
      path: "/v1/cities",
      headers:{},
      method: MSNetServiceMethod.GET,
      parameters: {"type":"guess"},
      encoding: ParameterEncoding.URLEncoding
    );
  }
}

final HttpManager httpManager = HttpManager.instance;
