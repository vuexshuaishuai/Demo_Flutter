import "package:flutter/material.dart";
import "CurrentCity/current_city.dart";
import "HotCity/hot_city.dart";
import "AllCity/all_city.dart";

class HomePage extends StatelessWidget {
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          Text("ele.me"),
          Text("选择城市",style:TextStyle(fontSize: 16.0)),
        ],
      )),
      body:Container(
        color:Color.fromRGBO(245, 245, 245, 1),
        child:ListView(
          children: <Widget>[
            CurrentCity(),
            BeiJingCity(),
            HotCity(),
            AllCity(),
          ],
        )
      ),
    );
  }
}
