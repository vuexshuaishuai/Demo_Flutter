import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "../../SearchPage/search_change.dart";

class HotCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child:Column(
        children: [
          Container(
            width:double.infinity,
            height:50.0,
            padding:const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            decoration: BoxDecoration(
              border:Border(top:BorderSide(width: 2.0, color:Color.fromRGBO(228, 228, 228, 1))),
              color:Colors.white
            ),
            child:Row(
              children: [
                Text("热门城市")
              ],
            ),
          ),
          Cities(),
        ],
      ),
    );
  }
}

class Cities extends StatefulWidget {
  
  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> with AutomaticKeepAliveClientMixin {
  List spaceData = [];
  @override
  void initState(){
    super.initState();
    this._getHotCity();
  }
  _getHotCity() async{
    var url = Uri.https("elm.cangdu.org","/v1/cities",{"type":"hot"});
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.spaceData = jsonResponse;
      });
    }else{
      print(response.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      decoration: BoxDecoration(
        border:Border.all(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1))
      ),
      child:Wrap(
        children: this.spaceData.map((value){
          return FractionallySizedBox(
            widthFactor: 0.25,
            child:InkWell(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage(city:value['name'])));
              },
              child:Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  border:Border(
                    right:(this.spaceData.indexOf(value)+1) % 4 != 0?BorderSide(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1)):BorderSide(width: 0,color:Colors.white),
                    bottom:(this.spaceData.length - (this.spaceData.indexOf(value) + 1) >= this.spaceData.length % 4)?BorderSide(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1)):BorderSide(width: 0.0,color:Colors.white),
                  ),
                  color:Colors.white
                ),
                child: Center(child:Text(
                  "${value['name']}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color:Color.fromRGBO(49, 144, 232, 1)
                  ),
                )),
              )
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}