abstract class CommentEvent {
  const CommentEvent();
}

class GetCommentsByDestination extends CommentEvent {
  final int id;
  const GetCommentsByDestination({required this.id});
}

class AddComment extends CommentEvent {
  final int destinationId;
  final String comment;
  final int rating;

  const AddComment({
    required this.destinationId,
    required this.comment,
    required this.rating,
  });
}
