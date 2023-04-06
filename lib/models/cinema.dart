

class Theater {
  int id;
  String cinema;
  String address;
  String city;
  // image?
  Theater(
      {required this.id,
      required this.cinema,
      required this.address,
      required this.city});
  factory Theater.fromJson(Map<String, dynamic> json) {
    return Theater(
        id: json['id'],
        cinema: json['cinema'],
        address: json['address'],
        city: json['city']);
  }
}

