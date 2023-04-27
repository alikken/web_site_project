class CreateSeat {
  int row;
  int col;
  bool is_busy;

  CreateSeat({
    required this.row,
    required this.col,
    required this.is_busy,
  });


  Map<String, dynamic> toDatabaseJson() =>{
    "row": row,
    "col": col,
    "is_busy": is_busy,
    };

}
