
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsapp/screens/HomeScreen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 2;
  bool loggedvalue = true;

  @override
  void initState() {
    super.initState();

    _loadWidget();
    getLoginValue();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  getLoginValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool checkValue = prefs.containsKey('loggedValue');
    setState(() {
      loggedvalue = checkValue;
    });
    return checkValue;
  }

  void navigationPage() {
    debugPrint("Logged in value $loggedvalue");
    // bool logval=getLoginValue();
    loggedvalue ?  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: HomeScreen(),
          inheritTheme: true,
          ctx: context),
    ) : Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: LoginScreen(),
          inheritTheme: true,
          ctx: context),
    );



  }

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 10.0,
      child: Column(
        children: [

          Container(
              margin: const EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: const Offset(0, 10), // changes position of shadow
                ),
              ], color: const Color(0xF9F5F5F5), shape: BoxShape.circle),
              child: ImageAsset()),
          const Text(
            'YouMovies',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0x6678909c),
              fontSize: 30,
              shadows: [
                Shadow(
                  blurRadius: 6.0,
                  color: Colors.white24,
                  offset: Offset(2.0, 1.0),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}



class ImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('images/movie.png');
    Image image = Image(image: assetImage, width: 300.0, height: 350.0);
    return Container(
      child: image,
    );

  }
}

