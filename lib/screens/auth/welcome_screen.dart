import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/auth/auth_screen.dart';
import './components/login_button.dart';
import 'package:animations/animations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        loginButton(
            text: 'Login',
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AuthScreen(isLogin: true),
              ));
              // PageTransitionSwitcher(transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              //   return FadeThroughTransition(animation: primaryAnimation, secondaryAnimation: secondaryAnimation, child: child,);
              // }, child: AuthScreen(isLogin: true),);
            },
            color: kSecondaryColor,
            textColor: Colors.white),
        loginButton(
            text: 'Signup',
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AuthScreen(isLogin: false),
              ));
              // PageTransitionSwitcher(transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              //   return FadeThroughTransition(animation: primaryAnimation, secondaryAnimation: secondaryAnimation, child: child,);
              // }, child: AuthScreen(isLogin: false),);
            },
            color: Colors.white,
            textColor: kSecondaryColor),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ]),
    );
  }
}
