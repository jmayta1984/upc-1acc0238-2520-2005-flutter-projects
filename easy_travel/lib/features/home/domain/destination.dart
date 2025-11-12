class Destination {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final bool isFavorite;

  const Destination({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    this.isFavorite = false,
  });

  Destination copyWith({bool? isFavorite}) {
    return Destination(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Destination.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) throw ('id is null');
    if (json['title'] == null) throw ('title is null');
    if (json['overview'] == null) throw ('overview is null');
    if (json['posterPath'] == null) throw ('posterPath is null');

    return Destination(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['posterPath'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'overview': overview,
    };
  }

  factory Destination.fromMap(Map<String, dynamic> map) {
    return Destination(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
    );
  }
}
