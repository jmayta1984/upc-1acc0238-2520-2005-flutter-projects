import 'dart:async';
import 'package:easy_travel/core/enums/status.dart';
import 'package:easy_travel/features/home/data/comment_service.dart';
import 'package:easy_travel/features/home/domain/comment.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentService service;
  CommentBloc({required this.service}) : super(CommentState()) {
    on<GetCommentsByDestination>(_getCommentsByDestination);

    on<AddComment>(_addComment);
  }

  FutureOr<void> _getCommentsByDestination(
    GetCommentsByDestination event,
    Emitter<CommentState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<Comment> comments = await service.getCommentsByDestination(event.id);
      emit(state.copyWith(status: Status.success, comments: comments));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  FutureOr<void> _addComment(
    AddComment event,
    Emitter<CommentState> emit,
  ) async {

    try {
      await service.addComment(
        event.destinationId,
        event.comment,
        event.rating,
      );
      List<Comment> comments = await service.getCommentsByDestination(
        event.destinationId,
      );
      emit(state.copyWith(status: Status.success, comments: comments));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
