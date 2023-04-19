import 'package:mobileapp/models/genre.dart';

class Movie {
  int id;
  List<Genre> genre;
  String title;
  String image;
  String description;
  String url;

  Movie({
    required this.id,
    required this.genre,
    required this.title,
    required this.image,
    required this.description,
    required this.url,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<Genre> genre = [];

    List<dynamic> genreJson = json['genre'];
    genreJson.forEach(
      (element) {
        Genre item = Genre.fromJson(element);
        genre.add(item);
      },
    );
    return Movie(
      id: json['id'],
      genre: genre,
      title: json['title'],
      image: json['image'],
      description: json['description'],
      url: json['url']
    );
  }
}
