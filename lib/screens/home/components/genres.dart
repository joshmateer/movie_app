import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/components/genre_card.dart';

class Genres extends StatefulWidget {
  Genres({Key? key, required this.filters}) : super(key: key);
  List<String> filters;

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  
  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      'Action',
      'Crime',
      'Comedy',
      'Drama',
      'Horror',
      'Animation',
      'Thriller',
      'Biography',
      'Music',
      'Sci-Fi',
      'Fantasy',
      'Mystery',
    ];

    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (ctx, i) => GenreCard(
          genre: genres[i],
          filters: widget.filters,
        ),
      ),
    );
  }
}
