import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';

class CastCard extends StatelessWidget {
  const CastCard({Key? key, required this.cast}) : super(key: key);
  final ActorList cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: kDefaultPadding),
      width: 80,
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(cast.image!), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          Text(
            cast.name!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 2,
          ),
          SizedBox(height: kDefaultPadding / 4),
          Text(
            cast.asCharacter!,
            textAlign: TextAlign.center,
            style: TextStyle(color: kTextLightColor),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
