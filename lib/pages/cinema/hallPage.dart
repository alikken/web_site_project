import 'package:flutter/material.dart';
import 'package:mobileapp/models/hall.dart';

import '../../controllers/home_controller.dart';

class HallListScreen extends StatefulWidget {
  final HomeController _homeController = HomeController();
  final int cinema;

  HallListScreen({Key? key, required this.cinema}) : super(key: key);

  @override
  _HallListScreenState createState() => _HallListScreenState();
}

class _HallListScreenState extends State<HallListScreen> {
  List<Hall> _hallList = [];

  @override
  void initState() {
    super.initState();
    _loadHallList();
  }

  Future<void> _loadHallList() async {
    List<Hall> hallList = await widget._homeController.getHall(widget.cinema);
    setState(() {
      _hallList = hallList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список залов'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  'http://192.168.1.6:8000/media/media/p1000x1000_RvQb8LD.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _hallList.isNotEmpty
                ? ListView.builder(
                    itemCount: _hallList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Hall hall = _hallList[index];
                      String cinemaName = hall.cinema.cinema;
                      String cinemaDescription = hall.cinema.info;
                      String cinemaImageUrl = hall.cinema.image_detail;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              cinemaName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              cinemaDescription,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Сеансы:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // здесь можно добавить список сеансов
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SeatSelection(hall: hall),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hall.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        hall.show_movie[0].movie.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}

class SeatSelection extends StatefulWidget {
  final HomeController _homeController = HomeController();
  final Hall hall;

  SeatSelection({required this.hall});
  @override
  State<SeatSelection> createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<Map<String, dynamic>> _seatStatusList = [];

  @override
  void initState() {
    super.initState();

    // Заполняем массив информацией о занятых местах в зале
    for (int i = 0; i < widget.hall.row_count; i++) {
      for (int j = 0; j < widget.hall.col_count; j++) {
        _seatStatusList.add({
          'row': i + 1,
          'seat': j + 1,
          'is_busy': false,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выберите места')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: _seatStatusList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.hall.col_count,
              ),
              itemBuilder: (BuildContext context, int index) {
                // Получаем информацию о текущем месте
                final seatInfo = _seatStatusList[index];

                // Определяем цвет кнопки в зависимости от того, занято место или нет
                final buttonColor =
                    seatInfo['is_busy'] ? Colors.red : Colors.green;

                return Container(
                  margin: EdgeInsets.all(4),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        // Изменяем статус места при нажатии на кнопку
                        _seatStatusList[index]['is_busy'] =
                            !_seatStatusList[index]['is_busy'];
                      });
                    },
                    icon: Icon(
                      Icons.chair,
                      color: seatInfo['is_busy'] ? Colors.red : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              final selectedSeats =
                  _seatStatusList.where((seat) => seat['is_busy']).toList();
              final row = selectedSeats[0]['row'] as int;
              final col = selectedSeats[0]['col'] as int;
              final isBusy = selectedSeats[0]['is_busy'] as bool;

              String reply = await widget._homeController
                  .CreateBookingSeat(row, col, isBusy);

              // Сохраняем результаты выбора мест

              print('${selectedSeats}');
              Navigator.push(context, reply as Route<Object?>);
            },
            child: Text('Занять места'),
          ),
        ],
      ),
    );
  }
}
