import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'cast_card.dart';

class CastAndCrew extends StatelessWidget {
  const CastAndCrew({Key? key, required this.casts}) : super(key: key);
  final List<ActorList> casts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Text(
            'Cast & Crew',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: kDefaultPadding),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: casts.length,
              itemBuilder: (ctx, i) => CastCard(
                cast: casts[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}