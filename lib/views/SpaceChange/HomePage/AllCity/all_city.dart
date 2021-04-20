import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "../../SearchPage/search_change.dart";

class AllCity extends StatefulWidget {
  @override
  _AllCityState createState() => _AllCityState();
}

class _AllCityState extends State<AllCity> with AutomaticKeepAliveClientMixin{
  List titles = [];
  Map groupData = {};
  @override 
  void initState() { 
    super.initState();
    this._getAllCity();
  }
  _getAllCity() async{
    var url = Uri.https("elm.cangdu.org","/v1/cities",{"type":"group"});
    var res = await http.get(url);
    if(res.statusCode == 200){
      var jsonRes = convert.jsonDecode(res.body);
      setState(() {
        this.groupData = jsonRes;
        jsonRes.forEach((key,value){
          this.titles.add(key);
        });
        this.titles.sort((a,b) => a.compareTo(b));
      });
    }else{
      print(res.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: this.titles.map((item){
          return ModelCity(item:item,spaceData: groupData,);
        }).toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ModelCity extends StatelessWidget {
  final String item;
  final Map spaceData;
  ModelCity({Key key,@required this.item,this.spaceData}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.fromLTRB(0, 0, 0, 15.0),
      child:Column(
        children: [
          Container(
            width:double.infinity,
            height:50.0,
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            decoration: BoxDecoration(
              border: Border(top:BorderSide(width: 2.0, color:Color.fromRGBO(228, 228, 228, 1))),
              color:Colors.white,
            ),
            child:Row(
              children: [
                Text(
                  this.item,
                  style:TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border:Border.all(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1)),
              color:Colors.white,
            ),
            child:Wrap(
            children: this.spaceData[item].map<Widget>((value){
              return FractionallySizedBox(
                widthFactor: 0.25,
                child:InkWell(
                  onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage(city:value['name'])));
                  },
                  child:Container(
                    width: double.infinity,
                    height: 50.0,
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    decoration: BoxDecoration(
                      border:Border(
                        right:(this.spaceData[item].indexOf(value)+1) % 4 != 0?BorderSide(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1)):BorderSide(width: 0,color:Colors.white),
                        bottom:this.spaceData[item].length - this.spaceData[item].indexOf(value) + 1 >= (this.spaceData[item].length % 4) ? 
                                BorderSide(width: 1.0, color:Color.fromRGBO(228, 228, 228, 1)) : 
                                BorderSide(width: 1.0,color:Colors.white),
                      ),
                      color:Colors.white
                    ),
                    child: Center(child:Text(
                      "${value['name']}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color:Color.fromRGBO(49, 144, 232, 1),
                      ),
                    )),
                  )
                ),
              );
            }).toList(),
          ),
          ),
        ],
      ),
    );
  }
}