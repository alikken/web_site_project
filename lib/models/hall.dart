import 'package:mobileapp/models/showMovie.dart';

// class Hall {
//   int id;
//   String cinema;
//   List<ShowMovie> show_movie;
//   String name;
//   int row_count;
//   int col_count;

//   Hall({
//     required this.id,
//     required this.cinema,
//     required this.show_movie,
//     required this.name,
//     required this.row_count,
//     required this.col_count,
//   });

//   factory Hall.fromJson(Map<String, dynamic> json) {
//     List<ShowMovie> show_movie = [];
//     // List<dynamic> dynamicShowMovie = List<dynamic>.from(show_movie);

//     List<dynamic> show_movieJson = json['show_movie'];
//     show_movieJson.forEach(
//       (element) {
//         ShowMovie item = ShowMovie.fromJson(element);
//         show_movie.add(item);
//       },
//     );

//     return Hall(
//       id: json['id'],
//       cinema: json['cinema'],
//       show_movie: show_movie,
//       name: json['name'],
//       row_count: json['row_count'],
//       col_count: json['col_count'],
//     );
//   }
// }


class Hall {
  int id;
  String cinema;  //List<Cinema> cinema
  List<ShowMovie> show_movie;
  String name;
  int row_count;
  int col_count;

  Hall({
    required this.id,
    required this.cinema,
    required this.show_movie,
    required this.name,
    required this.row_count,
    required this.col_count,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    List<ShowMovie> show_movie = [];

    List<dynamic> show_movieJson = json['show_movie'];
    show_movieJson.forEach(
      (element) {
        ShowMovie item = ShowMovie.fromJson(Map<String, dynamic>.from(element));
        show_movie.add(item);
      },
    );

    return Hall(
      id: json['id'],
      cinema: json['cinema'],
      show_movie: show_movie,
      name: json['name'],
      row_count: json['row_count'],
      col_count: json['col_count'],
    );
  }
}
