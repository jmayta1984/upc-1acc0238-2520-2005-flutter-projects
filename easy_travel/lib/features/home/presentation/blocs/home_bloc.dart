import 'dart:async';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationService service;
  HomeBloc({required this.service}) : super(HomeState()) {
    on<GetDestinationsByCategory>(_getDestinationsByCategory);
  }

  FutureOr<void> _getDestinationsByCategory(
    GetDestinationsByCategory event,
    Emitter<HomeState> emit,
  ) async {

    if (state.selectedCategory == event.category && state.destinations.isNotEmpty) {
      return;
    }

    emit(state.copyWith(isLoading: true, selectedCategory: event.category));

    try {
      final destinations = await service.getDestinations(event.category);
      emit(state.copyWith(isLoading: false, destinations: destinations));
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }
}
