class Theater {
  int id;
  String cinema;
  String address;
  String city;

  String image;
  String image_detail;
  String info;

  Theater(
      {required this.id,
      required this.cinema,
      required this.address,
      required this.city,
      required this.image,
      required this.image_detail,
      required this.info
      });
  factory Theater.fromJson(Map<String, dynamic> json) {
    return Theater(
        id: json['id'],
        cinema: json['cinema'],
        address: json['address'],
        city: json['city'],
        image: json['image'],
        image_detail: json['image_detail'],
        info: json['info']);
  }
}

class TheaterDetail {}
