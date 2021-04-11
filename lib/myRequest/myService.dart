import "./myRequest.dart";

// 获取当前城市
getCurrentCity() async{
  return await Request.myRequest(
    "/v1/cities",
    data:{'type':'guess'},
    method:'get'
  );
}
