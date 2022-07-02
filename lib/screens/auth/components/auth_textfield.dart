import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.text,
    required this.icon,
    this.suffix,
    required this.obscure,
    this.inputType,
    this.onSubmitted,
    required this.onSaved,
    required this.validator,
    required this.fieldKey,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? inputType;
  final Object? onSubmitted;
  final Object onSaved;
  final Object validator;
  final Key fieldKey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      //height: size.height * 0.07,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        key: fieldKey,
        validator: validator as String? Function(String?)?,
        keyboardType: inputType,
        obscureText: obscure,
        onChanged: onSubmitted as void Function(String)?,
        onSaved: onSaved as void Function(String?)?,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          //hintStyle: TextStyle(fontWeight: FontWeight.w600),
          icon: Icon(
            icon,
            color: kSecondaryColor,
          ),
          suffixIcon: suffix,
        ),
      ),
      decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(30))),
    );
  }
}
