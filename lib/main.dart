import "package:flutter/material.dart";
import "views/OpenBanner/open_banner.dart";

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context){
    return MaterialApp(
      title:"Good",
      home:BannerScreen(),
      debugShowMaterialGrid: false,
    );
  }
}
