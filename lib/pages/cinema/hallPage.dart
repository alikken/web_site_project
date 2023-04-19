import 'package:flutter/material.dart';
import 'package:mobileapp/models/hall.dart';

import '../../controllers/home_controller.dart';

// class HallPage extends StatefulWidget {
//   final HomeController _homeController = HomeController();

//   HallPage({super.key});

//   @override
//   State<HallPage> createState() => _HallPageState();
// }

// class _HallPageState extends State<HallPage> {
//   List<Hall> _listHall = [];

//   @override
//   void initState() {
//     super.initState();

//     widget._homeController.getHall().then((listHall) {
//       setState(() {
//         _listHall = listHall;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final itemHall = _listHall[_listHall.length-index-1];
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue,
//         title: const Text('ЖКХ услуги'),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: ListView.builder(
//           itemCount: _listHall.length,
//           itemBuilder: (context, index) {
//             final itemHall = _listHall[_listHall.length - index - 1];
//             return Container(
//               alignment: Alignment.center,
//               child: Text(
//                 itemHall.name,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




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
                return ListTile(
                  title: Text(hall.name),
                  subtitle: Text('${hall.row_count} x ${hall.col_count}'),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
