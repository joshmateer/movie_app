import 'package:flutter/material.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'movie_card.dart';
import 'dart:math' as math;
import 'package:movie_app/constants.dart';

class MovieCarousel extends StatefulWidget {
  MovieCarousel(
      {Key? key,
      required this.movieSet,
      required this.isManage,
      required this.imdbMovies})
      : super(key: key);
  String movieSet;
  String categoryFilter = '';
  bool isManage;
  List<Movi> imdbMovies;

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  PageController? _pageController;
  int initialPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: AspectRatio(
        aspectRatio: 0.85,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              initialPage = value;
            });
          },
          controller: _pageController,
          physics: ClampingScrollPhysics(),
          itemCount: widget.imdbMovies.length,
          itemBuilder: (ctx, i) => buildMovieSlider(i, widget.imdbMovies),
        ),
      ),
    );
  }

  Widget buildMovieSlider(int i, List<Movi> movies) => AnimatedBuilder(
        animation: _pageController!,
        builder: (ctx, child) {
          double value = 0;
          if (_pageController!.position.haveDimensions) {
            value = i - _pageController!.page!;
            value = (value * 0.038).clamp(-1, 1);
          }
          return AnimatedOpacity(
            duration: Duration(milliseconds: 350),
            opacity: initialPage == i ? 1 : 0.4,
            child: Transform.rotate(
              angle: math.pi * value,
              child: MovieCard(movie: movies[i], isManage: widget.isManage),
            ),
          );
        },
      );
}
