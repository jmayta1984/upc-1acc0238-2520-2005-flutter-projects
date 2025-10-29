class Destination {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

  const Destination({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['posterPath'],
    );
  }
}
