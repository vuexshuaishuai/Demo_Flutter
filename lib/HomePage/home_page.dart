import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;

class HomePage extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          Text("ele.me"),
          Text("选择城市"),
        ],
      )),
      body:Container(
        color:Color.fromRGBO(245, 245, 245, 1),
        child:Column(
          children: <Widget>[
            CurrentCity(),
            BeiJingCity(),
          ],
        )
      ),
    );
  }
}

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
                fontWeight: FontWeight.bold,
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

class _BeiJingCityState extends State<BeiJingCity> {
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
      guess = jsonResponse['name'];
      print(this.guess);
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
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(
              "北京",
              style: TextStyle(
                fontSize: 22.0,
                color:Color.fromRGBO(49, 144, 232, 1)
              ),
            ),
            Icon(
              Icons.chevron_right,
              size:25.0,
              color:Color.fromRGBO(153, 153, 153, 1)
            ),
            ElevatedButton(
              onPressed: (){
                this._getData();
              },
              child: Text("按钮")
            ),
          ],
        ),
    );
  }
}