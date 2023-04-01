import 'package:flutter/material.dart';
import 'package:mobileapp/storage/storage.dart';

import 'MainDrawer.dart';
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
        }
        else {
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
        title: const Text('ЖКХ услуги'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                if (button_text == 'Выход') {
                  storage.deleteData();
                  setState(() {
                    hello_text = 'Вы вышли';
                    button_text = 'Вход';
                  });
                }
                else {
                  Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                }
              },
              child: Text(button_text))
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: 
         Center(
            child: 
                Text(hello_text), // ${widget.username}
          )
    );
  }
}
