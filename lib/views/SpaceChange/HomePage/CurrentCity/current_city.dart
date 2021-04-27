import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "../../SearchPage/search_change.dart";
import "../../../../myRequest/myRequest.dart";
import "package:dio/dio.dart";

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
  @override
  void initState(){
    super.initState();
    this._getData();
  }
  void _getData() async{
    var url = Uri.https("elm.cangdu.org", "/v1/cities",{"type":"guess"});
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.guess = jsonResponse['name'];
      });
    }else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage(city:this.guess)));
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