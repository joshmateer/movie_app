import 'dart:convert';

BoxOfficeItem boxofficeMovieFromJson(String str) => BoxOfficeItem.fromJson(json.decode(str));

String boxofficeMovieToJson(BoxOfficeItem data) => json.encode(data.toJson());

class BoxOfficeItem {
    BoxOfficeItem({
        this.items,
        this.errorMessage,
    });

    List<BoxOfficeMovie>? items;
    String? errorMessage;

    factory BoxOfficeItem.fromJson(Map<String, dynamic> json) => BoxOfficeItem(
        items: List<BoxOfficeMovie>.from(json["items"].map((x) => BoxOfficeMovie.fromJson(x))),
        errorMessage: json["errorMessage"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "errorMessage": errorMessage,
    };
}

class BoxOfficeMovie {
    BoxOfficeMovie({
        this.id,
        this.rank,
        this.title,
        this.image,
        this.weekend,
        this.gross,
        this.weeks,
    });

    String? id;
    String? rank;
    String? title;
    String? image;
    String? weekend;
    String? gross;
    String? weeks;

    factory BoxOfficeMovie.fromJson(Map<String, dynamic> json) => BoxOfficeMovie(
        id: json["id"],
        rank: json["rank"],
        title: json["title"],
        image: json["image"],
        weekend: json["weekend"],
        gross: json["gross"],
        weeks: json["weeks"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "title": title,
        "image": image,
        "weekend": weekend,
        "gross": gross,
        "weeks": weeks,
    };
}
