import "package:flutter/material.dart";

class SearchPage extends StatelessWidget {
  final String city;
  SearchPage({Key key,@required this.city}):super(key:key);

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
              this.city,
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
    );
  }
}