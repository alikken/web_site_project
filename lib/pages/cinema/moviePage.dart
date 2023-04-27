import 'package:flutter/material.dart';
import 'package:mobileapp/models/movie.dart';

import '../../controllers/home_controller.dart';

// class MoviePage extends StatefulWidget {
//   final HomeController _homeController = HomeController();

//   @override
//   State<MoviePage> createState() => _MoviePageState();
// }

// class _MoviePageState extends State<MoviePage> {
//   List<Movie> _MovieList = [];

//   @override
//   void initState() {
//     super.initState();
//     widget._homeController.getMovie().then((listMovie) {
//       setState(() {
//         _MovieList = listMovie;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: listMovie.length,
//                     itemBuilder: (context, index) {
//                       final itemMovie =
//                           listMovie[listMovie.length - index - 1];

//                       return Container(
//                         margin: const EdgeInsets.all(10),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: const Color.fromRGBO(255, 255, 255, 1),
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     HallListScreen(cinema: itemTheater.id),
//                               ),
//                             );
//                           },
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: NetworkImage(itemTheater.image),
//                                     fit: BoxFit.cover,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       itemTheater.cinema,
//                                       style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Container(
//                                       height: 1,
//                                       width: double.infinity,
//                                       color: Colors.black,
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Text(
//                                       itemTheater.address,
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                       textAlign: TextAlign.left,
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.black),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Text(
//                                       itemTheater.city,
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                       textAlign: TextAlign.left,
//                                       style: const TextStyle(
//                                           fontSize: 12, color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//         ],
//       ),
//     );
//   }
// }

class MoviePage extends StatefulWidget {
  final HomeController _homeController = HomeController();

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Movie> _movieList = [];

  @override
  void initState() {
    super.initState();
    widget._homeController.getMovie().then((listMovie) {
      setState(() {
        _movieList = listMovie;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _movieList.length,
              itemBuilder: (context, index) {
                final movie = _movieList[_movieList.length - index - 1];

                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.img),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.genre
                                    .map((genre) => genre.title)
                                    .join(", "),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
