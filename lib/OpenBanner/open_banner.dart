import "../SpaceChange/HomePage/home_page.dart";
import "package:flutter/material.dart";

class BannerScreen extends StatefulWidget {
  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override 
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => route == null
        );
      }
    });
    _controller.forward(); //播放动画
  }

  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        "images/banner.png",
        scale:2.0,
        fit:BoxFit.fill
      ),
    );
  }
}