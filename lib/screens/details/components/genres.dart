import 'package:flutter/material.dart';
import 'package:movie_app/components/genre_card.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:movie_app/constants.dart';

class Genres extends StatefulWidget {
  const Genres({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movi movie;
  //final Movie movie;

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    //final genresList = (widget.movie.genres!.split(','));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 36,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.movie.genres!.length,
          itemBuilder: (ctx, i) => GenreCard(genre: widget.movie.genres![i]),
        ),
      ),
    );
  }
}
