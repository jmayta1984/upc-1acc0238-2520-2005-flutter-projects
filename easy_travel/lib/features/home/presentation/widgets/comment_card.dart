import 'package:easy_travel/features/home/domain/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  final int rating = comment.rating;
                  return Icon(
                    rating > index ? Icons.star : Icons.star_border,
                    size: 16,
                    color: rating > index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  );
                }),
              ),
              Spacer(),
              Text(DateFormat.yMMMd().format(comment.date)),
            ],
          ),
          Text(comment.comment),
          Text(comment.userName, style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
