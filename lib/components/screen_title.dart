import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.all(kDefaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: kTextColor,
                ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 50,
            height: 6,
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
