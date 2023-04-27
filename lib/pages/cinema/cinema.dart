import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import '../../models/cinema.dart';
import 'hallPage.dart';





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