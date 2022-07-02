import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class loginButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  const loginButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: kSecondaryColor),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}
