import 'package:flutter/material.dart';
import 'package:mobileapp/pages/news/news.dart';

import 'main.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top:50.0,left: 20.0),

            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "ЖКХ",
                  style:TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlue[300],
                  ),
                  //textAlign: TextAlign.left,
                ),

              ],
            ),

          ),

        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => NewsPage()));
          },
          leading: Icon(
            Icons.newspaper,
            color: Colors.black,
          ),
          title:Text(
              "Новости"
          ),

        ),
        ListTile(
          onTap: (){},
          leading: Icon(
            Icons.report,
            color: Colors.black,
          ),
          title:Text(
              "Написать жалобу"
          ),

        ),
        ListTile(
          onTap: (){},
          leading: Icon(
            Icons.payments,
            color: Colors.black,
          ),
          title:Text(
              "Счета"
          ),

        ),ListTile(
          onTap: (){},
          leading: Icon(
            Icons.folder_copy,
            color: Colors.black,
          ),
          title:Text(
              "Мои жалобы"
          ),

        ),ListTile(
          onTap: (){},
          leading: Icon(
            Icons.receipt_long,
            color: Colors.black,
          ),
          title:Text(
              "Квитанции"
          ),
        ),ListTile(
          onTap: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MyApp()));
          },
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title:Text(
              "ГЛАВНАЯ"
          ),
        ),
      ],
    );
  }
}