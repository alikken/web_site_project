import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/home_controller.dart';
import 'package:mobileapp/models/cinema.dart';
import 'package:mobileapp/storage/storage.dart';

import 'auth/login.dart';
import 'cinema/hallPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Главная страница',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SecureStorage storage = SecureStorage();
  String? _username = "";

  @override
  void initState() {
    super.initState();
    getUserID().then((String? username) {
      setState(() {
        if (username == null) {
          button_text = 'Вход';
          hello_text = 'Вы вышли';
        } else {
          _username = username.toString();
          hello_text = 'Добро пожаловать ${_username}';
          button_text = 'Выход';
        }
      });
    });
  }

  Future<String?> getUserID() async {
    _username = await storage.getUsername();
    return _username;
  }

  String button_text = '';
  String hello_text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Кинотеатр'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (button_text == 'Выход') {
                  storage.deleteData();
                  setState(() {
                    hello_text = 'Вы вышли';
                    button_text = 'Вход';
                  });
                } else {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login()));
                }
              },
              child: Text(button_text))
        ],
      ),
      body: TheaterPage(),
    );
  }
}

class TheaterPage extends StatefulWidget {
  final HomeController _homeController = HomeController();

  @override
  _TheaterPageState createState() => _TheaterPageState();
}

class _TheaterPageState extends State<TheaterPage> {
  List<Theater> _listTheater = [];
  List<String> _cities = ['Все']; // список городов для выпадающего списка
  String _selectedCity = 'Все'; // выбранный город в выпадающем списке

  @override
  void initState() {
    super.initState();
    widget._homeController.getTheater().then((listTheater) {
      setState(() {
        _listTheater = listTheater;

        // создаем список уникальных городов из списка Theater
        _cities.addAll(
            Set<String>.from(listTheater.map((theater) => theater.city)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // фильтруем список Theater по выбранному городу
    List<Theater> filteredTheater = _selectedCity == 'Все'
        ? _listTheater
        : _listTheater
            .where((theater) => theater.city == _selectedCity)
            .toList();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // выпадающий список с городами
          DropdownButton<String>(
            value: _selectedCity,
            items: _cities
                .map((city) => DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCity = value!;
              });
            },
          ),
          // список театров
          Expanded(
            child: ListView.builder(
              itemCount: filteredTheater.length,
              itemBuilder: (context, index) {
                final itemTheater =
                    filteredTheater[filteredTheater.length - index - 1];
                
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
                          builder: (context) => HallListScreen(cinema: itemTheater.id),
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
                              image: NetworkImage(itemTheater.image),
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
                                itemTheater.cinema,
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
                                itemTheater.address,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                itemTheater.city,
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
          ),
        ],
      ),
    );
  }
}




// class TheaterPage extends StatefulWidget {
//   final HomeController _homeController = HomeController();
//   @override
//   _TheaterPageState createState() => _TheaterPageState();
// }

// class _TheaterPageState extends State<TheaterPage> {
//   List<Theater> _listTheater = [];

//   @override
//   void initState() {
//     super.initState();
//     widget._homeController.getTheater().then((listTheater) {
//       setState(() {
//         _listTheater = listTheater;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: _listTheater.length,
//         itemBuilder: (context, index) {
//           final itemTheater = _listTheater[_listTheater.length - index - 1];
//           print('fsdfsdfsdfsdfsdfsdfsfsdfsdfsdfsdfs ${_listTheater}');
//           return Container(
//             margin: EdgeInsets.all(10),
//             padding: EdgeInsets.all(10),
//             color: Colors.cyan[100],
//             child: Column(children: [
//               Text(
//                 itemTheater.cinema,
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//               ),
//               Text(
//                 itemTheater.address,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 4,
//                 textAlign: TextAlign.left,
//               ),
//               Text(
//                 itemTheater.city,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 4,
//                 textAlign: TextAlign.left,
//               ),
//             ]),
//           );
//         },
//       ),
//     );
//   }
// }