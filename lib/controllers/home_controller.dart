import 'package:mobileapp/models/cinema.dart';
import 'package:mobileapp/models/createSeat.dart';
import 'package:mobileapp/models/hall.dart';
import 'package:mobileapp/models/movie.dart';
import 'package:mobileapp/storage/storage.dart';

import '../api/api_connect.dart';
import '../api/api_models.dart';
import '../models/genre.dart';
import '../models/showMovie.dart';

class HomeController {
  Future<void> loginUser(String username, String password) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    await loginApi(userLogin);
    SecureStorage storage = SecureStorage();
    storage.addUsernameToDb(username);
  }

  Future<String> registerUser(
      String username, String email, String password1, String password2) async {
    UserRegistration userRegistration = UserRegistration(
        username: username,
        email: email,
        password1: password1,
        password2: password2);
    dynamic result = await registrationApi(userRegistration);
    String reply = '';
    if (result[0] == 'YES') {
      loginUser(username, password1);
    }
    result.forEach((element) {
      reply = reply + '${element}\n';
    });
    return reply;
  }

  Future<List<Theater>> getTheater() async {
    List<Theater> allTheater = [];
    List<dynamic> result = await theaterApi();
    result.forEach((element) {
      allTheater.add(Theater(
          id: element['id'],
          cinema: element['cinema'],
          address: element['address'],
          city: element['city'],
          image: element['image'],
          image_detail: element['image_detail'],
          info: element['info']));
    });
    return allTheater;
  }

  Future<List<Hall>> getHall(int cinema) async {
    List<Hall> hallCinema = [];
    List<dynamic> result = await hallApi(cinema);

    result.forEach((element) {
      List<dynamic> showMovieJson = element['show_movie'];
      List<ShowMovie> showMovieList =
          showMovieJson.map((e) => ShowMovie.fromJson(e)).toList();

      Theater cinema = Theater.fromJson(element['cinema']);

      hallCinema.add(Hall(
          id: element['id'],
          // cinema: element['cinema'],
          cinema: cinema,
          show_movie: showMovieList,
          name: element['name'],
          row_count: element['row_count'],
          col_count: element['col_count']));
    });

    print('HallCinema: ${hallCinema}');
    return hallCinema;
  }

  Future<List<Movie>> getMovie() async {
    List<Movie> allMovie = [];
    List<dynamic> result = await movieApi();

    result.forEach((element) {
      List<dynamic> genreJson = element['genre'];
      List<Genre> genre = [];
      genreJson.forEach((genreElement) {
        genre.add(Genre.fromJson(genreElement));
      });

      allMovie.add(Movie(
          id: element['id'],
          genre: genre,
          title: element['title'],
          img: element['img'],
          description: element['description'],
          url: element['url']));
    });
    return allMovie;
  }

  Future<String> CreateBookingSeat(int row, int col, bool is_busy) async {
    dynamic reply = '';
    if (row != null) {
      CreateSeat seat = CreateSeat(row: row, col: col, is_busy: is_busy);
      String reply = await createSeatApi(seat);
    }
    print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAAAAAAAAAAAAAAAA${reply}');
    return reply;
  }
}
