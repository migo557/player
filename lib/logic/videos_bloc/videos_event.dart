part of 'videos_bloc.dart';

// Events
sealed class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class VideosLoadEvent extends VideosEvent {}
