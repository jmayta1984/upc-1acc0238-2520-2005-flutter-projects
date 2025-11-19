import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/domain/comment.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_state.dart';
import 'package:easy_travel/features/home/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final Comment comment = state.comments[index];
                return CommentCard(comment: comment);
              },
            );
          case Status.failure:
            return Center(child: Text(state.message ?? 'Unknown error'));
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
