import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/home_controller.dart';
import 'package:mobileapp/pages/auth/login.dart';

import '../main.dart';


class Registration extends StatefulWidget {

  @override
  State<Registration> createState() => _RegistrationState();
  final HomeController _homeController = HomeController();
}

class _RegistrationState extends State<Registration> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  String error = '';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top: 30.0),

              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Имя пользователя',
                    hintText: 'Введите верное имя пользователя'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Почта',
                    hintText: 'Введите почту'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
              child: TextFormField(
                controller: password1Controller,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Пароль',
                    hintText: 'Введите ваш пароль'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
              child: TextFormField(
                controller: password2Controller,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Повторите пароль',
                    hintText: 'Введите ваш пароль повторно'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0
                  ),
              child: Text(error, style: TextStyle(color: Colors.red),),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String email = emailController.text;
                  String password1 = password1Controller.text;
                  String password2 = password2Controller.text;
                 
                  String _error = await widget._homeController.registerUser(username, email, password1, password2);

                  if (_error=='YES\n'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  }
                  setState(() {
                    error = _error;
                  });
                },
                child: Text(
                  'Регистрация',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  'Вход',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
