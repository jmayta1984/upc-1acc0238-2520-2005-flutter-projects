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
    if (json['id'] == null) throw ('id is null');
    if (json['title'] == null) throw ('title is null');

    return Destination(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['posterPath'],
    );
  }
}
