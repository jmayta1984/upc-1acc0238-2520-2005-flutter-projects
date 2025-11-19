import 'package:easy_travel/features/home/domain/destination.dart';
import 'package:easy_travel/features/home/presentation/widgets/comment_list.dart';
import 'package:flutter/material.dart';

class DestinationDetailPage extends StatelessWidget {
  const DestinationDetailPage({super.key, required this.destination});
  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave a comment',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  maxLines: 2,
                  minLines: 2,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(onPressed: (){}, icon: Icon(Icons.star_border));
                  }),
                ),
                FilledButton(onPressed: (){}, child:Text('Submit'))
              ],
            ),
          ),
          Expanded(child: CommentList()),
        ],
      ),
    );
  }
}
