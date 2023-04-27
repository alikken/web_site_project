import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobileapp/storage/storage.dart';
import 'auth/login.dart';
import 'cinema/cinema.dart';
import 'cinema/moviePage.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SecureStorage storage = SecureStorage();
  String? _username = "";
  //navbar
  int currentPage = 0;
  List<Widget> pages = [
    TheaterPage(),
    MoviePage(),
    Scaffold(),
  ];

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
                if (button_text == 'Выйти') {
                  storage.deleteData();
                  setState(() {
                    hello_text = 'Вы вышли';
                    button_text = 'Войти';
                  });
                } else {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login()));
                }
              },
              child: Text(button_text))
        ],
      ),
      body: pages[currentPage], // направление страниц navbar

      bottomNavigationBar: Container(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.lightBlue,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                currentPage = index;
              });
              print(index);
            },
            selectedIndex: currentPage,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.theaters_sharp,
                text: "Кинотеатры",
              ),
              GButton(
                icon: Icons.movie,
                text: "Фильмы",
              ),
              GButton(
                icon: Icons.list,
                text: "Мои билеты",
              ),
            ],
          ),
        ),
      ),
    );
  }
}