class Comment {
  final String userName;
  final int destinationId;
  final String comment;
  final int rating;
  final DateTime date;

  const Comment({
    required this.userName,
    required this.destinationId,
    required this.comment,
    required this.rating,
    required this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userName: '${json['user']['firstName']} ${json['user']['lastName']}',
      destinationId: json['destinationId'],
      comment: json['comment'],
      rating: json['rating'],
      date: DateTime.parse(json['date']),
    );
  }
}
