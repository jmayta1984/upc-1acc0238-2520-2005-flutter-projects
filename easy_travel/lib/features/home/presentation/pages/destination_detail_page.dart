import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_event.dart';
import 'package:easy_travel/features/home/presentation/widgets/comment_list.dart';
import 'package:easy_travel/features/home/presentation/widgets/comment_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addComment(context);
        },
        child: Icon(Icons.add_comment),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: destination.id,
            child: Image.network(
              destination.posterPath,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Expanded(child: CommentList()),
        ],
      ),
    );
  }

  void _addComment(BuildContext context) {
    int rating = 0;
    String comment = '';
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Leave a comment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    onChanged: (value) => comment = value,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    maxLines: 2,
                  ),
                  CommentRating(onRatingSelected: (value) => rating = value),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<CommentBloc>().add(
                            AddComment(
                              destinationId: destination.id,
                              comment: comment,
                              rating: rating,
                            ),
                          );
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
