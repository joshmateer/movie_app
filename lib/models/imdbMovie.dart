import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Movi movieFromJson(String str) => Movi.fromJson(json.decode(str));

class Movi with ChangeNotifier {
  Movi({
    this.id,
    this.title,
    this.originalTitle,
    this.fullTitle,
    this.type,
    this.year,
    this.image,
    this.releaseDate,
    this.runtimeMins,
    this.runtimeStr,
    this.plot,
    this.plotLocal,
    this.plotLocalIsRtl,
    this.awards,
    this.directors,
    this.directorList,
    this.writers,
    this.writerList,
    this.stars,
    this.starList,
    this.actorList,
    this.fullCast,
    this.genres,
    this.genreList,
    this.companies,
    this.companyList,
    this.countries,
    this.countryList,
    this.languages,
    this.languageList,
    this.contentRating,
    this.imDbRating,
    this.imDbRatingVotes,
    this.metacriticRating,
    this.ratings,
    this.wikipedia,
    this.posters,
    this.images,
    this.trailer,
    this.boxOffice,
    this.tagline,
    this.keywords,
    this.keywordList,
    this.similars,
    this.tvSeriesInfo,
    this.tvEpisodeInfo,
    this.errorMessage,
    required this.isFavorite,
    required this.userRating,
    this.isStreaming,
    this.platform,
  });

  String? id;
  String? title;
  String? originalTitle;
  String? fullTitle;
  String? type;
  String? year;
  String? image;
  DateTime? releaseDate;
  String? runtimeMins;
  String? runtimeStr;
  String? plot;
  String? plotLocal;
  bool? plotLocalIsRtl;
  String? awards;
  String? directors;
  List<CompanyListElement>? directorList;
  String? writers;
  List<CompanyListElement>? writerList;
  String? stars;
  List<CompanyListElement>? starList;
  List<ActorList>? actorList;
  dynamic fullCast;
  List<String>? genres;
  List<CountryListElement>? genreList;
  String? companies;
  List<CompanyListElement>? companyList;
  String? countries;
  List<CountryListElement>? countryList;
  String? languages;
  List<CountryListElement>? languageList;
  String? contentRating;
  String? imDbRating;
  String? imDbRatingVotes;
  String? metacriticRating;
  dynamic ratings;
  dynamic wikipedia;
  dynamic posters;
  dynamic images;
  dynamic trailer;
  BoxOffice? boxOffice;
  dynamic tagline;
  String? keywords;
  List<String>? keywordList;
  List<Similar>? similars;
  dynamic tvSeriesInfo;
  dynamic tvEpisodeInfo;
  dynamic errorMessage;
  bool isFavorite;
  int userRating;
  bool? isStreaming;
  String? platform;

  factory Movi.fromJson(Map<String, dynamic> json) => Movi(
        id: json["id"],
        title: json["title"],
        originalTitle: json["originalTitle"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        image: json["image"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        plotLocal: json["plotLocal"],
        plotLocalIsRtl: json["plotLocalIsRtl"],
        awards: json["awards"],
        directors: json["directors"],
        directorList: List<CompanyListElement>.from(
            json["directorList"].map((x) => CompanyListElement.fromJson(x))),
        writers: json["writers"],
        writerList: List<CompanyListElement>.from(
            json["writerList"].map((x) => CompanyListElement.fromJson(x))),
        stars: json["stars"],
        starList: List<CompanyListElement>.from(
            json["starList"].map((x) => CompanyListElement.fromJson(x))),
        actorList: List<ActorList>.from(
            json["actorList"].map((x) => ActorList.fromJson(x))),
        fullCast: json["fullCast"],
        genres: (json["genres"].split(', ')),
        genreList: List<CountryListElement>.from(
            json["genreList"].map((x) => CountryListElement.fromJson(x))),
        companies: json["companies"],
        companyList: List<CompanyListElement>.from(
            json["companyList"].map((x) => CompanyListElement.fromJson(x))),
        countries: json["countries"],
        countryList: List<CountryListElement>.from(
            json["countryList"].map((x) => CountryListElement.fromJson(x))),
        languages: json["languages"],
        languageList: List<CountryListElement>.from(
            json["languageList"].map((x) => CountryListElement.fromJson(x))),
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingVotes: json["imDbRatingVotes"],
        metacriticRating: json["metacriticRating"],
        ratings: json["ratings"],
        wikipedia: json["wikipedia"],
        posters: json["posters"],
        images: json["images"],
        trailer: json["trailer"],
        boxOffice: BoxOffice.fromJson(json["boxOffice"]),
        tagline: json["tagline"],
        keywords: json["keywords"],
        keywordList: List<String>.from(json["keywordList"].map((x) => x)),
        similars: List<Similar>.from(
            json["similars"].map((x) => Similar.fromJson(x))),
        tvSeriesInfo: json["tvSeriesInfo"] == null
            ? json["tvSeriesInfo"]
            : TvSeriesInfo?.fromJson(json["tvSeriesInfo"]),
        tvEpisodeInfo: json["tvEpisodeInfo"],
        errorMessage: json["errorMessage"],
        isFavorite: false,
        userRating: 0,
        isStreaming: false,
        platform: '',
      );

  Future<void> toggleFavoriteStatus(String userId) async {
    isFavorite = !isFavorite;
    try {
      final response = await FirebaseFirestore.instance
          .collection('/users')
          .doc('/${userId}')
          .set({'${id}_favorites': isFavorite}, SetOptions(merge: true));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> setUserRating(int rating) async {
    userRating = rating;
    notifyListeners();
    try {
      final response = await FirebaseFirestore.instance
          .collection('/users')
          .doc('/${FirebaseAuth.instance.currentUser!.uid}')
          .set({'${id}_ratings': userRating}, SetOptions(merge: true));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

class ActorList {
  ActorList({
    this.id,
    this.image,
    this.name,
    this.asCharacter,
  });

  String? id;
  String? image;
  String? name;
  String? asCharacter;

  factory ActorList.fromJson(Map<String, dynamic> json) => ActorList(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        asCharacter: json["asCharacter"],
      );
}

class BoxOffice {
  BoxOffice({
    this.budget,
    this.openingWeekendUsa,
    this.grossUsa,
    this.cumulativeWorldwideGross,
  });

  String? budget;
  String? openingWeekendUsa;
  String? grossUsa;
  String? cumulativeWorldwideGross;

  factory BoxOffice.fromJson(Map<String, dynamic> json) => BoxOffice(
        budget: json["budget"],
        openingWeekendUsa: json["openingWeekendUSA"],
        grossUsa: json["grossUSA"],
        cumulativeWorldwideGross: json["cumulativeWorldwideGross"],
      );
}

class CompanyListElement {
  CompanyListElement({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory CompanyListElement.fromJson(Map<String, dynamic> json) =>
      CompanyListElement(
        id: json["id"],
        name: json["name"],
      );
}

class CountryListElement {
  CountryListElement({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory CountryListElement.fromJson(Map<String, dynamic> json) =>
      CountryListElement(
        key: json["key"],
        value: json["value"],
      );
}

class Similar {
  Similar({
    this.id,
    this.title,
    this.image,
    this.imDbRating,
  });

  String? id;
  String? title;
  String? image;
  String? imDbRating;

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imDbRating: json["imDbRating"],
      );
}

class TvSeriesInfo {
  TvSeriesInfo({
    this.yearEnd,
    this.creators,
    this.creatorList,
    this.seasons,
  });

  String? yearEnd;
  String? creators;
  List<CompanyListElement>? creatorList;
  List<String>? seasons;

  factory TvSeriesInfo.fromJson(Map<String, dynamic> json) => TvSeriesInfo(
        yearEnd: json["yearEnd"],
        creators: json["creators"],
        creatorList: List<CompanyListElement>.from(
            json["creatorList"].map((x) => CompanyListElement.fromJson(x))),
        seasons: List<String>.from(json["seasons"].map((x) => x)),
      );
}
