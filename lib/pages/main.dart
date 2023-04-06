import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/home_controller.dart';
import 'package:mobileapp/models/cinema.dart';
import 'package:mobileapp/storage/storage.dart';

import 'auth/login.dart';

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

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//               appBar: AppBar(
//           backgroundColor: Colors.lightBlue,
//           title: const Text('Кинотеатры'),
//               ),
//     );
//   }
// }

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
    // print("TTTTTTTTTTTT: ${_userID.first.key}: ${_userID.first.value}");
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
        // drawer: Drawer(
        //   child: Scaffold(

        //   ),
        // ),
        body: Center(
          child: TextButton(
            child: Text('страница'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TheaterPage()));
            },
          ),
        ));
  }
}

class TheaterPage extends StatefulWidget {
  final HomeController _homeController = HomeController();
  @override
  _TheaterPageState createState() => _TheaterPageState();
}

class _TheaterPageState extends State<TheaterPage> {
  List<Theater> _listTheater = [];

  @override
  void initState() {
    super.initState();
    widget._homeController.getTheater().then((listTheater) {
      setState(() {
        _listTheater = listTheater;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _listTheater.length,
        itemBuilder: (context, index) {
          final itemTheater = _listTheater[_listTheater.length - index - 1];
          print('fsdfsdfsdfsdfsdfsdfsfsdfsdfsdfsdfs ${_listTheater}');
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Colors.cyan[100],
            child: Column(children: [
              Text(
                itemTheater.cinema,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                itemTheater.address,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.left,
              ),
            ]),
          );
        },
      ),
    );
  }
}
