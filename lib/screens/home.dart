import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animation/widget/cat.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation, flapAnimation;
  AnimationController catController, flapController;

  @override
  void initState() {
    super.initState();
    flapController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    flapAnimation = Tween(
      begin: pi*0.6,
      end: pi*0.65,
    ).animate(CurvedAnimation(
      parent: flapController,
      curve: Curves.easeInOut,
    ));
    catController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    catAnimation = Tween(
      begin: -30.0,
      end: -80.0,
    ).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
    flapAnimation.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        flapController.reverse();
      }else if(status==AnimationStatus.dismissed){
        flapController.forward();
      }
    });
    flapController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animation Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animation Flutter"),
        ),
        body: GestureDetector(
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap(),
              ],
            ),
          ),
          onTap: () {
            if (catController.status == AnimationStatus.completed) {
              catController.reverse();
              flapController.forward();
            } else if (catController.status == AnimationStatus.dismissed) {
              catController.forward();
              flapController.stop();
            }
          },
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 6.0,
      child: AnimatedBuilder(
          animation: flapAnimation,
          child: Container(
            color: Colors.brown,
            height: 10.0,
            width: 125.0,
          ),
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              alignment: Alignment.topLeft,
              angle: flapAnimation.value,
            );
          }),
    );
  }

  buildRightFlap() {
    return Positioned(
      right: 6.0,
      child: AnimatedBuilder(
          animation: flapAnimation,
          child: Container(
            color: Colors.brown,
            height: 10.0,
            width: 125.0,
          ),
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              alignment: Alignment.topRight,
              angle: -flapAnimation.value,
            );
          }),
    );
  }
}
