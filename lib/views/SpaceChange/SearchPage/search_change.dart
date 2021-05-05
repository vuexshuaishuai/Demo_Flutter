import 'dart:convert';

import 'package:demo_element/myRequest/myService.dart';
import "package:flutter/material.dart";
import "../../../myRequest/myRequest.dart";

class SearchPage extends StatefulWidget {
  //接收参数
  final Map city;
  SearchPage({Key key,@required this.city}):super(key:key);
  //默认
  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage>{
  List aroundCitys = [];
  //输入框
  TextEditingController searchPlace = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  //接口返回列表
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child:Icon(
                Icons.navigate_before,
                size:30.0,
                color:Colors.white,
              ),
            ),
            Text(
              widget.city['name'],
              textAlign: TextAlign.center,
              style:TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color:Colors.white
              ),
            ),
            Text(
              "切换城市",
              textAlign: TextAlign.center,
              style:TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color:Colors.white
              ),
            )
          ],
        ),
        automaticallyImplyLeading:false,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color:Color.fromRGBO(245, 245, 245, 1)
          ),
          child:Column(
            children: <Widget> [
              //搜索框 & 提交按钮
              Container(
                width:double.infinity,
                height:110.0,
                decoration: BoxDecoration(
                  color:Color.fromRGBO(255, 255, 255, 1)
                ),
                margin:EdgeInsets.only(top: 10.0),
                padding:EdgeInsets.symmetric(vertical:10.0, horizontal:20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SearchField(searchPlace:searchPlace,searchFocusNode:searchFocusNode),
                    SearchButton(cityId: widget.city['id'], searchPlace: searchPlace, 
                    getCitysCallBack:(list){
                      setState((){
                        aroundCitys = list;
                      });
                    },
                    ),
                  ],
                ),
              ),
              //搜索列表
              AroundSpace(aroundCitys:aroundCitys),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchField extends StatefulWidget {
  var searchPlace;
  var searchFocusNode;
  SearchField({Key key, @required this.searchPlace, this.searchFocusNode}):super(key:key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState(){
    super.initState();
    widget.searchFocusNode.addListener((){
      if(!widget.searchFocusNode.hasFocus){
        this.setState(() {
          print(widget.searchPlace);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36.0,
      decoration: BoxDecoration(
        border: Border.all(
          width:1.0,
          color:Color.fromRGBO(228, 228, 228, 1)
        ),
      ),
      child:TextField(
        controller: widget.searchPlace,
        focusNode: widget.searchFocusNode,
        onChanged: (text){
          print(text);
          return text;
        },
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          filled: true,  // * 必须含有该属性背景色才会生效
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          contentPadding: EdgeInsets.symmetric(vertical:0,horizontal:10.0),
          border:OutlineInputBorder(
            borderSide: BorderSide.none
          ),
          //placeholder文字
          hintText: "请输入您当前位置",
        ),
      )
    );
  }
}


//搜索按钮
class SearchButton extends StatefulWidget {
  var cityId;
  var searchPlace;
  final ValueChanged getCitysCallBack;
  SearchButton({Key key, @required this.cityId, this.searchPlace, this.getCitysCallBack}):super(key:key);
  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      height:38.0,
      child:ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(2.0)
            )
          ),
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          var params = {
            'type': 'search',
            'city_id': widget.cityId,
            'keyword': widget.searchPlace.text,
          };
          var result = await HttpManager.instance.request(Api.getVagueSpace(params));
          widget.getCitysCallBack(result.data);
        }, 
        child: Text("提交")
      )
    );
  }
}

class AroundSpace extends StatefulWidget {
  //搜索返回列表
  final List aroundCitys;

  AroundSpace({Key key, @required this.aroundCitys}):super(key:key);
  @override
  _AroundSpaceState createState() => _AroundSpaceState();
}

class _AroundSpaceState extends State<AroundSpace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border:Border(top: BorderSide(
          width:1.0,
          color:Color.fromRGBO(228, 228, 228, 1)
        ))
      ),
      child: Column(
        children: widget.aroundCitys.map((item){
          return Column(
            children: [
              Container(
                width:double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border:Border(bottom: BorderSide(
                    width:1.0,
                    color:Color.fromRGBO(228, 228, 228, 1)
                  )),
                  color:Color.fromRGBO(255, 255, 255, 1),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child:Text(
                        "${item['name']}",
                        style:TextStyle(
                          fontSize: 16.0
                        ),
                      )
                    ),
                    Container(
                      margin:const EdgeInsets.only(top:5.0),
                      child:Text(
                        "${item['address']}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                          fontSize: 14.0,
                          color:Color.fromRGBO(153, 153, 153, 1)
                        ),
                      )
                    ),
                  ],
                )
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}