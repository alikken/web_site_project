import 'package:mobileapp/models/movie.dart';

// class ShowMovie {
//   List<Movie> movie;
//   String time_show;

//   ShowMovie({
//     required this.movie,
//     required this.time_show,
//   });

//   factory ShowMovie.fromJson(Map<String, dynamic> json) {
//     List<Movie> movie = [];

//     List<dynamic> movieJson = json['movie'];
//     movieJson.forEach(
//       (element) {
//         Movie item = Movie.fromJson(element);
//         movie.add(item);
//       },
//     );
//     return ShowMovie(
//       movie: movie,
//       time_show: json['time_show']
//     );
//   }
// }



class ShowMovie {
  List<Movie> movie;
  String time_show;

  ShowMovie({
    required this.movie,
    required this.time_show,
  });

  factory ShowMovie.fromJson(Map<String, dynamic> json) {
    List<Movie> movie = [];

    dynamic movieJson = json['movie'];
    if (movieJson is List) {
      movieJson.forEach(
        (element) {
          Movie item = Movie.fromJson(element);
          movie.add(item);
        },
      );
    } else {
      Movie item = Movie.fromJson(movieJson);
      movie.add(item);
    }

    return ShowMovie(
      movie: movie,
      time_show: json['time_show'],
    );
  }
}

