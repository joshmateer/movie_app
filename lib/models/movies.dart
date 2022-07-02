import 'package:flutter/material.dart';
import 'package:movie_app/models/current_boxoffice.dart';
import 'package:movie_app/models/imdbMovie.dart';
import 'package:movie_app/models/top_250_film.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class Movies with ChangeNotifier {
  List<Top250Film> _top250Films = [];
  List<Top250Film> _top250TV = [];
  List<Movi> _imdbMovies = [];
  List<BoxOfficeMovie> _currentBoxOffice = [];
  List<Movi> _imdbMoviesFilter = [];

  Future<void> fetchImdbData() async {
    final top250Filmurl =
        Uri.parse('https://imdb-api.com/en/API/Top250Movies/k_ukib21ut');
    final top250TVurl =
        Uri.parse('https://imdb-api.com/en/API/Top250TVs/k_ukib21ut');
    final currentBoxOfficeurl =
        Uri.parse('https://imdb-api.com/en/API/BoxOffice/k_ukib21ut');
    try {
      final top250FilmResponse = await http.get(top250Filmurl);
      final top250FilmData = top250FromJson(top250FilmResponse.body);

      final top250TVResponse = await http.get(top250TVurl);
      final top250TVData = top250FromJson(top250TVResponse.body);

      final currentBoxOfficeResponse = await http.get(currentBoxOfficeurl);
      final currentBoxOfficeData =
          boxofficeMovieFromJson(currentBoxOfficeResponse.body);

      _top250Films = top250FilmData.items;
      _top250TV = top250TVData.items;
      _currentBoxOffice = currentBoxOfficeData.items!;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addImdbTitle(
      String id, bool isStreaming, String? platform) async {
    final url = Uri.parse('https://imdb-api.com/en/API/Title/k_ukib21ut/$id');
    try {
      final response = await http.get(url);
      final data = movieFromJson(response.body);

      _imdbMovies.add(data);
      await FirebaseFirestore.instance.collection('/titles_imdb').add({
        'id': id,
        'isStreaming': isStreaming,
        'platform': platform,
      });
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndSetMovies() async {
    final result =
        await FirebaseFirestore.instance.collection('/titles_imdb').get();
    List<Movi> list = [];
    final favoriteResult = await FirebaseFirestore.instance
        .collection('/users')
        .doc('/${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    final ratingResult = await FirebaseFirestore.instance
        .collection('/users')
        .doc('/${FirebaseAuth.instance.currentUser!.uid}')
        .get();

    result.docs.forEach((el) async {
      final id = el.data()['id'];
      final isStreaimg = el.data()['isStreaming'];
      final platform = el.data()['platform'];

      final url = Uri.parse('https://imdb-api.com/en/API/Title/k_ukib21ut/$id');
      try {
        final response = await http.get(url);
        final data = movieFromJson(response.body);
        data.isFavorite = favoriteResult.data()?['${id}_favorites'] == null
            ? false
            : favoriteResult.data()?['${id}_favorites'];
        data.userRating = ratingResult.data()?['${id}_ratings'] == null
            ? 0
            : ratingResult.data()?['${id}_ratings'];
        data.isStreaming = isStreaimg;
        data.platform = platform;

        list.add(data);
        notifyListeners();
      } catch (error) {
        print(error);
      }
    });
    _imdbMovies = list;
    _imdbMoviesFilter = list;
  }

  void filterTitles(List<String> genres) {
    _imdbMoviesFilter = _imdbMovies
        .where((movie) =>
            genres.every((filterGenre) => movie.genres!.contains(filterGenre)))
        .toList();
    notifyListeners();
  }

  List<Movi> get imdbMovies {
    return [..._imdbMovies];
  }

  List<Movi> get imdbMoviesFilter {
    return [..._imdbMoviesFilter];
  }

  List<Top250Film> get top250films {
    return [..._top250Films];
  }

  List<Top250Film> get top250TV {
    return [..._top250TV];
  }

  List<BoxOfficeMovie> get currentBoxOffice {
    return [..._currentBoxOffice];
  }
}
