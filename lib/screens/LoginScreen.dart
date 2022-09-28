import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
          child: const Text("Login with yout Google Account"),
          onPressed: () {
            _googleSignIn.signIn().then((userData) {
              setState(() {
                _userObj = userData!;
              });
              updateLog(_userObj.email);
            }).catchError((e) {
              debugPrint(e);
            });
          },
        ),
      ),
    );
  }

  updateLog(String emailid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", emailid);
    prefs.setBool('loggedValue', true);
    navigationtoPinScreen();
  }

  void navigationtoPinScreen() {
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: HomeScreen(),
          inheritTheme: true,
          ctx: context),
    );
  }
}
