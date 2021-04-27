import "package:flutter/material.dart";

class SearchPage extends StatelessWidget {
  final String city;
  SearchPage({Key key,@required this.city}):super(key:key);
  TextEditingController searchPlace = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
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
      body: Container(
        width:double.infinity,
        height:double.infinity,
        decoration: BoxDecoration(
          color:Color.fromRGBO(245, 245, 245, 1)
        ),
        child: Column(
          children: <Widget> [
            Container(
              width:double.infinity,
              height:110.0,
              decoration: BoxDecoration(
                color:Color.fromRGBO(255, 255, 255, 1)
              ),
              margin:EdgeInsets.only(top: 10.0),
              padding:EdgeInsets.symmetric(vertical:10.0, horizontal:20.0),
              child: Column(
                children: <Widget>[
                  SearchField(searchPlace:searchPlace,searchFocusNode:searchFocusNode),
                ],
              ),
            ),
          ],
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
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 36.0,
      // width:double.infinity,
      // height:double.infinity,
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
        decoration: InputDecoration(
          filled: true,  // * 必须含有该属性背景色才会生效
          fillColor: Color.fromRGBO(255, 255, 255, 1),
          contentPadding: EdgeInsets.symmetric(vertical:0,horizontal:10.0),
          border:OutlineInputBorder(
            borderSide: BorderSide.none
          ),
          // isCollapsed: true, //高度包裹
        ),
      )
    );
  }
}

class _searchPlace {
}
