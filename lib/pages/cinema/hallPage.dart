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
      body: _hallList.isNotEmpty
          ? ListView.builder(
              itemCount: _hallList.length,
              itemBuilder: (BuildContext context, int index) {
                Hall hall = _hallList[index];
                print(
                    'ALIKAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA${(hall.cinema.cinema)}');
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionPage(hall: hall),
                      ),
                    );
                  },
                  child: Text('Перейти на новую страницу'),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// зал
class SeatSelectionPage extends StatefulWidget {
  final Hall hall;

  SeatSelectionPage({required this.hall});
  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<List<bool>> _seats = [];

  @override
  void initState() {
    super.initState();
    // Создаем матрицу мест и заполняем ее значениями false
    _seats = List.generate(
      widget.hall.row_count,
      (i) => List.generate(widget.hall.col_count, (j) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор мест'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.hall.col_count,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: widget.hall.row_count * widget.hall.col_count,
              itemBuilder: (BuildContext context, int index) {
                final int row = (index / widget.hall.col_count).floor();
                final int col = index % widget.hall.col_count;
                return Checkbox(
                  value: _seats[row][col],
                  onChanged: (bool? value) {
                    setState(() {
                      _seats[row][col] = value!;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Сохраняем выбранные места и переходим назад на предыдущую страницу
              print(
                  'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF${_seats}');
              Navigator.pop(context, _seats);
            },
            child: Text('Выбрать'),
          ),
        ],
      ),
    );
  }
}
