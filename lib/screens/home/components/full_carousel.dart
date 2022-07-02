import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/home/components/genres.dart';
import 'movie_carousel.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';

class FullCarousellScreen extends StatelessWidget {
  FullCarousellScreen({Key? key, required this.isManage, this.filters})
      : super(key: key);
  var isManage;
  List<String>? filters;

  @override
  Widget build(BuildContext context) {
    final allMovies = Provider.of<Movies>(context).imdbMoviesFilter;
    final inTheatres = allMovies
        .where((movi) =>
            (DateTime.now().difference(movi.releaseDate!).inDays < 90) &&
            movi.type! == 'Movie' &&
            movi.releaseDate!.isBefore(DateTime.now()) &&
            movi.isStreaming == false)
        .toList();
    final comingSoon = allMovies
        .where((movi) => movi.releaseDate!.isAfter(DateTime.now()))
        .toList();
    final streaming = allMovies
        .where((movi) =>
            movi.type! == 'TVSeries' ||
            movi.isStreaming == true &&
                movi.releaseDate!.isBefore(DateTime.now()))
        .toList();
    final other = allMovies
        .where((movi) =>
            movi.type! == 'Movie' &&
            (DateTime.now().difference(movi.releaseDate!).inDays > 90) &&
            movi.releaseDate!.isBefore(DateTime.now()) &&
            movi.isStreaming == false)
        .toList();
    return Column(
      children: [
        Genres(filters: filters!),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: kDefaultPadding),
                SizedBox(
                    child: Text('In Theatres',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kTextColor,
                            ))),
                MovieCarousel(
                  movieSet: 'movie',
                  isManage: isManage,
                  imdbMovies: inTheatres,
                ),
                SizedBox(height: kDefaultPadding),
                Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                    child: Text('Streaming',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kTextColor,
                            ))),
                MovieCarousel(
                  movieSet: 'streaming',
                  isManage: isManage,
                  imdbMovies: streaming,
                ),
                SizedBox(height: kDefaultPadding),
                Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                    child: Text('Coming Soon',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kTextColor,
                            ))),
                MovieCarousel(
                  movieSet: 'upcoming',
                  isManage: isManage,
                  imdbMovies: comingSoon,
                ),
                SizedBox(height: kDefaultPadding),
                SizedBox(
                    child: Text('All Movies',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kTextColor,
                            ))),
                MovieCarousel(
                  movieSet: 'movie',
                  isManage: isManage,
                  imdbMovies: other,
                ),
                SizedBox(height: kDefaultPadding),
                Divider(
                  endIndent: 50,
                  indent: 50,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
