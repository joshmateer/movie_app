// To parse this JSON data, do
//
//     final top250 = top250FromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Top250 top250FromJson(String str) => Top250.fromJson(json.decode(str));

String top250ToJson(Top250 data) => json.encode(data.toJson());

class Top250 with ChangeNotifier {
  Top250({
    required this.items,
    required this.errorMessage,
  });

  List<Top250Film> items;
  String errorMessage;

  factory Top250.fromJson(Map<String, dynamic> json) => Top250(
        items: List<Top250Film>.from(
            json["items"].map((x) => Top250Film.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Top250Film {
  Top250Film({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });

  String id;
  String rank;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  factory Top250Film.fromJson(Map<String, dynamic> json) => Top250Film(
        id: json["id"],
        rank: json["rank"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        image: json["image"],
        crew: json["crew"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
