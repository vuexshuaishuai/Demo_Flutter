import 'dart:convert';

import "package:flutter/material.dart";
import "../../SearchPage/search_change.dart";
import "../../../../myRequest/myRequest.dart";

class CurrentCity extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Center(
      child:Container(
        width:double.infinity,
        height:50.0,
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        decoration: BoxDecoration(
          border:Border(bottom: BorderSide(width: 2, color:Color.fromRGBO(228, 228, 228, 1))),
          color:Colors.white,
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(
              "当前定位城市",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              "定位不准时，请在城市列表中选择",
              style:TextStyle(
                color:Color.fromRGBO(159, 159, 159, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BeiJingCity extends StatefulWidget {
  @override
  _BeiJingCityState createState() => _BeiJingCityState();
}

class _BeiJingCityState extends State<BeiJingCity> with AutomaticKeepAliveClientMixin {
  String guess = "";
  Map currentData;
  @override
  void initState(){
    super.initState();
    this._getData();
  }
  void _getData() async{
    var res = await HttpManager.instance.request(Api.getCurrentCity({'type':'guess'}));
    var changeDecodeData = json.decode(res.toString());
    setState(() {
      this.guess = changeDecodeData['name'];
      this.currentData = changeDecodeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    //因为使用了AutomaticKeepAliveClientMixin方法 所以这里必须实现以下super
    super.build(context);
    return Container(
      width:double.infinity,
      height:50.0,
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      decoration: BoxDecoration(
        border:Border(bottom: BorderSide(width: 2, color:Color.fromRGBO(228, 228, 228, 1))),
        color:Colors.white,
      ),
      child:InkWell(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage(city:this.currentData)));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(
              this.guess,
              style: TextStyle(
                fontSize: 20.0,
                color:Color.fromRGBO(49, 144, 232, 1)
              ),
            ),
            // ElevatedButton(
            //   onPressed: () async{
            //     var res = await HttpManager.instance.request(Api.getCurrentCity({'type':'guess'}));
            //     print("----");
            //     print(res);
            //     // convert.jsonDecode(res).data
            //     // print(res.data.runtimeType.toString());
            //   }, 
            //   child: Text("点击")
            // ),
            Icon(
              Icons.chevron_right,
              size:25.0,
              color:Color.fromRGBO(153, 153, 153, 1)
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}