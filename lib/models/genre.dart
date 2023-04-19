class Genre {
  String title;

  Genre({
    required this.title,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(title: json['title']);
  }
}
