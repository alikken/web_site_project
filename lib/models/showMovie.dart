import 'package:mobileapp/models/movie.dart';

class ShowMovie {
  Movie movie;
  String time_show;

  ShowMovie({
    required this.movie,
    required this.time_show,
  });

  factory ShowMovie.fromJson(Map<String, dynamic> json) {
    dynamic movieJson = json['movie'];
    Movie movie = Movie.fromJson(movieJson);

    return ShowMovie(
      movie: movie,
      time_show: json['time_show'],
    );
  }
}
