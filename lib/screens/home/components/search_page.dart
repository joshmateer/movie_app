import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:movie_app/screens/details/detail_screen.dart';
import 'package:movie_app/screens/home/components/genres.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movies.dart';
import 'package:animations/animations.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.movies, required this.filters})
      : super(key: key);
  List<Movi> movies;
  List<String> filters;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController? _controller;
  List<Movi>? allMovies;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    allMovies = Provider.of<Movies>(context, listen: false).imdbMoviesFilter;
    void filterSearch(String query) {
      var filterMovies = allMovies!
          .where((movie) =>
              movie.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        widget.movies = filterMovies;
      });
    }

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search titles...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: CloseButton(
                    onPressed: () {
                      _controller!.clear();
                      filterSearch('');
                    },
                  ),
                  prefixIcon: BackButton(),
                ),
                onChanged: ((value) {
                  filterSearch(value);
                }),
              ),
            ),
            Genres(
              filters: widget.filters,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(kDefaultPadding),
                itemCount: widget.movies.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) => OpenContainer(
                      openElevation: 0,
                      closedElevation: 0,
                      transitionDuration: Duration(milliseconds: 700),
                      closedBuilder: (context, action) =>
                          BuildSearchList(context, widget.movies, index),
                      openBuilder: (context, action) =>
                          DetailsScreen(movie: widget.movies[index]),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container BuildSearchList(
      BuildContext context, List<Movi> _movies, int index) {
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            decoration: BoxDecoration(
              boxShadow: [kDefaultShadow],
              image: DecorationImage(
                image: NetworkImage(_movies[index].image!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(right: 5, top: 10, left: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Text(
                _movies[index].title!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
