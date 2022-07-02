import 'package:flutter/material.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.movie}) : super(key: key);
  final Movi movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        movie: movie,
      ),
    );
  }
}
